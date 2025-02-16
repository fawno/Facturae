<?php
  declare(strict_types=1);

	namespace Fawno\Facturae\Tests;

  use Fawno\Facturae\Facturae;
  use Fawno\Facturae\FacturaeLiveValidation;
  use Fawno\Facturae\FacturaeSigner;
  use Fawno\Facturae\Signer\CertificateStore;
  use Fawno\Facturae\Tests\TestCase;

	class FacturaeSignerTest extends TestCase {
    public const PKCS_FILE_1 = __DIR__ . '/PKCS/ACTIVO_EIDAS_CERTIFICADO_PRUEBAS___99999972C.p12';
    public const PKCS_PASS_1 = '1234';
    public const PKCS_FILE_2 = __DIR__ . '/PKCS/ACTIVO_EIDAS_CERTIFICADO_PRUEBAS___99999999R.p12';
    public const PKCS_PASS_2 = '1234';
    public const INVOICE_SIGNED   = __DIR__ . '/Invoices/factura-prueba-v1-2-0.xsig';
    public const INVOICE_UNSIGNED = __DIR__ . '/Invoices/factura-prueba-v1-2-0.xml';

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
