<?php
/*
  Copyright 2018, Fawno (https://github.com/fawno)

  Licensed under The MIT License
  Redistributions of files must retain the above copyright notice.

  @copyright Copyright 2018, Fawno (https://github.com/fawno)
  @license MIT License (http://www.opensource.org/licenses/mit-license.php)
*/
  declare(strict_types=1);

  namespace Fawno\Facturae;

  use Fawno\Facturae\FACe;
  use Fawno\Facturae\SSPP\SSPPFactura2;
  use SoapVar;

  class FACe2 extends FACe {
    public static function SSPPFactura (string $correo, string $fichero_factura, array $anexos = []) : SoapVar {
      return SSPPFactura2::create($correo, $fichero_factura, $anexos);
    }
  }
