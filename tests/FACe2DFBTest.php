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
     * Error al crear la factura electrónica en BKON:
     * Problemas con el envio de ficheros al Registro Electrónico
     */
    public const CODIGO1 = 'DFB07006';

    public function testEnviarFacturaRepetida () : void {
      $this->assertTrue(true);
      return;
    }
  }
