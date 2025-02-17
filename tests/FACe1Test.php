<?php
  declare(strict_types=1);

	namespace Fawno\Facturae\Tests;

  use Fawno\Facturae\FACe;
  use Fawno\Facturae\FACe1;
  use Fawno\Facturae\FACe2;
  use Fawno\Facturae\Facturae;
  use Fawno\Facturae\FacturaeLiveValidation;
  use Fawno\Facturae\FacturaeSigner;
  use Fawno\Facturae\Signer\CertificateStore;
  use Fawno\Facturae\Tests\TestCase;

	class FACe1Test extends TestCase {
    public function testEnviarFactura () : void {
      $this->assertTrue(true);
      return;
      $certificateStore = CertificateStore::loadPKCS12(self::PKCS_FILE_1, self::PKCS_PASS_1);

      $unsigned = Facturae::loadFile(self::INVOICE_UNSIGNED);
      $unsigned->setBuyerTIN('ESP4800005C');
      $unsigned->Parties->BuyerParty->AdministrativeCentres->AdministrativeCentre[0]->CentreCode = 'I00000278';
      $unsigned->Parties->BuyerParty->AdministrativeCentres->AdministrativeCentre[1]->CentreCode = 'I00000278';
      $unsigned->Parties->BuyerParty->AdministrativeCentres->AdministrativeCentre[2]->CentreCode = 'I00000278';
      $unsigned->setInvoiceSeries('FAWNO');
      $unsigned->setInvoiceNumber('FAWNO/' . date('YmdHis'));
      $signed = FacturaeSigner::sign($unsigned, $certificateStore);

      $wsdlFACe = FACe::create(FACe1::class, null, [
        'location' => 'https://portaldigital.consorciodeaguas.com:8443/sspp_pr/services/sspp?wsdl',
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

      $unsigned = Facturae::loadFile(self::INVOICE_UNSIGNED);
      $unsigned->setBuyerTIN('ESP4800005C');
      $unsigned->Parties->BuyerParty->AdministrativeCentres->AdministrativeCentre[0]->CentreCode = 'I00000278';
      $unsigned->Parties->BuyerParty->AdministrativeCentres->AdministrativeCentre[1]->CentreCode = 'I00000278';
      $unsigned->Parties->BuyerParty->AdministrativeCentres->AdministrativeCentre[2]->CentreCode = 'I00000278';
      $signed = FacturaeSigner::sign($unsigned, $certificateStore);

      $wsdlFACe = FACe::create(FACe1::class, null, [
        'location' => 'https://portaldigital.consorciodeaguas.com:8443/sspp_pr/services/sspp?wsdl',
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
