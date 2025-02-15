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
  use Fawno\Facturae\LiveValidation\LiveValidationAdministrativeCentre;
  use Fawno\Facturae\LiveValidation\LiveValidationFacturae;
  use Fawno\Facturae\LiveValidation\LiveValidationInvoice;
  use Fawno\Facturae\LiveValidation\LiveValidationParty;
  use ReflectionException;
	use ReflectionProperty;

	class Entity {
		public function __construct (array $attributes = []) {
			foreach ($attributes as $attr => $value) {
				$this->{$attr} = $value;
			}
		}

		public static function parseEntity (SimpleXML|array $entity) : array {
      return is_array($entity) ? static::parseArray($entity) : static::parseSimpleXML($entity);
		}

		public static function parseArray (array $entity) : array {
			$attributes = [];

			foreach ($entity as $attr => $value) {
				try {
					$type = (string) (new ReflectionProperty(static::class, $attr))->getType();
					$attributes[$attr] = match ($type) {
            DateTime::class,
            DateTimeImmutable::class => SimpleXML::createDateTime((string) $value, $type),
            LiveValidationInvoice::class => LiveValidationInvoice::create($value),
            LiveValidationParty::class => LiveValidationParty::create($value),
            LiveValidationAdministrativeCentre::class => LiveValidationAdministrativeCentre::create($value),
            LiveValidationFacturae::class => LiveValidationFacturae::create($value),
            default => settype($value, $type) ? $value : $value,
          };
				} catch (ReflectionException $e) {
					echo $e->__toString(), PHP_EOL;
					print_r($entity);
					die();
				}
			}

			return $attributes;
		}

		public static function parseSimpleXML (SimpleXML $entity) : array {
			$attributes = [];

			foreach ($entity->attributes() as $attr => $value) {
				try {
					$type = (string) (new ReflectionProperty(static::class, $attr))->getType();
					$attributes[$attr] = $entity->getAttribute($attr, $type);
				} catch (ReflectionException $e) {
					echo $e->__toString(), PHP_EOL;
					print_r($entity->attributes());
					die();
				}
			}

			return $attributes;
		}

		public static function create (SimpleXML|array $entity) : Entity {
			$attibutes = static::parseEntity($entity);

			return new static($attibutes);
		}

		public static function loadString (string $xml) : Entity {
			return static::create(SimpleXML::loadString($xml));
		}

		public static function loadFile (string $file) : Entity {
			return static::create(SimpleXML::loadFile($file));
		}
	}
