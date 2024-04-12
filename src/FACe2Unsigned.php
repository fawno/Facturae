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

  use Fawno\Facturae\FACe2;

  class FACe2Unsigned extends FACe2 {
    public function __construct (?string $pkcs12 = null, ?string $pkcs12_pass = null, array $options = [], bool $devel = false, bool $ssl_verifypeer = true) {
      $options['wsdl'] = $options['wsdl'] ?? self::WSDL;

      parent::__construct($pkcs12, $pkcs12_pass, $options, $devel, $ssl_verifypeer);
    }

    public function signRequest (string $request) : string {
      return $request;
    }
  }
