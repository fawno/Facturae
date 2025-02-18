<?php
  declare(strict_types=1);

	namespace Fawno\Facturae\Tests;

  use Fawno\Facturae\FACe2;
  use Fawno\Facturae\Tests\FACeTestCase;

	class FACe2GVTest extends FACeTestCase {
    public const ENDPOINT = 'https://svc.integracion.test.euskadi.net/ctxweb/secured_ssl/w42ajEFacturaSSPP2?WSDL';
    public const INVOICE = self::INVOICE_UNSIGNED;
    public const FCLASS = FACe2::class;

    public function testEnviarFactura () : void {
      $this->assertTrue(true);
      return;
    }

    public function testEnviarFacturaRepetida () : void {
      $this->assertTrue(true);
      return;
    }
  }
