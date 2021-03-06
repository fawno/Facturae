<?php
/*
  Copyright 2018, Fawno (https://github.com/fawno)

  Licensed under The MIT License
  Redistributions of files must retain the above copyright notice.

  @copyright Copyright 2018, Fawno (https://github.com/fawno)
  @license MIT License (http://www.opensource.org/licenses/mit-license.php)
*/

  namespace Fawno\Facturae;

  use DOMDocument;
  use SoapClient;
  use SoapVar;
  use RobRichards\WsePhp\WSASoap;
  use RobRichards\WsePhp\WSSESoap;
  use RobRichards\XMLSecLibs\XMLSecEnc;
  use RobRichards\XMLSecLibs\XMLSecurityDSig;
  use RobRichards\XMLSecLibs\XMLSecurityKey;

  class wsdlFACe extends SoapClient {
    protected $devel = 'https://se-face-webservice.redsara.es/facturasspp?wsdl';
    protected $wsdl = 'https://webservice.face.gob.es/facturasspp?wsdl';
    protected $private_key = null;
    protected $public_key = null;

    public function __construct ($pkcs12_file = null, $pkcs12_pass = null, $options = [], $devel = false, $ssl_verifypeer = true) {
      if ($devel) {
        $this->wsdl = $this->devel;
      }

      if (empty($options['stream_context'])) {
        $options['stream_context'] = $this->stream_context($ssl_verifypeer);
      }

      $this->set_pkcs12($pkcs12_file, $pkcs12_pass);

      return parent::__construct($this->wsdl, $options);
    }

    protected function stream_context ($ssl_verifypeer = true, $options = []) {
      $options['http']['user_agent'] = 'PHPSoapClient';
      if (!$ssl_verifypeer) {
        $options['ssl']['verify_peer'] = false;
        $options['ssl']['verify_peer_name'] = false;
        $options['ssl']['allow_self_signed'] = true;
      }

      return stream_context_create($options);
    }

    public function __doRequest ($request, $location, $action, $version, $one_way = 0) {
      $request_signed = $this->signRequest($request);

      return parent::__doRequest($request_signed, $location, $action, $version, $one_way);
    }

    public function set_pkcs12 ($pkcs12_file, $pkcs12_pass) {
      if (is_file($pkcs12_file) and !empty($pkcs12_pass)) {
        if (openssl_pkcs12_read(file_get_contents($pkcs12_file), $certs, $pkcs12_pass)) {
          $this->private_key = $certs['pkey'];
          $this->public_key = $certs['cert'];
          return true;
        }
      }
      return false;
    }

     public function nif_validation ($nif) {
      if (preg_match('~(ES)?([\w\d]{9})~', strtoupper($nif), $parts)) {
        $nif = end($parts);
        if (preg_match('~(^[XYZ\d]\d{7})([TRWAGMYFPDXBNJZSQVHLCKE]$)~', $nif, $parts)) {
          $control = 'TRWAGMYFPDXBNJZSQVHLCKE';
          $nie = ['X', 'Y', 'Z'];
          $parts[1] = str_replace(array_values($nie), array_keys($nie), $parts[1]);
          $cheksum = substr($control, $parts[1] % 23, 1);
          return ($parts[2] == $cheksum);
        } elseif (preg_match('~(^[ABCDEFGHIJKLMUV])(\d{7})(\d$)~', $nif, $parts)) {
          $checksum = 0;
          foreach (str_split($parts[2]) as $pos => $val) {
            $checksum += array_sum(str_split($val * (2 - ($pos % 2))));
          }
          $checksum = ((10 - ($checksum % 10)) % 10);
          return ($parts[3] == $checksum);
        } elseif (preg_match('~(^[KLMNPQRSW])(\d{7})([JABCDEFGHI]$)~', $nif, $parts)) {
          $control = 'JABCDEFGHI';
          $checksum = 0;
          foreach (str_split($parts[2]) as $pos => $val) {
            $checksum += array_sum(str_split($val * (2 - ($pos % 2))));
          }
          $checksum = substr($control, ((10 - ($checksum % 10)) % 10), 1);
          return ($parts[3] == $checksum);
        }
      }
      return false;
    }

    public function signRequest ($request) {
      $doc = new DOMDocument('1.0');
      $doc->loadXML($request);

      $objWSSE = new WSSESoap($doc);
      $token = $objWSSE->addBinaryToken($this->public_key);
      $objWSSE->addTimestamp();
      $objKey = new XMLSecurityKey(XMLSecurityKey::RSA_SHA1, ['type' => 'private']);
      $objKey->loadKey($this->private_key);
      $objWSSE->signSoapDoc($objKey, ['insertBefore' => false]);
      $objWSSE->attachTokentoSig($token);

      return $objWSSE->saveXML();
    }

    public function enviarFactura ($correo, $fichero_factura, $anexos = []) {
      $EnviarFacturaRequest = $this->EnviarFacturaRequest($correo, $fichero_factura, $anexos);

      return $this->__soapCall('enviarFactura', [$EnviarFacturaRequest]);
    }

    protected function EnviarFacturaRequest ($correo, $fichero_factura, $anexos = []) {
      $EnviarFacturaRequest['correo'] = $correo;
      // PHP 7.2.x identifies xml files as "text/xml" instead of "application/xml"
      $EnviarFacturaRequest['factura'] = $this->FacturaFile($fichero_factura, 'application/xml');
      $EnviarFacturaRequest['anexos'] = $this->ArrayOfAnexoFile($anexos);

      return new SoapVar((object) $EnviarFacturaRequest, SOAP_ENC_OBJECT, 'EnviarFacturaRequest', 'https://webservice.face.gob.es');
    }

    protected function FacturaFile ($filename, $mimetype = null) {
			if (empty($mimetype) and function_exists('mime_content_type')) {
				$mimetype = mime_content_type($filename);
			}

      $FacturaFile['factura'] = base64_encode(file_get_contents($filename));
			// Remove BOM in BASE64 encoding
			$FacturaFile['factura'] = preg_replace('~^77u/~', '', $FacturaFile['factura']);
      $FacturaFile['nombre'] = basename($filename);
      $FacturaFile['mime'] = $mimetype;

      return new SoapVar((object) $FacturaFile, SOAP_ENC_OBJECT, 'FacturaFile', 'https://webservice.face.gob.es');
    }

    protected function ArrayOfAnexoFile ($anexos) {
      return new SoapVar(array_map('self::AnexoFile', $anexos), SOAP_ENC_ARRAY, 'ArrayOfAnexoFile', 'https://webservice.face.gob.es');
    }

    protected function AnexoFile ($filename, $mimetype = null) {
      if (empty($mimetype) and function_exists('mime_content_type')) $mimetype = mime_content_type($filename);

      $AnexoFile['anexo'] = base64_encode(file_get_contents($filename));
      $AnexoFile['nombre'] = basename($filename);
      $AnexoFile['mime'] = $mimetype;

      return new SoapVar((object) $AnexoFile, SOAP_ENC_OBJECT, 'AnexoFile', 'https://webservice.face.gob.es');
    }
  }
