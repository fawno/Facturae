<?php
/*
  Copyright 2018, Fawno (https://github.com/fawno)

  Licensed under The MIT License
  Redistributions of files must retain the above copyright notice.

  @copyright Copyright 2018, Fawno (https://github.com/fawno)
  @license MIT License (http://www.opensource.org/licenses/mit-license.php)
*/
  declare(strict_types=1);

  namespace Fawno\Facturae;

  use Fawno\Facturae\Error\SchemaError;
  use Fawno\Facturae\Exception\UnsupportedVersionException;
  use Fawno\Facturae\Facturae;

  class FacturaeSchema {
    protected const XSD_FILES = [
			Facturae::VERSION320 => __DIR__ . '/Schema/Facturae_v320.xsd',
			Facturae::VERSION321 => __DIR__ . '/Schema/Facturae_v321.xsd',
			Facturae::VERSION322 => __DIR__ . '/Schema/Facturae_v322.xsd',
		];

    protected array $errors = [];
    protected bool $valid = false;

    public function __construct (Facturae $facturae) {
      $version = $facturae->getSchemaVersion();
      $xsdfile = self::XSD_FILES[$version] ?? null;

      if (!$xsdfile or !is_file($xsdfile)) {
				throw new UnsupportedVersionException('Version not supported');
      }

      $xml = $facturae->asDOM();

      $signature = $xml->getElementsByTagName('Signature')->item(0) ?? null;
      if ($signature) {
        $signature->parentNode->removeChild($signature);
      }

      libxml_use_internal_errors(true);
      if (!$xml->schemaValidate($xsdfile)) {
        foreach (libxml_get_errors() as $error) {
          $this->errors[] = new SchemaError($error);
        }
      }
    }

    public function isValid () : bool {
      return !((bool) count($this->errors));
    }

    public function getErrors () : array {
      return $this->errors;
    }
  }
