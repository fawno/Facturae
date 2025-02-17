<?php
/*
  Copyright 2018, Fawno (https://github.com/fawno)

  Licensed under The MIT License
  Redistributions of files must retain the above copyright notice.

  @copyright Copyright 2018, Fawno (https://github.com/fawno)
  @license MIT License (http://www.opensource.org/licenses/mit-license.php)
*/
  declare(strict_types=1);

  namespace Fawno\Facturae\SSPP;

  use Fawno\Facturae\Facturae;
  use SoapVar;

  trait SSPPFacturaTrait {
    public static function create (string $correo, Facturae $fichero_factura, array $anexos = []) : SoapVar {
      $SSPPFactura = new self($correo, $fichero_factura, $anexos);

      return new SoapVar($SSPPFactura, SOAP_ENC_OBJECT, 'EnviarFacturaRequest', 'https://webservice.face.gob.es');
    }
  }
