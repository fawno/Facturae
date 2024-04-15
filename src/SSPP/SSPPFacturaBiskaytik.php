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

  use Fawno\Facturae\SSPP\FacturaFile;
  use Fawno\Facturae\SSPP\ArrayOfAnexoFile;
  use Fawno\Facturae\SSPP\SSPPFacturaTrait;

  class SSPPFacturaBiskaytik {
    use SSPPFacturaTrait;

    public object $facturaWS;

    public function __construct (string $correo, string $fichero_factura, array $anexos = []) {
      $this->facturaWS = (object) [
        'correo' => $correo,
        'fichero_factura' => FacturaFile::create($fichero_factura),
        'ficheros_anexos' => ArrayOfAnexoFile::create($anexos),
      ];
    }
  }

