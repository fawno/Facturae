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

  class SignatureIds {
    public string $signatureId;
    public string $signedInfoId;
    public string $signedPropertiesId;
    public string $signatureValueId;
    public string $certificateId;
    public string $referenceId;
    public string $signatureSignedPropertiesId;
    public string $signatureObjectId;
    public string $timestampId;

    public function __construct () {
      $this->signatureId = 'Signature' . self::randomId();
      $this->signedInfoId = 'Signature-SignedInfo' . self::randomId();
      $this->signedPropertiesId = 'SignedPropertiesID' . self::randomId();
      $this->signatureValueId = 'SignatureValue' . self::randomId();
      $this->certificateId = 'Certificate' . self::randomId();
      $this->referenceId = 'Reference-ID-' . self::randomId();
      $this->signatureSignedPropertiesId = $this->signatureId . '-SignedProperties' . self::randomId();
      $this->signatureObjectId = $this->signatureId . '-Object' . self::randomId();
    }

    public static function randomId () : int {
      return function_exists('random_int') ? random_int(0x10000000, 0x7FFFFFFF) : rand(100000, 999999);
    }
  }
