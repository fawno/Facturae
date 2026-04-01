<?php
	declare(strict_types=1);

  namespace Fawno\Facturae\Error\LiveValidation;

  enum LiveValidationErrorType : string {
    case INVALID_INVOICE = 'INVALID_INVOICE';
    case INVALID_RELATION = 'INVALID-RELATION';
    case INVALID_ADHESION = 'INVALID_ADHESION';
    case INVALID_ADMINISTRATIVE_CENTRE = 'INVALID_ADMINISTRATIVE_CENTRE';

    public static function fromErrorCode (string $code) : self {
      if (preg_match('~^(.*)-(\d+)$~', (string) $code, $type)) {
        return self::from($type[1]);
      }

      return self::from($code);
		}

    public function isInvalidRelation () : bool {
      return ($this === self::INVALID_RELATION or $this === self::INVALID_ADMINISTRATIVE_CENTRE);
    }

    public function isInvalidAdhesion () : bool {
      return ($this === self::INVALID_ADHESION);
    }

    public function isInvalidInvoice () : bool {
      return ($this === self::INVALID_INVOICE);
    }
  }
