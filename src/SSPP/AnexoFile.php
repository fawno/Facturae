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

  class AnexoFile {
    public static function create (string $filename, ?string $mimetype = null) : SoapVar {
      if (empty($mimetype) and function_exists('mime_content_type')) {
        $mimetype = mime_content_type($filename);
      }

      $SSPPFicheroAnexo = [
        'anexo' => base64_encode(file_get_contents($filename)),
        'nombre' => basename($filename),
        'mime' => $mimetype,
      ];

      return new SoapVar((object) $SSPPFicheroAnexo, SOAP_ENC_OBJECT, 'AnexoFile', 'https://webservice.face.gob.es');
    }
  }
