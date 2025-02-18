<?php
  declare(strict_types=1);

	namespace Fawno\Facturae\Tests;

  use Fawno\Facturae\FACe2;
  use Fawno\Facturae\Tests\FACeTestCase;

	class FACe2Test extends FACeTestCase {
    public const ENDPOINT = FACe2::WSDL_DEV;
    public const INVOICE = self::INVOICE_UNSIGNED;
    public const FCLASS = FACe2::class;
  }
