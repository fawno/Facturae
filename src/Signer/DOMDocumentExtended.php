<?php
/*
  Copyright 2025, Fawno (https://github.com/fawno)

  Licensed under The MIT License
  Redistributions of files must retain the above copyright notice.

  @copyright Copyright 2025, Fawno (https://github.com/fawno)
  @license MIT License (http://www.opensource.org/licenses/mit-license.php)
*/
  declare(strict_types=1);

  namespace Fawno\Facturae\Signer;

  use DOMDocument;
  use DOMElement;
  use DOMNode;
  use Exception;
  use Fawno\Facturae\Facturae;
  use Fawno\Facturae\FacturaeSigner;
  use RobRichards\XMLSecLibs\XMLSecurityDSig;

  class DOMDocumentExtended extends DOMDocument {
    public static function loadFile (string $filename, int $options = 0) : ?DOMDocumentExtended {
      $dom = new static('1.0', 'utf-8');

      return $dom->load($filename, $options) ? $dom : null;
    }

    /**
     * Load XML from a string
     * @param string $source The string containing the XML.
     * @param int $options [optional] Bitwise OR of the libxml option constants.
     * @return null|DOMDocumentExtended DOMDocumentExtended on success or null on failure.
     */
    public static function loadStringXML (string $source, int $options = 0) : ?DOMDocumentExtended {
      $dom = new static('1.0', 'utf-8');

      return $dom->loadXML($source, $options) ? $dom : null;
    }

    public static function loadFacturae (Facturae $facturae) : ?DOMDocumentExtended {
      $dom = new DOMDocumentExtended('1.0', 'utf-8');

      return $dom->loadXML($facturae->asXML()) ? $dom : null;
    }

    public function asBase64 () : string {
      return base64_encode($this->saveXML());
    }

    public function asDom () : DOMDocumentExtended {
      return clone $this;
    }

    public function asFacturae () : ?Facturae {
      return Facturae::importDOM($this);
    }

    public function isSigned () : ?bool {
      $objXMLSecDSig = new XMLSecurityDSig();

      $signature = $objXMLSecDSig->locateSignature($this);

      return ($signature instanceof DOMNode);
    }

    public function removeSignature () : DOMDocumentExtended {
      try {
        $objXMLSecDSig = new XMLSecurityDSig();

        $unsigned = $this->asDOM();

        $signature = $objXMLSecDSig->locateSignature($unsigned);

        if (!($signature instanceof DOMNode)) {
          return $this;
        }

        $signature->parentNode->removeChild($signature);

        $localName = array_search(FacturaeSigner::XMLNS_DS, $unsigned->getDocNamespaces());

        if (is_string($localName)) {
          $unsigned->documentElement->removeAttribute($localName);
        }

        return $unsigned;
      } catch (Exception $exception) {
        return $this;
      }
    }

    public function setSellerEmail (string $email) : DOMDocumentExtended {
      $ContactDetails = $this->getElementsByTagName('SellerParty')->item(0)->getElementsByTagName('ContactDetails')->item(0);
      $ElectronicMail = $ContactDetails->getElementsByTagName('ElectronicMail');
      $ElectronicMail = $ElectronicMail->length ? $$ElectronicMail->item(0) : $ContactDetails->appendChild($this->createElement('ElectronicMail'));
      $ElectronicMail->nodeValue = 'distribucion@deia.eus';

      return $this;
    }

    public function getInvoiceNumber () : string {
      $InvoiceNumber = $this->getElementsByTagName('InvoiceNumber');
      return $InvoiceNumber->length ? $InvoiceNumber->item(0)->nodeValue : '';
    }

    public function getDocumentAttributes () : array {
      $attrs = [];

      foreach ($this->documentElement->getAttributeNames() as $localName) {
        $attrs[$localName] = $this->documentElement->getAttribute($localName);
      }

      return $attrs;
    }

    public function getDocNamespaces (array $namespaces = []) : array {
      $xmlns = new self();
      $xmlns->loadXML($this->C14N());
      $xmlns = $xmlns->getDocumentAttributes();

      return array_merge($xmlns, $namespaces);
    }

    public function injectNamespaces (DOMElement $element, array $namespaces) : string {
      foreach ($element->getAttributeNames() as $attr) {
        $namespaces[$attr] = $element->getAttribute($attr);
        $element->removeAttribute($attr);
      }

      foreach ($namespaces as $attr => $value) {
        $element->setAttribute($attr, $value);
      }

      return $this->saveXML($element);
    }
  }
