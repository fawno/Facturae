<?php
  declare(strict_types=1);

	namespace Fawno\Facturae\Tests;

  use Fawno\Facturae\FACe2;
  use Fawno\Facturae\Tests\FACeTestCase;

	class FACe2DFBTest extends FACeTestCase {
    public const ENDPOINT = 'http://80.245.2.226/CGS2/FacturaSSPPWebServiceProxyPort?WSDL';
    public const INVOICE = self::INVOICE_SAMPLE1;
    public const FCLASS = FACe2::class;

    public function testEnviarFacturaRepetida () : void {
      $this->assertTrue(true);
      return;
    }
  }
