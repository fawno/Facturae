<?php
/*
  Copyright 2025, Fawno (https://github.com/fawno)

  Licensed under The MIT License
  Redistributions of files must retain the above copyright notice.

  @copyright Copyright 2025, Fawno (https://github.com/fawno)
  @license MIT License (http://www.opensource.org/licenses/mit-license.php)
*/
  declare(strict_types=1);

  namespace Fawno\Facturae\Error;

  use Error;
  use Fawno\Facturae\Error\LiveValidation\LiveValidationErrorType;
  use Throwable;

  class LiveValidationError extends Error {
    protected LiveValidationErrorType $type;

    protected function __construct (string $message = '', string $code, ?Throwable $previous = null) {
      $this->type = LiveValidationErrorType::fromErrorCode($code);

      if (preg_match('~^(.*)-(\d+)$~', (string) $code, $type)) {
        $code = (int) $type[2];
      }

      $code = is_string($code) ? 0 : $code;

      parent::__construct($message, $code, $previous);
    }

    public static function create (string $message = '', string|int $code = 0, ?Throwable $previous = null) : LiveValidationError {
      return new static($message, $code, $previous);
    }

    public function getType () : LiveValidationErrorType {
      return $this->type;
    }

    public function hasRegisterNumber () : bool {
      return ($this->type->isInvalidInvoice() and 123 === $this->code);
    }

    public function isInvalidRelation () : bool {
      return $this->type->isInvalidRelation();
    }

    public function isInvalidAdhesion () : bool {
      return $this->type->isInvalidAdhesion();
    }
  }
