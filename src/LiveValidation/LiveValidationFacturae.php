<?php
/*
  Copyright 2025, Fawno (https://github.com/fawno)

  Licensed under The MIT License
  Redistributions of files must retain the above copyright notice.

  @copyright Copyright 2025, Fawno (https://github.com/fawno)
  @license MIT License (http://www.opensource.org/licenses/mit-license.php)
*/
  declare(strict_types=1);

  namespace Fawno\Facturae\LiveValidation;

  use Fawno\Facturae\Infrastructure\Entity;

  class LiveValidationFacturae extends Entity {
    public string $identifier;
    public string $fullName;
    public string $uuid;
    public string $filename;
    public string $mime;
    public string $hash;
    public bool $isDeleted;
  }
