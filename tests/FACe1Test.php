<?php
  declare(strict_types=1);

	namespace Fawno\Facturae\Tests;

  use Fawno\Facturae\FACe1;
  use Fawno\Facturae\Tests\FACeTestCase;

	class FACe1Test extends FACeTestCase {
    public const ENDPOINT = 'https://portaldigital.consorciodeaguas.com:8443/sspp_pr/services/sspp?wsdl';
    public const INVOICE = self::INVOICE_SAMPLE2;
    public const FCLASS = FACe1::class;

    public function testEnviarFactura () : void {
      $this->assertTrue(true);
      return;
    }

    public function testEnviarFacturaRepetida () : void {
      $this->assertTrue(true);
      return;
    }
  }
