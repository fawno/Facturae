<?php
/*
  Copyright 2025, Fawno (https://github.com/fawno)

  Licensed under The MIT License
  Redistributions of files must retain the above copyright notice.

  @copyright Copyright 2025, Fawno (https://github.com/fawno)
  @license MIT License (http://www.opensource.org/licenses/mit-license.php)
*/
  declare(strict_types=1);

  namespace Fawno\Facturae\LiveValidation;

  use DateTime;
  use Fawno\Facturae\Infrastructure\Entity;

  class LiveValidationInvoice extends Entity {
    public string $serial;
    public string $number;
    public string $serialNumber;
    public DateTime $expeditionDate;
    public LiveValidationParty $seller;
    public LiveValidationParty $buyer;
    public string $type;
    public bool $repository;
    public bool $hasRcfFace;
    public LiveValidationAdministrativeCentre $oc;
    public LiveValidationAdministrativeCentre $og;
    public LiveValidationAdministrativeCentre $ut;
    public float $amount;
    public string $currency;
    public array $factoringAssignmentDocuments;
    public LiveValidationFacturae $facturae;
    public array $attachments;
    public LiveValidationParty $signer;
  }
