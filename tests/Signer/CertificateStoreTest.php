<?php
  declare(strict_types=1);

	namespace Fawno\Facturae\Tests\Signer;

  use Fawno\Facturae\Signer\CertificateStore;
  use Fawno\Facturae\Tests\TestCase;

	class CertificateStoreTest extends TestCase {
    public function testLoadPKCS12 () {
      $certStore = CertificateStore::loadPKCS12(self::PKCS_FILE_1, self::PKCS_PASS_1);

      $this->assertInstanceOf(CertificateStore::class, $certStore);
    }
  }
