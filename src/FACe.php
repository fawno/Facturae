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

  use Fawno\Facturae\Signer\CertificateStore;
  use Fawno\Facturae\Signer\DOMDocumentExtended;
  use Fawno\Facturae\SSPP\SSPPFactura;
  use SoapClient;
  use SoapVar;
  use RobRichards\WsePhp\WSSESoap;
  use RobRichards\XMLSecLibs\XMLSecurityKey;

  abstract class FACe extends SoapClient {
    public const WSDL_DEV = 'https://se-face-webservice.redsara.es/facturasspp?wsdl';
    public const WSDL     = 'https://webservice.face.gob.es/facturasspp?wsdl';

    protected string $endpoint = self::WSDL;
    protected ?CertificateStore $certificateStore = null;

    public static function create (string $wsClassName, ?CertificateStore $certificateStore = null, array $options = [], bool $devel = false, bool $ssl_verifypeer = true) : FACe {
      return new $wsClassName($certificateStore, $options, $devel, $ssl_verifypeer);
    }

    public function __construct (?CertificateStore $certificateStore = null, array $options = [], bool $devel = false, bool $ssl_verifypeer = true) {
      $options['location'] = $options['location'] ?? ($devel ? self::WSDL_DEV : self::WSDL);
      $this->endpoint = $options['location'];

      $wsdl = $options['wsdl'] ?? $this->endpoint;

      if (empty($options['stream_context'])) {
        $options['stream_context'] = $this->stream_context($ssl_verifypeer);
      }

      $this->certificateStore = $certificateStore;

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

    public function setCertificateStore (?CertificateStore $certificateStore) : static {
      $this->certificateStore = $certificateStore;

      return $this;
    }

    public function signRequest (string $request) : string {
      if (is_null($this->certificateStore)) {
        return $request;
      }

      $doc = DOMDocumentExtended::loadStringXML($request);

      $objWSSE = new WSSESoap($doc);
      $token = $objWSSE->addBinaryToken($this->certificateStore->getPemCertificate());
      $objWSSE->addTimestamp();
      $objKey = new XMLSecurityKey(XMLSecurityKey::RSA_SHA1, ['type' => 'private']);
      $objKey->loadKey($this->certificateStore->getPemPrivateKey());
      $objWSSE->signSoapDoc($objKey, ['insertBefore' => false]);
      $objWSSE->attachTokentoSig($token);

      return $objWSSE->saveXML();
    }

    public static function SSPPFactura (string $correo, string $fichero_factura, array $anexos = []) : SoapVar {
      return SSPPFactura::create($correo, $fichero_factura, $anexos);
    }
  }
