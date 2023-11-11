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

  use DOMDocument;
  use DOMNode;
  use Exception;
  use RobRichards\XMLSecLibs\XMLSecEnc;
  use RobRichards\XMLSecLibs\XMLSecurityDSig;
  use SimpleXMLElement;
  use XSLTProcessor;

  class Facturae extends SimpleXMLElement {
		protected const VERSION320 = '3.2';
		protected const VERSION321 = '3.2.1';
		protected const VERSION322 = '3.2.2';

    protected const XSD_FILES = [
			self::VERSION320 => __DIR__ . '/Schema/Facturae_v320.xsd',
			self::VERSION321 => __DIR__ . '/Schema/Facturae_v321.xsd',
			self::VERSION322 => __DIR__ . '/Schema/Facturae_v322.xsd',
		];

    protected const XSL_FILES = [
			self::VERSION320 => __DIR__ . '/Stylesheet/Facturae_v320.xsl',
			self::VERSION321 => __DIR__ . '/Stylesheet/Facturae_v321.xsl',
			self::VERSION322 => __DIR__ . '/Stylesheet/Facturae_v322.xsl',
		];

    protected const XSLT_FILES = [
			self::VERSION320 => __DIR__ . '/Transformations/Facturae_v320_to_v321.xslt',
			//self::VERSION321 => __DIR__ . '/Transformations/Facturae_v321_to_v322.xslt',
		];

    public static function importDOM (DOMNode $node, string $class_name = self::class) : ?Facturae {
			return simplexml_import_dom($node, $class_name) ?? null;
		}

		public static function loadFile (string $filename, string $class_name = self::class, int $options = 0, string $ns = '', bool $is_prefix = false) : ?Facturae {
			return simplexml_load_file($filename, self::class, $options, $ns, $is_prefix) ?? null;
		}

		public static function loadXML (string $data, string $class_name = self::class, int $options = 0, string $ns = '', bool $is_prefix = false) : ?Facturae {
			return simplexml_load_string($data, $class_name, $options, $ns, $is_prefix) ?? null;
		}

    public function asDOM () : ?DOMDocument {
      $dom = new DOMDocument();

      return $dom->loadXML($this->asXML()) ? $dom : null;
    }

    public function asHTML () : ?string {
      $version = (string) $this->FileHeader->SchemaVersion ?? null;
      $xslfile = self::XSL_FILES[$version] ?? null;

			return self::transformToXML($this, self::loadFile($xslfile)) ?? null;
    }

    public static function transformToXML (Facturae $source, Facturae $style) {
			$proc = new XSLTProcessor;
			$proc->importStyleSheet($style);

      return $proc->transformToXML($source);
    }

    public function transformVersion () : Facturae {
      $version = (string) $this->FileHeader->SchemaVersion ?? null;
      $xsltfile = self::XSLT_FILES[$version] ?? null;

      if (!is_file($xsltfile)) {
        return $this;
      }

			$xml = self::transformToXML($this, self::loadFile($xsltfile));

      if ($xml === false) {
        return $this;
      }

      return self::loadXML($xml);
    }

    public function verifySignature () : void {
			$objXMLSecDSig = new XMLSecurityDSig();
			$objDSig = $objXMLSecDSig->locateSignature($this->asDOM());
			if (!$objDSig) {
				throw new Exception('Cannot locate signature node');
			}

			$objXMLSecDSig->canonicalizeSignedInfo();
			$objKey = $objXMLSecDSig->locateKey();
			if (!$objKey) {
				throw new Exception('Cannot locate key node');
			}

      XMLSecEnc::staticLocateKeyInfo($objKey, $objDSig);

			if (!$objXMLSecDSig->verify($objKey)) {
				throw new Exception('Signature error');
			}
    }

    public function validateSchema () : array {
      $version = (string) $this->FileHeader->SchemaVersion ?? null;
      $xsdfile = self::XSD_FILES[$version] ?? null;

      $errors = [];

      if (!$xsdfile or !is_file($xsdfile)) {
				throw new Exception('Version not supported');
      }


      $xml = $this->asDOM();

      $signature = $xml->getElementsByTagName('Signature')->item(0) ?? null;
      if ($signature) {
        $signature->parentNode->removeChild($signature);
      }

      libxml_use_internal_errors(true);
      if (!$xml->schemaValidate($xsdfile)) {
        foreach (libxml_get_errors() as $error) {
          $errors[] = (array) $error;
        }
      }

      return $errors;
    }
  }
