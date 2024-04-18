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

  use Error;
  use Exception;
  use Fawno\Facturae\Error\Signature\InvalidSignatureError;
  use Fawno\Facturae\Error\Signature\LocatingKeySignatureError;
  use Fawno\Facturae\Error\Signature\LocatingSignatureError;
  use Fawno\Facturae\Error\Signature\MissingKeySignatureError;
  use Fawno\Facturae\Error\Signature\MissingSignatureError;
  use Fawno\Facturae\Error\Signature\VerifyingSignatureError;
  use Fawno\Facturae\Facturae;
  use RobRichards\XMLSecLibs\XMLSecEnc;
  use RobRichards\XMLSecLibs\XMLSecurityDSig;

  class FacturaeSignature {
    protected ?Error $error = null;

    public function __construct (Facturae $facturae) {
			$objXMLSecDSig = new XMLSecurityDSig();
      try {
        $signature = $objXMLSecDSig->locateSignature($facturae->asDOM());
      } catch (Exception $exception) {
        $this->error = new LocatingSignatureError('Error locating signature', 0, $exception);
        return $this;
      }

      if (!$signature) {
        $this->error = new MissingSignatureError('Missing signature node');
        return $this;
      }

      try {
        $objXMLSecDSig->canonicalizeSignedInfo();
        $key = $objXMLSecDSig->locateKey();
      } catch (Exception $exception) {
        $this->error = new LocatingKeySignatureError('Error locating key', 0, $exception);
        return $this;
      }

      if (!$key) {
        $this->error = new MissingKeySignatureError('Missing key node');
        return $this;
      }

      try {
        XMLSecEnc::staticLocateKeyInfo($key, $signature);
        $verify = $objXMLSecDSig->verify($key);
      } catch (Exception $exception) {
        $this->error = new VerifyingSignatureError('Verifying error', 0, $exception);
        return $this;
      }

      if (-1 === $verify) {
        $this->error = new VerifyingSignatureError('Verifying error');
        return $this;
      }

      if (1 !== $verify) {
        $this->error = new InvalidSignatureError('Invalid signature');
      }
    }

    public function isValid () : bool {
      return is_null($this->error);
    }

    public function getError () : ?Error {
      return $this->error;
    }
  }
