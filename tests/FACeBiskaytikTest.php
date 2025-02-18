<?php
  declare(strict_types=1);

	namespace Fawno\Facturae\Tests;

  use Fawno\Facturae\FACeBiskaytik;
  use Fawno\Facturae\Tests\FACeTestCase;

	class FACeBiskaytikTest extends FACeTestCase {
    public const ENDPOINT = 'https://egoitza.biscaytik.eus/efaktur/ws/puntoEntrada.wsdl';
    public const INVOICE = self::INVOICE_UNSIGNED;
    public const FCLASS = FACeBiskaytik::class;

    public function testEnviarFactura () : void {
      $this->assertTrue(true);
      return;
    }

    public function testEnviarFacturaRepetida () : void {
      $this->assertTrue(true);
      return;
    }
  }
