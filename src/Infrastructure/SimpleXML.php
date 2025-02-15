<?php
/*
  Copyright 2025, Fawno (https://github.com/fawno)

  Licensed under The MIT License
  Redistributions of files must retain the above copyright notice.

  @copyright Copyright 2025, Fawno (https://github.com/fawno)
  @license MIT License (http://www.opensource.org/licenses/mit-license.php)
*/
  declare(strict_types=1);

	namespace Fawno\Facturae\Infrastructure;

	use DateTime;
	use DateTimeImmutable;
	use DateTimeInterface;
	use SimpleXMLElement;

	class SimpleXML extends SimpleXMLElement {
		public static function loadFile (string $filename, string $class_name = SimpleXML::class, int $options = 0, string $ns = '', bool $is_prefix = false) : SimpleXMLElement|false {
			return simplexml_load_file($filename, $class_name, $options, $ns, $is_prefix);
		}

		public static function loadString (string $data, string $class_name = SimpleXML::class, int $options = 0, string $ns = '', bool $is_prefix = false) : SimpleXMLElement|false {
			return simplexml_load_string($data, $class_name, $options, $ns, $is_prefix);
		}

		public static function createDateTime (string $datetime, string $class = DateTime::class) : DateTimeInterface {
			return new ($class)(preg_replace([
				'~^(\d{8})$~',
				'~^(\d{2}:\d{2}:\d{2}) (\d{2})/(\d{2})/(\d{4})$~',
			], [
				'$1 00:00:00',
				'$4$3$2 $1',
			], $datetime));
		}

		public function getAttribute (string $attribute, string $type = 'string') : mixed {
			if (!isset($this->attributes()->{$attribute})) {
				return null;
			}

			$value = (string) $this->attributes()->{$attribute};

			return match ($type) {
				DateTime::class,
				DateTimeImmutable::class => static::createDateTime((string) $value, $type),
				default => settype($value, $type) ? $value : $value,
			};
		}

		public function removeAttribute (string $attribute) {
			unset($this->attributes()->{$attribute});
		}
	}
