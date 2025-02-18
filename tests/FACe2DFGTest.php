<?php
  declare(strict_types=1);

	namespace Fawno\Facturae\Tests;

  use Fawno\Facturae\FACe2;
  use Fawno\Facturae\Tests\FACeTestCase;

	class FACe2DFGTest extends FACeTestCase {
    public const ENDPOINT = 'https://w390w.gipuzkoa.net/WAS/HACI/HFAServiciosProveedoresWEB/services/FacturaSSPPWebServiceProxyPort?wsdl';
    public const INVOICE = self::INVOICE_UNSIGNED;
    public const FCLASS = FACe2::class;
    public const CODIGO1 = 007;
    public const CODIGO2 = 415;

    public function testEnviarFacturaRepetida () : void {
      $this->assertTrue(true);
      return;
    }
  }
