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

  use DateTimeImmutable;
  use DOMDocument;
  use DOMNode;
  use SimpleXMLElement;
  use XSLTProcessor;

  class Facturae extends SimpleXMLElement {
		public const ROLE_TYPES = [
			'01' => 'oc',
			'02' => 'og',
			'03' => 'ut',
		];

    public const VERSION320 = '3.2';
		public const VERSION321 = '3.2.1';
		public const VERSION322 = '3.2.2';

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
			return simplexml_load_file($filename, $class_name, $options, $ns, $is_prefix) ?? null;
		}

		public static function loadXML (string $data, string $class_name = self::class, int $options = 0, string $ns = '', bool $is_prefix = false) : ?Facturae {
			return simplexml_load_string($data, $class_name, $options, $ns, $is_prefix) ?? null;
		}

    public function asDOM () : ?DOMDocument {
      $dom = new DOMDocument();

      return $dom->loadXML($this->asXML()) ? $dom : null;
    }

    public function asHTML () : ?string {
      $version = $this->getSchemaVersion();
      $xslfile = self::XSL_FILES[$version] ?? null;

			return self::transformToXML($this, self::loadFile($xslfile)) ?? null;
    }

    public static function transformToXML (SimpleXMLElement $source, SimpleXMLElement $style) {
			$proc = new XSLTProcessor;
			$proc->importStyleSheet($style);

      return $proc->transformToXML($source);
    }

    public function transformVersion () : Facturae {
      $version = $this->getSchemaVersion();
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

    public function getInvoiceNumber () : string {
      return (string) $this->Invoices->Invoice->InvoiceHeader->InvoiceNumber;
    }

    public function getInvoiceSeries () : string {
      return (string) $this->Invoices->Invoice->InvoiceHeader->InvoiceSeriesCode;
    }

    public function getSellerTIN () : string {
      return (string) $this->Parties->SellerParty->TaxIdentification->TaxIdentificationNumber;
    }

    public function getBuyerTIN () : string {
      return (string) $this->Parties->BuyerParty->TaxIdentification->TaxIdentificationNumber;
    }

    public function getIssueDate () : DateTimeImmutable {
      $date = (string) $this->Invoices->Invoice->InvoiceIssueData->IssueDate ?? '';
      return new DateTimeImmutable($date);
    }

    public function getIBAN () : ?string {
			$invoice_iban1 = (string) $this->Invoices->Invoice->PaymentDetails->Installment->AccountToBeCredited->IBAN;
			$invoice_iban2 = (string) $this->Invoices->Invoice->PaymentDetails->Installment->AccountToBeDebited->IBAN;
			$invoice_iban = !empty($invoice_iban1) ? $invoice_iban1 : $invoice_iban2;

      return (!empty($invoice_iban) ? $invoice_iban : null);
    }

    public function getAdministrativeCentres () : array {
      $centres = [];

      foreach ($this->Parties->BuyerParty->AdministrativeCentres->AdministrativeCentre ?? [] as $centre) {
        $centres[(string) $centre->RoleTypeCode] = $centre;
      }

      return $centres;
    }

    public function getDIR3 () : array {
      $dir3 = [];

      foreach ($this->getAdministrativeCentres() as $role => $centre) {
        if (self::ROLE_TYPES[$role] ?? false) {
          $dir3[self::ROLE_TYPES[$role]] = str_replace(' ', '', (string) $centre->CentreCode);
        }
      }

      return $dir3;
    }

    public function getSchemaVersion () : ?string {
      return (string) $this->FileHeader->SchemaVersion ?? null;
    }
  }
