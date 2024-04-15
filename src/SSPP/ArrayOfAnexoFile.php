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
  use Fawno\Facturae\SSPP\AnexoFile;

  class ArrayOfAnexoFile {
    public static function create (array $anexos) : SoapVar {
      return new SoapVar(array_map([AnexoFile::class, 'create'], $anexos), SOAP_ENC_ARRAY, 'ArrayOfAnexoFile', 'https://webservice.face.gob.es');
    }
  }
