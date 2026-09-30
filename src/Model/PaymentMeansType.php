<?php
/*
  Copyright 2025, Fawno (https://github.com/fawno)

  Licensed under The MIT License
  Redistributions of files must retain the above copyright notice.

  @copyright Copyright 2025, Fawno (https://github.com/fawno)
  @license MIT License (http://www.opensource.org/licenses/mit-license.php)
*/
  declare(strict_types=1);

  namespace Fawno\Facturae\Model;

  enum PaymentMeansType : string {
    public const string ERROR_DEBIT_REQUIRED = 'El medio de pago 02 (Direct debit) requiere la etiqueta <AccountToBeDebited>.';
    public const string ERROR_CREDIT_REQUIRED = 'El medio de pago 04 (Credit transfer) requiere la etiqueta <AccountToBeCredited>.';

    case CONTADO               = '01';
    case RECIBO_DOMICILIADO    = '02';
    case RECIBO                = '03';
    case TRANSFERENCIA         = '04';
    case LETRA_ACEPTADA        = '05';
    case LETRA_CAMBIO          = '08';
    case PAGARE_A_LA_ORDEN     = '09';
    case PAGARE_NO_A_LA_ORDEN  = '10';
    case CHEQUE                = '11';
    case REPOSICION            = '12';
    case ESPECIALES            = '13';
    case COMPENSACION          = '14';
    case GIRO_POSTAL           = '15';
    case CHEQUE_CONFORMADO     = '16';
    case CHEQUE_BANCARIO       = '17';
    case PAGO_CONTRA_REEMBOLSO = '18';
    case TARJETA_PAGO          = '19';

    public function description (string $lang = 'es') : string {
      return match (strtolower($lang)) {
        'en' => match ($this) {
          self::CONTADO               => 'In cash',
          self::RECIBO_DOMICILIADO    => 'Direct debit',
          self::RECIBO                => 'Receipt',
          self::TRANSFERENCIA         => 'Credit transfer',
          self::LETRA_ACEPTADA        => 'Accepted bill of exchange',
          self::LETRA_CAMBIO          => 'Bill of exchange',
          self::PAGARE_A_LA_ORDEN     => 'Transferable promissory note',
          self::PAGARE_NO_A_LA_ORDEN  => 'Non transferable promissory note',
          self::CHEQUE                => 'Cheque',
          self::REPOSICION            => 'Open account reimbursement',
          self::ESPECIALES            => 'Special payment',
          self::COMPENSACION          => 'Set off by reciprocal credits',
          self::GIRO_POSTAL           => 'Payment by postgiro',
          self::CHEQUE_CONFORMADO     => 'Certified cheque',
          self::CHEQUE_BANCARIO       => 'Banker\'s draft',
          self::PAGO_CONTRA_REEMBOLSO => 'Cash on delivery',
          self::TARJETA_PAGO          => 'Payment by card',
        },
        default => match ($this) {
          self::CONTADO               => 'Al contado',
          self::RECIBO_DOMICILIADO    => 'Recibo Domiciliado',
          self::RECIBO                => 'Recibo',
          self::TRANSFERENCIA         => 'Transferencia',
          self::LETRA_ACEPTADA        => 'Letra Aceptada',
          self::LETRA_CAMBIO          => 'Letra de cambio',
          self::PAGARE_A_LA_ORDEN     => 'Pagaré a la Orden',
          self::PAGARE_NO_A_LA_ORDEN  => 'Pagaré No a la Orden',
          self::CHEQUE                => 'Cheque',
          self::REPOSICION            => 'Reposición',
          self::ESPECIALES            => 'Especiales',
          self::COMPENSACION          => 'Compensación',
          self::GIRO_POSTAL           => 'Giro postal',
          self::CHEQUE_CONFORMADO     => 'Cheque conformado',
          self::CHEQUE_BANCARIO       => 'Cheque bancario',
          self::PAGO_CONTRA_REEMBOLSO => 'Pago contra reembolso',
          self::TARJETA_PAGO          => 'Tarjeta de pago',
        }
      };
    }

    public function requiresAccountToBeDebited () : bool {
      return $this === self::RECIBO_DOMICILIADO;
    }

    public function requiresAccountToBeCredited () : bool {
      return $this === self::TRANSFERENCIA;
    }
  }
