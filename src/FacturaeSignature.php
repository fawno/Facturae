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
  use DOMNode;
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
  use RobRichards\XMLSecLibs\XMLSecurityKey;

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

      if (!($signature instanceof DOMNode)) {
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

      if (!($key instanceof XMLSecurityKey)) {
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

      $cert = $key->getX509Certificate();
      if (!$cert) {
        return $this;
      }

      $issue_date_t = $facturae->getIssueDate()->getTimestamp();
      $data = openssl_x509_parse($cert);

      if ($issue_date_t < $data['validFrom_time_t']) {
        $valid_from = (new DateTimeImmutable('@' . $data['validFrom_time_t']))->format('Y-m-d H:i:s');
        $this->error = new InvalidSignatureError(sprintf('Certificate valid from %s', $valid_from));
        return $this;
      }

      if ($data['validTo_time_t'] < $issue_date_t) {
        $valid_to = (new DateTimeImmutable('@' . $data['validTo_time_t']))->format('Y-m-d H:i:s');
        $this->error = new InvalidSignatureError(sprintf('Expired certificate: %s', $valid_to));
        return $this;
      }
    }

    public function isValid () : bool {
      return is_null($this->error);
    }

    public function getError () : ?Error {
      return $this->error;
    }
  }
