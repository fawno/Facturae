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

  use InvalidArgumentException;
  use OpenSSLAsymmetricKey;
  use OpenSSLCertificate;
  use RuntimeException;

  class CertificateStore {
    public const ALLOWED_OID_TYPES = [
      // Mandatory fields in https://datatracker.ietf.org/doc/html/rfc4514#section-3
      'CN'     => 'CN',
      'L'      => 'L',
      'ST'     => 'ST',
      'O'      => 'O',
      'OU'     => 'OU',
      'C'      => 'C',
      'STREET' => 'STREET',
      'DC'     => 'DC',
      'UID'    => 'UID',

      // Other fields with well-known names
      'GN' => 'GN',
      'SN' => 'SN',

      // Other fields with compatibility issues
      'organizationIdentifier' => 'OID.2.5.4.97',
      'serialNumber'           => 'OID.2.5.4.5',
      'title'                  => 'OID.2.5.4.12',

      // Fix for undefined properties in OpenSSL <3.0.0
      'UNDEF'                  => 'OID.2.5.4.97',
    ];

    private OpenSSLCertificate|false $certificate = false;
    private string|false $pemCertificate = false;
    private array|false $publicData = false;
    private OpenSSLAsymmetricKey|false $privateKey = false;
    private array $publicChain = [];

    public function __construct (OpenSSLCertificate|string $certificate, OpenSSLAsymmetricKey|OpenSSLCertificate|array|string $privateKey, array $publicChain = []) {
      $this->certificate = self::readCertificate($certificate);
      if ($this->certificate === false) {
        throw new RuntimeException('Error reading certificate');
      }

      $this->privateKey = self::readPrivateKey($privateKey);
      if ($this->privateKey === false) {
        throw new RuntimeException('Error reading private key');
      }

      $this->pemCertificate = self::normaliceCertificate($this->certificate);
      if ($this->pemCertificate === false) {
        throw new RuntimeException('Error normalizing certificate');
      }

      $this->publicData = openssl_x509_parse($this->certificate);
      if ($this->publicData === false) {
        throw new RuntimeException('Error parsing certificate');
      }

      $this->publicChain = [$this->pemCertificate];

      foreach ($publicChain as $key => $cert) {
        $cert = self::readCertificate($cert);
        if ($cert === false) {
          throw new InvalidArgumentException('Error reading public chain certificate #' . $key);
        }

        $cert = self::normaliceCertificate($cert);
        if ($cert === false) {
          throw new InvalidArgumentException('Error normalizing public chain certificate #' . $key);
        }

        $this->publicChain[] = $cert;
      }
    }

    public static function loadPKCS12 (string $pkcs12, string $passphrase) : CertificateStore {
      if (empty($pkcs12) or empty($passphrase)) {
        throw new InvalidArgumentException();
      }

      $pkcs12 = is_file($pkcs12) ? file_get_contents($pkcs12) : $pkcs12;
      if ($pkcs12 === false) {
        throw new RuntimeException('Error reading PKCS#12 certificate file');
      }

      if (!openssl_pkcs12_read($pkcs12, $store, $passphrase)) {
        throw new RuntimeException('Error parsing PKCS#12 certificate store');
      }

      $store += ['cert' => '', 'pkey' => '', 'extracerts' => []];

      return new self(...array_values($store));
    }

    public static function readCertificate (OpenSSLCertificate|string $certificate) : OpenSSLCertificate|false {
      if (is_string($certificate) and is_file($certificate)) {
        $certificate = file_get_contents($certificate);
      }

      return !empty($certificate) ? openssl_x509_read($certificate) : false;
    }

    public static function readPrivateKey (OpenSSLAsymmetricKey|OpenSSLCertificate|array|string $privateKey, ?string $passphrase = null) : OpenSSLAsymmetricKey|false {
      if (is_string($privateKey) and is_file($privateKey)) {
        $privateKey = file_get_contents($privateKey);
      }

      return !empty($privateKey) ? openssl_pkey_get_private($privateKey, $passphrase) : false;
    }

    public static function normaliceCertificate (OpenSSLCertificate|string $certificate) : string|false {
      return openssl_x509_export($certificate, $normalizedCertificate) ? $normalizedCertificate : false;
    }

    public static function getCert (string $pem, bool $pretty = true) : string {
      $pem = preg_replace('~(-----BEGIN CERTIFICATE-----|-----END CERTIFICATE-----|\r|\n)~', '', $pem);
      return $pretty ? self::prettify($pem) : $pem;
    }

    public static function getCertDigest (OpenSSLCertificate|string $publicKey, bool $pretty = false) : string {
      $digest = openssl_x509_fingerprint($publicKey, 'sha512', true);
      return self::toBase64($digest, $pretty);
    }

    public static function getCertDistinguishedName (array $data) : string {
      $name = [];
      $data = array_intersect_key($data, self::ALLOWED_OID_TYPES);
      foreach ($data as $rawType => $rawValue) {
        $values = is_array($rawValue) ? $rawValue : [$rawValue];
        foreach ($values as $value) {
          // Fix for undefined properties in OpenSSL <3.0.0
          if ($rawType === 'UNDEF') {
            $decodedValue = (substr($value, 0, 1) === '#') ? hex2bin(substr($value, 5)) : $value;
            if (!preg_match('~^VAT[A-Z]{2}-~', $decodedValue)) {
              continue;
            }
          }
          $name[] = self::ALLOWED_OID_TYPES[$rawType] . '=' . $value;
        }
      }

      return implode(', ', array_reverse($name));
    }

    public static function getDigest(string $input, bool $pretty = false) : string {
      return self::toBase64(hash('sha512', $input, true), $pretty);
    }

    public static function getSignature(string $payload, OpenSSLAsymmetricKey|OpenSSLCertificate|array|string $privateKey, bool $pretty = true) : string {
      openssl_sign($payload, $signature, $privateKey, OPENSSL_ALGO_SHA512);
      return self::toBase64($signature, $pretty);
    }

    public function sign (string $payload, bool $pretty = true) : string {
      return self::getSignature($payload, $this->privateKey, $pretty);
    }

    public static function toBase64 (string $bytes, bool $pretty = false) : string {
      $res = base64_encode($bytes);
      return $pretty ? self::prettify($res) : $res;
    }

    public static function prettify (string $input) : string {
      return chunk_split($input, 76, "\n");
    }

    public function getPublicChain () : array {
      return $this->publicChain;
    }

    public function getPemCertificate () : string {
      return $this->pemCertificate;
    }

    public function getCertificateDigest (bool $pretty = false) : string {
      return self::getCertDigest($this->certificate, $pretty);
    }

    public function getCertificate () : OpenSSLCertificate {
      return $this->certificate;
    }

    public function getPublicData () : array|false {
      return $this->publicData;
    }

    public function getSerialNumber () : string {
      return $this->publicData['serialNumber'];
    }

    public function getDistinguishedName () : string {
      return self::getCertDistinguishedName($this->publicData['issuer']);
    }

    public function getPrivateKey () : OpenSSLAsymmetricKey {
      return $this->privateKey;
    }

    public function getPemPrivateKey () : string {
      openssl_pkey_export($this->privateKey, $pkey);

      return $pkey;
    }

    public function getPrivateData () : array|false {
      return openssl_pkey_get_details($this->privateKey);
    }

    public function getModulus () : string {
      $privateData = $this->getPrivateData();
      return self::toBase64($privateData['rsa']['n'], true);
    }

    public function getExponent () : string {
      $privateData = $this->getPrivateData();
      return self::toBase64($privateData['rsa']['e']);
    }
  }
