<?php
/*
  Copyright 2018, Fawno (https://github.com/fawno)

  Licensed under The MIT License
  Redistributions of files must retain the above copyright notice.

  @copyright Copyright 2018, Fawno (https://github.com/fawno)
  @license MIT License (http://www.opensource.org/licenses/mit-license.php)
*/
  declare(strict_types=1);

  namespace Fawno\Facturae;

  use DOMDocument;
  use SoapClient;
  use SoapVar;
  use RobRichards\WsePhp\WSSESoap;
  use RobRichards\XMLSecLibs\XMLSecurityKey;

  class wsdlFACe extends SoapClient {
    protected $devel = 'https://se-face-webservice.redsara.es/facturasspp?wsdl';
    protected $wsdl = 'https://webservice.face.gob.es/facturasspp?wsdl';
    protected $private_key = null;
    protected $public_key = null;

    public function __construct (?string $pkcs12_file = null, ?string $pkcs12_pass = null, array $options = [], bool $devel = false, bool $ssl_verifypeer = true) {
      $options['location'] = $options['location'] ?? ($devel ? $this->devel : $this->wsdl);

      if (empty($options['stream_context'])) {
        $options['stream_context'] = $this->stream_context($ssl_verifypeer);
      }

      if ($pkcs12_file and is_file($pkcs12_file) and $pkcs12_pass) {
        $this->set_pkcs12($pkcs12_file, $pkcs12_pass);
      }

      return parent::__construct($this->wsdl, $options);
    }

    protected function stream_context (bool $ssl_verifypeer = true, array $options = []) {
      $options['http']['user_agent'] = 'PHPSoapClient';
      if (!$ssl_verifypeer) {
        $options['ssl']['verify_peer'] = false;
        $options['ssl']['verify_peer_name'] = false;
        $options['ssl']['allow_self_signed'] = true;
      }

      return stream_context_create($options);
    }

    public function __doRequest ($request, $location, $action, $version, $oneWay = false) {
      $request_signed = $this->signRequest($request);

      return parent::__doRequest($request_signed, $location, $action, $version, $oneWay);
    }

    public function set_pkcs12 (string $pkcs12_file, string $pkcs12_pass) : bool {
      if (is_file($pkcs12_file) and !empty($pkcs12_pass)) {
        if (openssl_pkcs12_read(file_get_contents($pkcs12_file), $certs, $pkcs12_pass)) {
          $this->private_key = $certs['pkey'];
          $this->public_key = $certs['cert'];
          return true;
        }
      }
      return false;
    }

    public function signRequest (string $request) {
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

    public function SSPPFactura (string $correo, string $fichero_factura, array $anexos = []) : SoapVar {
      $SSPPFactura = [
        'correo' => $correo,
        'factura' => $this->SSPPFicheroFactura($fichero_factura),
        'anexos' => $this->ArrayOfSSPPFicheroAnexo($anexos),
      ];

      return new SoapVar((object) $SSPPFactura, SOAP_ENC_OBJECT, 'EnviarFacturaRequest', 'https://webservice.face.gob.es');
    }

    public function SSPPFicheroFactura (string $filename, ?string $mimetype = null) : SoapVar {
      if (empty($mimetype) and function_exists('mime_content_type')) {
        $mimetype = mime_content_type($filename);

        // PHP 7.2.x identifies xml files as "text/xml" instead of "application/xml"
        if ($mimetype == 'text/xml') {
          $mimetype = 'application/xml';
        }
      }

      $file = base64_encode(file_get_contents($filename));
      // Remove BOM in BASE64 encoding for FACeGV
      $file = preg_replace('~^77u/~', '', $file);

      $SSPPFicheroFactura = [
        'factura' => $file,
        'nombre' => basename($filename),
        'mime' => $mimetype,
      ];

      return new SoapVar((object) $SSPPFicheroFactura, SOAP_ENC_OBJECT, 'FacturaFile', 'https://webservice.face.gob.es');
    }

    public function ArrayOfSSPPFicheroAnexo (array $anexos) : SoapVar {
      return new SoapVar(array_map('wsdlFACe::SSPPFicheroAnexo', $anexos), SOAP_ENC_ARRAY, 'ArrayOfAnexoFile', 'https://webservice.face.gob.es');
    }

    public function SSPPFicheroAnexo (string $filename, ?string $mimetype = null) : SoapVar {
      if (empty($mimetype) and function_exists('mime_content_type')) {
        $mimetype = mime_content_type($filename);
      }

      $SSPPFicheroAnexo = [
        'anexo' => base64_encode(file_get_contents($filename)),
        'nombre' => basename($filename),
        'mime' => $mimetype,
      ];

      return new SoapVar((object) $SSPPFicheroAnexo, SOAP_ENC_OBJECT, 'AnexoFile', 'https://webservice.face.gob.es');
    }
  }
