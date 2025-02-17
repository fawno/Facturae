<?php
/*
  Copyright 2025, Fawno (https://github.com/fawno)

  Licensed under The MIT License
  Redistributions of files must retain the above copyright notice.

  @copyright Copyright 2025, Fawno (https://github.com/fawno)
  @license MIT License (http://www.opensource.org/licenses/mit-license.php)
*/
  declare(strict_types=1);

  namespace Fawno\Facturae;

  use Fawno\Facturae\Error\LiveValidationErrors;
  use Fawno\Facturae\Exception\LiveValidationException;
  use Fawno\Facturae\LiveValidation\LiveValidationInvoice;
  use Fawno\Facturae\Signer\DOMDocumentExtended;

  class FacturaeLiveValidation {
    public const VALIDATOR = 'https://se-proveedores-face.redsara.es/api/v1/invoice-validation';

    protected string $type;
    protected bool $valid;
    protected LiveValidationErrors $errors;
    protected LiveValidationInvoice $invoice;

    public function __construct (string $result) {
      $result = json_decode($result, true, 512, JSON_THROW_ON_ERROR);
      $this->type = $result['type'] ?? '';
      $this->valid = $result['valid'] ?? false;
      $this->errors = LiveValidationErrors::parseErrors($result['errors'] ?? []);
      $this->invoice = LiveValidationInvoice::create($result['eInvoice'] ?? []);
    }

    public function getType () : string {
      return $this->type;
    }

    public function isValid () : bool {
      return $this->valid;
    }

    public function hasErrors () : bool {
      return (bool) $this->errors->count();
    }

    public function getErrors () : LiveValidationErrors {
      return $this->errors;
    }

    public static function create (string $result) : FacturaeLiveValidation {
      return new self($result);
    }

    public static function validate (Facturae|DOMDocumentExtended $facturae, bool $validateSignature = true, bool $validateAdministrativeCentres = false, bool $validateDuplicity = false) : FacturaeLiveValidation {
      $data = json_encode([
        'filename' => $facturae->getInvoiceNumber(),
        'content' => $facturae->asBase64(),
        'validateSignature' => $validateSignature,
        'validateAdministrativeCentres' => $validateAdministrativeCentres,
        'validateDuplicity' => $validateDuplicity,
      ]);

      $curl = curl_init();
      curl_setopt_array($curl, [
        CURLOPT_URL => self::VALIDATOR,
        CURLOPT_HTTPHEADER => ['Content-Type: application/json'],
        CURLOPT_POST => true,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POSTFIELDS => $data,
      ]);
      $result = curl_exec($curl);

      $http_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
      if (200 == $http_code) {
        return new self($result);
      }

      if (500 <= $http_code) {
        $code = $http_code;
        $error = curl_errno($curl);
        $message = curl_error($curl) . $result;
        throw new LiveValidationException(sprintf('%s %s', $error, $message), $code);
      }

      if (false === $result) {
        $code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
        $error = curl_errno($curl);
        $message = curl_error($curl);
        throw new LiveValidationException(sprintf('%s %s %s', $code, $error, $message));
      }

      throw new LiveValidationException($result);
      $result = json_decode($result, true);
      throw new LiveValidationException(sprintf('%s: %s', $result['message'] ?? '', $result['content'] ?? ''), $result['code'] ?? 0);
    }
  }
