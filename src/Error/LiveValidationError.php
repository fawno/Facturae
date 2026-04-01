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
  use Throwable;

  class LiveValidationError extends Error {
    protected ?string $type = null;

    protected function __construct (string $message = '', string|int $code = 0, ?Throwable $previous = null) {
      $this->type = is_string($code) ? $code : null;

      if (preg_match('~^(.*)-(\d+)$~', (string) $code, $type)) {
        $this->type = $type[1];
        $code = (int) $type[2];
      }

      $code = is_string($code) ? 0 : $code;

      parent::__construct($message, $code, $previous);
    }

    public static function create (string $message = '', string|int $code = 0, ?Throwable $previous = null) : LiveValidationError {
      return new static($message, $code, $previous);
    }

    public function getType () : ?string {
      return $this->type;
    }
  }
