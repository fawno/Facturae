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

  use Fawno\Facturae\Signer\CertificateStore;
  use Fawno\Facturae\Signer\SignatureIds;

  final class FacturaeSigner {
    const XMLNS_DS = 'http://www.w3.org/2000/09/xmldsig#';
    const XMLNS_XADES = 'http://uri.etsi.org/01903/v1.3.2#';
    const SIGN_POLICY_NAME = 'Política de Firma FacturaE v3.1';
    const SIGN_POLICY_URL = 'http://www.facturae.es/politica_de_firma_formato_facturae/politica_de_firma_formato_facturae_v3_1.pdf';
    const SIGN_POLICY_DIGEST = 'Ohixl6upD6av8N7pEvDABhEL6hM=';

    public static function randomId () : int {
      return function_exists('random_int') ? random_int(0x10000000, 0x7FFFFFFF) : rand(100000, 999999);
    }

    private static function getSignatureIds () : object {
      return new class {
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
          $this->signatureId = 'Signature' . FacturaeSigner::randomId();
          $this->signedInfoId = 'Signature-SignedInfo' . FacturaeSigner::randomId();
          $this->signedPropertiesId = 'SignedPropertiesID' . FacturaeSigner::randomId();
          $this->signatureValueId = 'SignatureValue' . FacturaeSigner::randomId();
          $this->certificateId = 'Certificate' . FacturaeSigner::randomId();
          $this->referenceId = 'Reference-ID-' . FacturaeSigner::randomId();
          $this->signatureSignedPropertiesId = $this->signatureId . '-SignedProperties' . FacturaeSigner::randomId();
          $this->signatureObjectId = $this->signatureId . '-Object' . FacturaeSigner::randomId();
          $this->timestampId = 'Timestamp-' . FacturaeSigner::randomId();
        }
      };
    }

    public static function sign (Facturae $facturae, CertificateStore $certificateStore, int|string|null $signingTime = null) : ?Facturae {
      $ids = self::getSignatureIds();
      $signingTime = empty($signingTime) ? time() : $signingTime;
      $signingTime = is_string($signingTime) ? strtotime($signingTime) : $signingTime;

      $unsigned = $facturae->removeSignature()->asDOM();
      $unsigned->createAttributeNS(self::XMLNS_DS, 'ds:attr');

      $xmlns = $unsigned->getDocumentNamespaces(['xmlns:xades' => self::XMLNS_XADES]);

      // Build <xades:SignedProperties /> element
      $xadesSignedProperties = $unsigned->createElement('xades:SignedProperties');
      $xadesSignedProperties->setAttribute('Id', $ids->signatureSignedPropertiesId);
      $xadesSignedSignatureProperties = $xadesSignedProperties->appendChild($unsigned->createElement('xades:SignedSignatureProperties'));
      $xadesSignedSignatureProperties->appendChild($unsigned->createElement('xades:SigningTime', date('c', $signingTime)));
      $xadesSigningCertificate = $xadesSignedSignatureProperties->appendChild($unsigned->createElement('xades:SigningCertificate'));
      $xadesCert = $xadesSigningCertificate->appendChild($unsigned->createElement('xades:Cert'));
      $xadesCertDigest = $xadesCert->appendChild($unsigned->createElement('xades:CertDigest'));
      $dsDigestMethod = $xadesCertDigest->appendChild($unsigned->createElement('ds:DigestMethod'));
      $dsDigestMethod->setAttribute('Algorithm', 'http://www.w3.org/2001/04/xmlenc#sha512');
      $dsDigestMethod->appendChild($unsigned->createTextNode(''));
      $xadesCertDigest->appendChild($unsigned->createElement('ds:DigestValue', $certificateStore->getCertificateDigest()));
      $xadesIssuerSerial = $xadesCert->appendChild($unsigned->createElement('xades:IssuerSerial'));
      $xadesIssuerSerial->appendChild($unsigned->createElement('ds:X509IssuerName', $certificateStore->getDistinguishedName()));
      $xadesIssuerSerial->appendChild($unsigned->createElement('ds:X509SerialNumber', $certificateStore->getSerialNumber()));
      $xadesSignaturePolicyIdentifier = $xadesSignedSignatureProperties->appendChild($unsigned->createElement('xades:SignaturePolicyIdentifier'));
      $xadesSignaturePolicyId = $xadesSignaturePolicyIdentifier->appendChild($unsigned->createElement('xades:SignaturePolicyId'));
      $xadesSigPolicyId = $xadesSignaturePolicyId->appendChild($unsigned->createElement('xades:SigPolicyId'));
      $xadesSigPolicyId->appendChild($unsigned->createElement('xades:Identifier', self::SIGN_POLICY_URL));
      $xadesSigPolicyId->appendChild($unsigned->createElement('xades:Description', self::SIGN_POLICY_NAME));
      $xadesSigPolicyHash = $xadesSignaturePolicyId->appendChild($unsigned->createElement('xades:SigPolicyHash'));
      $dsDigestMethod = $xadesSigPolicyHash->appendChild($unsigned->createElement('ds:DigestMethod'));
      $dsDigestMethod->setAttribute('Algorithm', 'http://www.w3.org/2000/09/xmldsig#sha1');
      $dsDigestMethod->appendChild($unsigned->createTextNode(''));
      $xadesSigPolicyHash->appendChild($unsigned->createElement('ds:DigestValue', self::SIGN_POLICY_DIGEST));
      $xadesSignerRole = $xadesSignedSignatureProperties->appendChild($unsigned->createElement('xades:SignerRole'));
      $xadesClaimedRoles = $xadesSignerRole->appendChild($unsigned->createElement('xades:ClaimedRoles'));
      $xadesClaimedRoles->appendChild($unsigned->createElement('xades:ClaimedRole', 'emisor'));
      $xadesSignedDataObjectProperties = $xadesSignedProperties->appendChild($unsigned->createElement('xades:SignedDataObjectProperties'));
      $xadesDataObjectFormat = $xadesSignedDataObjectProperties->appendChild($unsigned->createElement('xades:DataObjectFormat'));
      $xadesDataObjectFormat->setAttribute('ObjectReference', '#' . $ids->referenceId);
      $xadesDataObjectFormat->appendChild($unsigned->createElement('xades:Description', 'Factura electrónica'));
      $xadesObjectIdentifier = $xadesDataObjectFormat->appendChild($unsigned->createElement('xades:ObjectIdentifier'));
      $xadesIdentifier = $xadesObjectIdentifier->appendChild($unsigned->createElement('xades:Identifier', 'urn:oid:1.2.840.10003.5.109.10'));
      $xadesIdentifier->setAttribute('Qualifier', 'OIDAsURN');
      $xadesDataObjectFormat->appendChild($unsigned->createElement('xades:MimeType', 'text/xml'));

      // Build <ds:KeyInfo /> element
      $dsKeyInfo = $unsigned->createElement('ds:KeyInfo');
      $dsKeyInfo->setAttribute('Id', $ids->certificateId);
      $dsX509Data = $dsKeyInfo->appendChild($unsigned->createElement('ds:X509Data'));
      foreach ($certificateStore->getPublicChain() as $pemCertificate) {
        $dsX509Data->appendChild($unsigned->createElement('ds:X509Certificate', CertificateStore::getCert($pemCertificate)));
      }
      $dsKeyValue = $dsKeyInfo->appendChild($unsigned->createElement('ds:KeyValue'));
      $RSAKeyValue = $dsKeyValue->appendChild($unsigned->createElement('ds:RSAKeyValue'));
      $RSAKeyValue->appendChild($unsigned->createElement('ds:Modulus', $certificateStore->getModulus()));
      $RSAKeyValue->appendChild($unsigned->createElement('ds:Exponent', $certificateStore->getExponent()));

      // Build <ds:SignedInfo /> element
      $dsSignedInfo = $unsigned->createElement('ds:SignedInfo');
      $dsSignedInfo->setAttribute('Id', $ids->signedInfoId);
      $dsCanonicalizationMethod = $dsSignedInfo->appendChild($unsigned->createElement('ds:CanonicalizationMethod'));
      $dsCanonicalizationMethod->setAttribute('Algorithm', 'http://www.w3.org/TR/2001/REC-xml-c14n-20010315');
      $dsCanonicalizationMethod->appendChild($unsigned->createTextNode(''));
      $dsSignatureMethod = $dsSignedInfo->appendChild($unsigned->createElement('ds:SignatureMethod'));
      $dsSignatureMethod->setAttribute('Algorithm', 'http://www.w3.org/2001/04/xmldsig-more#rsa-sha512');
      $dsSignatureMethod->appendChild($unsigned->createTextNode(''));

      $dsReference = $dsSignedInfo->appendChild($unsigned->createElement('ds:Reference'));
      $dsReference->setAttribute('Id', $ids->signedPropertiesId);
      $dsReference->setAttribute('Type', 'http://uri.etsi.org/01903#SignedProperties');
      $dsReference->setAttribute('URI', '#' . $ids->signatureSignedPropertiesId);
      $dsDigestMethod = $dsReference->appendChild($unsigned->createElement('ds:DigestMethod'));
      $dsDigestMethod->setAttribute('Algorithm', 'http://www.w3.org/2001/04/xmlenc#sha512');
      $dsDigestMethod->appendChild($unsigned->createTextNode(''));
      $dsReference->appendChild($unsigned->createElement('ds:DigestValue', CertificateStore::getDigest($unsigned->injectNamespaces($xadesSignedProperties, $xmlns))));

      $dsReference = $dsSignedInfo->appendChild($unsigned->createElement('ds:Reference'));
      $dsReference->setAttribute('URI', '#' . $ids->certificateId);
      $dsDigestMethod = $dsReference->appendChild($unsigned->createElement('ds:DigestMethod'));
      $dsDigestMethod->setAttribute('Algorithm', 'http://www.w3.org/2001/04/xmlenc#sha512');
      $dsDigestMethod->appendChild($unsigned->createTextNode(''));
      $dsReference->appendChild($unsigned->createElement('ds:DigestValue', CertificateStore::getDigest($unsigned->injectNamespaces($dsKeyInfo, $xmlns))));

      $dsReference = $dsSignedInfo->appendChild($unsigned->createElement('ds:Reference'));
      $dsReference->setAttribute('Id', $ids->referenceId);
      $dsReference->setAttribute('Type', 'http://www.w3.org/2000/09/xmldsig#Object');
      $dsReference->setAttribute('URI', '');
      $dsTransforms = $dsReference->appendChild($unsigned->createElement('ds:Transforms'));
      $dsTransform = $dsTransforms->appendChild($unsigned->createElement('ds:Transform'));
      $dsTransform->setAttribute('Algorithm', 'http://www.w3.org/2000/09/xmldsig#enveloped-signature');
      $dsTransform->appendChild($unsigned->createTextNode(''));
      $dsDigestMethod = $dsReference->appendChild($unsigned->createElement('ds:DigestMethod'));
      $dsDigestMethod->setAttribute('Algorithm', 'http://www.w3.org/2001/04/xmlenc#sha512');
      $dsDigestMethod->appendChild($unsigned->createTextNode(''));
      $dsReference->appendChild($unsigned->createElement('ds:DigestValue', CertificateStore::getDigest($unsigned->C14N())));

      // Build <ds:Signature /> element
      $dsSignature = $unsigned->createElement('ds:Signature');
      $dsSignature->setAttribute('xmlns:xades', self::XMLNS_XADES);
      $dsSignature->setAttribute('Id', $ids->signatureId);
      $dsSignature->appendChild($dsSignedInfo);
      $dsSignatureValue = $certificateStore->sign($unsigned->injectNamespaces($dsSignedInfo, $xmlns));
      $dsSignatureValue = $dsSignature->appendChild($unsigned->createElement('ds:SignatureValue', $dsSignatureValue));
      $dsSignatureValue->setAttribute('Id', $ids->signatureValueId);
      $dsSignature->appendChild($dsKeyInfo);
      $dsObject = $dsSignature->appendChild($unsigned->createElement('ds:Object'));
      $dsObject->setAttribute('Id', $ids->signatureObjectId);
      $xadesQualifyingProperties = $dsObject->appendChild($unsigned->createElement('xades:QualifyingProperties'));
      $xadesQualifyingProperties->setAttribute('Target', '#' . $ids->signatureId);
      $xadesQualifyingProperties->appendChild($xadesSignedProperties);

      $unsigned->documentElement->append($dsSignature);

      return $unsigned->asFacturae();
    }
  }
