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

  use Fawno\Facturae\FACe1;
  use SoapVar;

  class wsdlConsorcioAguas extends FACe1 {
    public const WSDL_DEV  = 'https://portaldigital.consorciodeaguas.com:8443/sspp_pr/services/sspp?wsdl';
    public const WSDL      = 'https://portaldigital.consorciodeaguas.com:8443/sspp/services/sspp?wsdl';

    public function __construct (?string $pkcs12_file = null, ?string $pkcs12_pass = null, array $options = [], bool $devel = false, bool $ssl_verifypeer = true) {
      $options['location'] = $options['location'] ?? ($devel ? self::WSDL_DEV : self::WSDL);

      return parent::__construct($pkcs12_file, $pkcs12_pass, $options, $devel, $ssl_verifypeer);
    }
  }
