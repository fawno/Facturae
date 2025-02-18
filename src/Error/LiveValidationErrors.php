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

  use ArrayObject;

  class LiveValidationErrors extends ArrayObject {
		public static function parseErrors (array $errors) : LiveValidationErrors {
			$_entities = [];

      foreach (array_merge(...$errors) as $code => $message) {
        $_entities[] = new LiveValidationError($message, $code);
      }

			return new self($_entities);
		}
  }
