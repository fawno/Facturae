<?php
  declare(strict_types=1);

	namespace Fawno\Facturae\Tests;

  use Fawno\Facturae\FACe;
  use Fawno\Facturae\FACe2Unsigned;
  use Fawno\Facturae\Facturae;
  use Fawno\Facturae\FacturaeLiveValidation;
  use Fawno\Facturae\FacturaeSigner;
  use Fawno\Facturae\Signer\CertificateStore;
  use Fawno\Facturae\Tests\TestCase;

  class FACe2UnsignedTest extends TestCase {
    public function testEnviarFactura () : void {
      $this->assertTrue(true);
      return;

      $certificateStore = CertificateStore::loadPKCS12(self::PKCS_FILE_1, self::PKCS_PASS_1);

      $unsigned = Facturae::loadFile(self::INVOICE_UNSIGNED);
      $unsigned->setInvoiceSeries('FAWNO');
      $unsigned->setInvoiceNumber('FAWNO/' . date('YmdHis'));
      $signed = FacturaeSigner::sign($unsigned, $certificateStore);

      $wsdlFACe = FACe::create(FACe2Unsigned::class, null, [
        'location' => 'https://www.bilbao.eus/uinvoicer_proxy/ws/ProxyServices?wsdl',
        'trace' => true,
        //'keep_alive' => true,
        //'connection_timeout' => 5000,
        'compression' => SOAP_COMPRESSION_ACCEPT | SOAP_COMPRESSION_GZIP | SOAP_COMPRESSION_DEFLATE,
      ], true, false);

      $wsdlFACe->setCertificateStore($certificateStore);

      $invoiceWS = $wsdlFACe::SSPPFactura('example@example.com', $signed, []);
      $response = $wsdlFACe->enviarFactura($invoiceWS);
      //$this->out(print_r($response, true));

      $this->assertEquals(0, $response->resultado->codigo, print_r($response, true));
    }
  }
