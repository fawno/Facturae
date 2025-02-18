<?php
  declare(strict_types=1);

	namespace Fawno\Facturae\Tests;

  use Fawno\Facturae\Facturae;
  use Fawno\Facturae\FacturaeLiveValidation;
  use Fawno\Facturae\FacturaeSignature;
  use Fawno\Facturae\FacturaeSigner;
  use Fawno\Facturae\FacturaeValidation;
  use Fawno\Facturae\Signer\CertificateStore;
  use Fawno\Facturae\Tests\TestCase;

	class FacturaeSignerTest extends TestCase {
    public function testLoadPKCS12 () {
      $certStore = CertificateStore::loadPKCS12(self::PKCS_FILE_1, self::PKCS_PASS_1);

      $unsigned = Facturae::loadFile(self::INVOICE_UNSIGNED);

      $signed = FacturaeSigner::sign($unsigned, $certStore);
      $validation = FacturaeLiveValidation::validate($signed);
      //$validation = FacturaeValidation::validate($signed);
      //$validation = FacturaeSignature::validate($signed);

      $this->assertInstanceOf(Facturae::class, $signed);
      $this->assertTrue($signed->isSigned(), 'La factura no está firmada');
      $this->assertTrue($validation->isValid(), 'Error en la validación');
    }
  }
