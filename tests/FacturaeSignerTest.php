<?php
  declare(strict_types=1);

	namespace Fawno\Facturae\Tests;

  use Fawno\Facturae\Facturae;
  use Fawno\Facturae\FacturaeLiveValidation;
  use Fawno\Facturae\FacturaeSigner;
  use Fawno\Facturae\Signer\CertificateStore;
  use Fawno\Facturae\Tests\TestCase;

	class FacturaeSignerTest extends TestCase {
    public function testLoadPKCS12 () {
      $certStore = CertificateStore::loadPKCS12(self::PKCS_FILE_1, self::PKCS_PASS_1);

      $unsigned = Facturae::loadFile(self::INVOICE_UNSIGNED);

      $signed = FacturaeSigner::sign($unsigned, $certStore);
      $validation = FacturaeLiveValidation::validate($signed);

      $this->assertInstanceOf(Facturae::class, $signed);
      $this->assertTrue($signed->isSigned());
      $this->assertTrue($validation->isValid());
    }
  }
