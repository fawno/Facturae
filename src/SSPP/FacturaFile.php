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

  class FacturaFile {
    public static function create (Facturae $facturae, string $mimetype = 'application/xml') : SoapVar {
      $file = $facturae->asBase64();
      // Remove BOM in BASE64 encoding for FACeGV
      $file = preg_replace('~^77u/~', '', $file);

      $SSPPFicheroFactura = [
        'factura' => $file,
        'nombre' => str_replace('/', '-', $facturae->getInvoiceNumber()) . '.xml',
        //'mime' => 'text/xml',
        //'mime' => 'application/xml',
        'mime' => $mimetype,
      ];

      return new SoapVar((object) $SSPPFicheroFactura, SOAP_ENC_OBJECT, 'FacturaFile', 'https://webservice.face.gob.es');
    }
  }
