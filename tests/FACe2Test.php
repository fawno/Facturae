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

	class FACe2Test extends TestCase {
    public function testLoadPKCS12 () {
      $certStore = CertificateStore::loadPKCS12(self::PKCS_FILE_1, self::PKCS_PASS_1);

      $unsigned = Facturae::loadFile(self::INVOICE_UNSIGNED);
      $unsigned->setInvoiceSeries('FAWNO');
      $unsigned->setInvoiceNumber(date('YmdHis'));
      $signed = FacturaeSigner::sign($unsigned, $certStore);
      //$validation = FacturaeLiveValidation::validate($signed);

      $invoice_file = tempnam(__DIR__, '_fe');
      $signed->saveXML($invoice_file);

      $wsdlFACe = FACe::create(FACe2::class, null, null, [
        'location' => FACe2::WSDL_DEV,
        'trace' => true,
        //'keep_alive' => true,
        //'connection_timeout' => 5000,
        'compression' => SOAP_COMPRESSION_ACCEPT | SOAP_COMPRESSION_GZIP | SOAP_COMPRESSION_DEFLATE,
      ], true, false);

      $wsdlFACe->set_pkcs12(self::PKCS_FILE_1, self::PKCS_PASS_1);
      $invoiceWS = $wsdlFACe::SSPPFactura('example@example.com', $invoice_file, []);
      $response = $wsdlFACe->enviarFactura($invoiceWS);

      unlink($invoice_file);

      $this->assertEquals(0, $response->resultado->codigo, print_r($response, true));
    }
  }
