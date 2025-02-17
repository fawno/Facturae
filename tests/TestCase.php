<?php
  declare(strict_types=1);

	namespace Fawno\Facturae\Tests;

  use PHPUnit\Framework\TestCase as PHPUnitTestCase;

	class TestCase extends PHPUnitTestCase {
    public const PKCS_FILE_1 = __DIR__ . '/PKCS/ACTIVO_EIDAS_CERTIFICADO_PRUEBAS___99999972C.p12';
    public const PKCS_PASS_1 = '1234';
    public const PKCS_FILE_2 = __DIR__ . '/PKCS/ACTIVO_EIDAS_CERTIFICADO_PRUEBAS___99999999R.p12';
    public const PKCS_PASS_2 = '1234';
    public const INVOICE_SIGNED   = __DIR__ . '/Invoices/factura-prueba-v1-2-0.xsig';
    public const INVOICE_UNSIGNED = __DIR__ . '/Invoices/factura-prueba-v1-2-0.xml';

    public function out (string $message) : void {
      fwrite(STDOUT, $message . PHP_EOL);
    }
	}
