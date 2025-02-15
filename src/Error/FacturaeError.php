<?php
/*
  Copyright 2018, Fawno (https://github.com/fawno)

  Licensed under The MIT License
  Redistributions of files must retain the above copyright notice.

  @copyright Copyright 2018, Fawno (https://github.com/fawno)
  @license MIT License (http://www.opensource.org/licenses/mit-license.php)
*/
  declare(strict_types=1);

  namespace Fawno\Facturae\Error;

  use Error;

  class FacturaeError extends Error {
    public const SIGNATURE = 0x000010000;
    public const BUYERTIN  = 0x000020000;
    public const IBAN      = 0x000040000;
    public const DIR3      = 0x000080000;
    public const SCHEMA    = 0x000100000;
    public const MISSING   = 0x000000001;
    public const INVALID   = 0x000000002;

    public function getType () : int {
      return (0x0FFFF0000 & $this->getCode());
    }

    public function isMissing () : int {
      return (self::MISSING & $this->getCode());
    }

    public function isInvalid () : int {
      return (self::INVALID & $this->getCode());
    }
  }
