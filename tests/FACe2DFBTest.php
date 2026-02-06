<?php
  declare(strict_types=1);

	namespace Fawno\Facturae\Tests;

  use Fawno\Facturae\FACe2;
  use Fawno\Facturae\Tests\FACeTestCase;

	class FACe2DFBTest extends FACeTestCase {
    public const ENDPOINT = 'http://80.245.2.226/CGS2/FacturaSSPPWebServiceProxyPort?WSDL';
    public const INVOICE = self::INVOICE_SAMPLE3;
    public const FCLASS = FACe2::class;
    /**
     * Debido a cambios de estructura en Diputación, no existe relación
     * oficina contable-órgano gestor-unidad tramitadora en las tablas
     * de órganos administrativos.
     * Contacte con su enlace o consulte los nuevos códigos en la página web.
     */
    public const CODIGO1 = 'RCF08004';

    public function testEnviarFacturaRepetida () : void {
      $this->assertTrue(true);
      return;
    }
  }
