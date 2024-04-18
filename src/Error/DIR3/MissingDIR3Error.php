<?php
/*
  Copyright 2018, Fawno (https://github.com/fawno)

  Licensed under The MIT License
  Redistributions of files must retain the above copyright notice.

  @copyright Copyright 2018, Fawno (https://github.com/fawno)
  @license MIT License (http://www.opensource.org/licenses/mit-license.php)
*/
  declare(strict_types=1);

  namespace Fawno\Facturae\Error\DIR3;

  use Fawno\Facturae\Error\DIR3Error;
  use Throwable;

  class MissingDIR3Error extends DIR3Error {
    public function __construct (string $message = '', int $code = self::MISSING, ?Throwable $previous = null) {
      parent::__construct($message, self::MISSING | $code, $previous);
    }
  }
