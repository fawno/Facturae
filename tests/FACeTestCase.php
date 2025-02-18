<?php
  declare(strict_types=1);

	namespace Fawno\Facturae\Tests;

  use Fawno\Facturae\FACe;
  use Fawno\Facturae\Facturae;
  use Fawno\Facturae\FacturaeSigner;
  use Fawno\Facturae\Signer\CertificateStore;
  use Fawno\Facturae\Tests\TestCase;

	class FACeTestCase extends TestCase {
    public const ENDPOINT = FACe::WSDL_DEV;
    public const INVOICE = self::INVOICE_UNSIGNED;
    public const FCLASS = FACe::class;
    public const CODIGO1 = 0;
    public const CODIGO2 = 415;

    public function testEnviarFactura () : void {
      $certificateStore = CertificateStore::loadPKCS12(static::PKCS_FILE_1, static::PKCS_PASS_1);

      $unsigned = Facturae::loadFile(static::INVOICE);
      $unsigned->setInvoiceSeries('FAWNO');
      $unsigned->setInvoiceNumber('FAWNO/' . date('YmdHis'));
      $signed = FacturaeSigner::sign($unsigned, $certificateStore);

      $wsdlFACe = FACe::create(static::FCLASS, null, [
        'location' => static::ENDPOINT,
        'trace' => true,
        //'keep_alive' => true,
        //'connection_timeout' => 5000,
        'compression' => SOAP_COMPRESSION_ACCEPT | SOAP_COMPRESSION_GZIP | SOAP_COMPRESSION_DEFLATE,
      ], true, false);

      $wsdlFACe->setCertificateStore($certificateStore);

      $invoiceWS = $wsdlFACe::SSPPFactura('example@example.com', $signed, []);
      $response = $wsdlFACe->enviarFactura($invoiceWS);

      $this->assertEquals(static::CODIGO1, $response->resultado->codigo, print_r($response, true));
    }

    public function testEnviarFacturaRepetida () : void {
      $certificateStore = CertificateStore::loadPKCS12(static::PKCS_FILE_1, static::PKCS_PASS_1);

      $unsigned = Facturae::loadFile(static::INVOICE);
      $signed = FacturaeSigner::sign($unsigned, $certificateStore);

      $wsdlFACe = FACe::create(static::FCLASS, null, [
        'location' => static::ENDPOINT,
        'trace' => true,
        //'keep_alive' => true,
        //'connection_timeout' => 5000,
        'compression' => SOAP_COMPRESSION_ACCEPT | SOAP_COMPRESSION_GZIP | SOAP_COMPRESSION_DEFLATE,
      ], true, false);

      $wsdlFACe->setCertificateStore($certificateStore);

      $invoiceWS = $wsdlFACe::SSPPFactura('example@example.com', $signed, []);
      $response = $wsdlFACe->enviarFactura($invoiceWS);

      $this->assertEquals(static::CODIGO2, $response->resultado->codigo, print_r($response, true));
    }
  }
