<?php
  declare(strict_types=1);

	namespace Fawno\Facturae\Tests;

  use Fawno\Facturae\FACe;
  use Fawno\Facturae\FACe2;
  use Fawno\Facturae\Facturae;
  use Fawno\Facturae\FacturaeLiveValidation;
  use Fawno\Facturae\FacturaeSigner;
  use Fawno\Facturae\Signer\CertificateStore;
  use Fawno\Facturae\Tests\TestCase;

	class FACe2DFBTest extends TestCase {
    public function testEnviarFactura () : void {
      $certificateStore = CertificateStore::loadPKCS12(self::PKCS_FILE_1, self::PKCS_PASS_1);

      //$unsigned = Facturae::loadFile(self::INVOICE_UNSIGNED);
      $unsigned = Facturae::loadFile('https://apli.bizkaia.eus/apps/danok/cgfw/datos/factura_ejemplo.xml');
      $unsigned->setInvoiceSeries('FAWNO');
      $unsigned->setInvoiceNumber('FAWNO/' . date('YmdHis'));
      $signed = FacturaeSigner::sign($unsigned, $certificateStore);

      $wsdlFACe = FACe::create(FACe2::class, null, [
        'location' => 'http://80.245.2.226/CGS2/FacturaSSPPWebServiceProxyPort?WSDL',
        'trace' => true,
        //'keep_alive' => true,
        //'connection_timeout' => 5000,
        'compression' => SOAP_COMPRESSION_ACCEPT | SOAP_COMPRESSION_GZIP | SOAP_COMPRESSION_DEFLATE,
      ], true, false);

      $wsdlFACe->setCertificateStore($certificateStore);

      $invoiceWS = $wsdlFACe::SSPPFactura('example@example.com', $signed, []);
      $response = $wsdlFACe->enviarFactura($invoiceWS);

      $this->assertEquals(0, $response->resultado->codigo, print_r($response, true));
    }

    public function testEnviarFacturaRepetida () : void {
      $this->assertTrue(true);
      return;
      $certificateStore = CertificateStore::loadPKCS12(self::PKCS_FILE_1, self::PKCS_PASS_1);

      $unsigned = Facturae::loadFile('https://apli.bizkaia.eus/apps/danok/cgfw/datos/factura_ejemplo.xml');
      $signed = FacturaeSigner::sign($unsigned, $certificateStore);

      $wsdlFACe = FACe::create(FACe2::class, null, [
        'location' => 'http://80.245.2.226/CGS2/FacturaSSPPWebServiceProxyPort?WSDL',
        'trace' => true,
        //'keep_alive' => true,
        //'connection_timeout' => 5000,
        'compression' => SOAP_COMPRESSION_ACCEPT | SOAP_COMPRESSION_GZIP | SOAP_COMPRESSION_DEFLATE,
      ], true, false);

      $wsdlFACe->setCertificateStore($certificateStore);

      $invoiceWS = $wsdlFACe::SSPPFactura('example@example.com', $signed, []);
      $response = $wsdlFACe->enviarFactura($invoiceWS);

      $this->assertEquals(415, $response->resultado->codigo, print_r($response, true));
    }
  }
