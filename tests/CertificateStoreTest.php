<?php
  declare(strict_types=1);

	namespace Fawno\Facturae\Tests;

  use Fawno\Facturae\Signer\CertificateStore;
  use Fawno\Facturae\Tests\TestCase;

	class CertificateStoreTest extends TestCase {
    public const PKCS_FILE_1 = __DIR__ . '/PKCS/ACTIVO_EIDAS_CERTIFICADO_PRUEBAS___99999972C.p12';
    public const PKCS_PASS_1 = '1234';
    public const PKCS_FILE_2 = __DIR__ . '/PKCS/ACTIVO_EIDAS_CERTIFICADO_PRUEBAS___99999999R.p12';
    public const PKCS_PASS_2 = '1234';

    public function testLoadPKCS12 () {
      $certStore = CertificateStore::loadPKCS12(self::PKCS_FILE_1, self::PKCS_PASS_1);

      $this->assertInstanceOf(CertificateStore::class, $certStore);
    }
  }
