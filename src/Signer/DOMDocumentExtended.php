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
  use Fawno\Facturae\Facturae;

  class DOMDocumentExtended extends DOMDocument {
    public static function loadFacturae (Facturae $facturae) : ?DOMDocumentExtended {
      $dom = new DOMDocumentExtended();

      return $dom->loadXML($facturae->asXML()) ? $dom : null;
    }

    public function asFacturae () : ?Facturae {
      return Facturae::importDOM($this);
    }

    public function getDocumentAttributes () : array {
      $attrs = [];

      foreach ($this->documentElement->getAttributeNames() as $localName) {
        $attrs[$localName] = $this->documentElement->getAttribute($localName);
      }

      return $attrs;
    }

    public function getDocumentNamespaces (array $namespaces = []) : array {
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
