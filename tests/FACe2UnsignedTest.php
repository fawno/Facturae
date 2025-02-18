<?php
  declare(strict_types=1);

	namespace Fawno\Facturae\Tests;

  use Fawno\Facturae\FACe2Unsigned;
  use Fawno\Facturae\Tests\FACeTestCase;

  class FACe2UnsignedTest extends FACeTestCase {
    public const ENDPOINT = 'https://www.bilbao.eus/uinvoicer_proxy/ws/ProxyServices?wsdl';
    public const INVOICE = self::INVOICE_UNSIGNED;
    public const FCLASS = FACe2Unsigned::class;

    public function testEnviarFactura () : void {
      $this->assertTrue(true);
      return;
    }

    public function testEnviarFacturaRepetida(): void {
      $this->assertTrue(true);
      return;
    }
  }
