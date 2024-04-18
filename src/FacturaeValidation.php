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

  use Exception;
  use Fawno\FaceRelations\apiRelations;
  use Fawno\Facturae\Error\BuyerTIN\InvalidBuyerTINError;
  use Fawno\Facturae\Error\BuyerTIN\MissingBuyerTINError;
  use Fawno\Facturae\Error\DIR3\MissingDIR3Error;
  use Fawno\Facturae\Error\IBAN\InvalidIBANError;
  use Fawno\Facturae\Error\IBAN\MissingIBANError;

  class FacturaeValidation {
    protected array $errors = [];

    public function __construct (Facturae $facturae) {
      try {
        $schema = new FacturaeSchema($facturae);
        $this->errors = $schema->getErrors();
      } catch (Exception $exception) {
        $this->errors[] = $exception;
      }
      /*
			$response['error'] = array_merge($response['error'], array_map(function ($error) {
				return __('[Level {0}] {1}', $error['level'], $error['message']);
			}, $errors));
			*/

      try {
        $signature = new FacturaeSignature($facturae);
        if (!$signature->isValid()) {
          $this->errors[] = $signature->getError();
        }
      } catch (Exception $exception) {
        $this->errors[] = $exception;
      }

      $buyer_tin = $facturae->getBuyerTIN();
      if (!apiRelations::nif_validation($buyer_tin)) {
        $this->errors[] = $buyer_tin ? (new InvalidBuyerTINError()) : (new MissingBuyerTINError());
      }

      $iban = $facturae->getIBAN();
      if (!verify_iban($iban)) {
        $this->errors[] = $iban ? (new InvalidIBANError()) : (new MissingIBANError());
      }

			$dir3 = $facturae->getDIR3();
			if (count($dir3) < 3) {
        $this->errors[] = new MissingDIR3Error();
			}
    }

    public function isValid () : bool {
      return !((bool) count($this->errors));
    }

    public function getErrors () : array {
      return $this->errors;
    }
  }
