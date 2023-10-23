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

  class wsdlFACeDFG extends FACe2 {
    public const WSDL_DEV  = 'https://w390w.gipuzkoa.net/WAS/HACI/HFAServiciosProveedoresWEB/services/FacturaSSPPWebServiceProxyPort?wsdl';
    public const WSDL      = 'https://w390w.gipuzkoa.net/WAS/HACI/HFAServiciosProveedoresWEB/services/FacturaSSPPWebServiceProxyPort?wsdl';

    public function __construct (?string $pkcs12_file = null, ?string $pkcs12_pass = null, array $options = [], bool $devel = false, bool $ssl_verifypeer = true) {
      $options['location'] = $options['location'] ?? ($devel ? self::WSDL_DEV : self::WSDL);

      return parent::__construct($pkcs12_file, $pkcs12_pass, $options, $devel, $ssl_verifypeer);
    }
  }
