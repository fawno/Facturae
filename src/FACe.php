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

  abstract class FACe extends SoapClient {
    public const WSDL_DEV = 'https://se-face-webservice.redsara.es/facturasspp?wsdl';
    public const WSDL     = 'https://webservice.face.gob.es/facturasspp?wsdl';

    protected string $endpoint = self::WSDL;
    protected $private_key = null;
    protected $public_key = null;

    public static function create (string $wsClassName, ?string $pkcs12 = null, ?string $pkcs12_pass = null, array $options = [], bool $devel = false, bool $ssl_verifypeer = true) : FACe {
      return new $wsClassName($pkcs12, $pkcs12_pass, $options, $devel, $ssl_verifypeer);
    }

    public function __construct (?string $pkcs12 = null, ?string $pkcs12_pass = null, array $options = [], bool $devel = false, bool $ssl_verifypeer = true) {
      $options['location'] = $options['location'] ?? ($devel ? self::WSDL_DEV : self::WSDL);
      $this->endpoint = $options['location'];

      $wsdl = $options['wsdl'] ?? $this->endpoint;

      if (empty($options['stream_context'])) {
        $options['stream_context'] = $this->stream_context($ssl_verifypeer);
      }

      if ($pkcs12 and $pkcs12_pass) {
        $this->set_pkcs12($pkcs12, $pkcs12_pass);
      }

      parent::__construct($wsdl, $options);
    }

    public function getEndpoint () : string {
      return $this->endpoint;
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

    #[\ReturnTypeWillChange]
    public function __doRequest ($request, $location, $action, $version, $oneWay = false) {
      $request_signed = $this->signRequest($request);

      return parent::__doRequest($request_signed, $location, $action, $version, $oneWay);
    }

    public function set_pkcs12 (string $pkcs12, string $pkcs12_pass) : bool {
      if (empty($pkcs12_pass)) {
        return false;
      }

      if (is_file($pkcs12)) {
        $pkcs12 = file_get_contents($pkcs12);
      }

      if (!openssl_pkcs12_read($pkcs12, $certs, $pkcs12_pass)) {
        return false;
      }

      $this->private_key = $certs['pkey'];
      $this->public_key = $certs['cert'];
      return true;
    }

    public function set_private_key (string $private_key, ?string $passphrase = null) : bool {
      $pkey = openssl_pkey_get_private($private_key, $passphrase);
      if ($pkey === false) {
        return false;
      }

      return openssl_pkey_export($pkey, $this->private_key);
    }

    public function set_public_key (string $public_key) {
      if (openssl_pkey_get_public($public_key) === false) {
        return false;
      }

      $this->public_key = $public_key;
      return true;
    }

    public function signRequest (string $request) : string {
      if (empty($this->public_key) and empty($this->private_key)) {
        return $request;
      }

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

    public static function SSPPFactura (string $correo, string $fichero_factura, array $anexos = []) : SoapVar {
      $SSPPFactura = [
        'correo' => $correo,
        'fichero_factura' => self::SSPPFicheroFactura($fichero_factura),
        'ficheros_anexos' => self::ArrayOfSSPPFicheroAnexo($anexos),
      ];

      return new SoapVar((object) $SSPPFactura, SOAP_ENC_OBJECT, 'EnviarFacturaRequest', 'https://webservice.face.gob.es');
    }

    public static function SSPPFicheroFactura (string $filename, ?string $mimetype = null) : SoapVar {
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

    public static function ArrayOfSSPPFicheroAnexo (array $anexos) : SoapVar {
      return new SoapVar(array_map(self::class . '::SSPPFicheroAnexo', $anexos), SOAP_ENC_ARRAY, 'ArrayOfAnexoFile', 'https://webservice.face.gob.es');
    }

    public static function SSPPFicheroAnexo (string $filename, ?string $mimetype = null) : SoapVar {
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
