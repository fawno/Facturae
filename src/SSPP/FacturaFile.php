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

  use SoapVar;

  class FacturaFile {
    public static function create (string $filename, ?string $mimetype = null) : SoapVar {
      if (empty($mimetype) and function_exists('mime_content_type')) {
        $mimetype = mime_content_type($filename);
      }

      // PHP 7.2.x identifies xml files as "text/xml" instead of "application/xml"
      if ($mimetype == 'text/xml') {
        $mimetype = 'application/xml';
      }

      $file = base64_encode(file_get_contents($filename));
      // Remove BOM in BASE64 encoding for FACeGV
      $file = preg_replace('~^77u/~', '', $file);

      $SSPPFicheroFactura = [
        'factura' => $file,
        'nombre' => basename($filename),
        'mime' => $mimetype,
      ];

      return new SoapVar((object) $SSPPFicheroFactura, SOAP_ENC_OBJECT, 'FacturaFile', 'https://webservice.face.gob.es');
    }
  }
