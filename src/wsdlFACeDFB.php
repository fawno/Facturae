<?php
/*
  Copyright 2018, Fawno (https://github.com/fawno)

  Licensed under The MIT License
  Redistributions of files must retain the above copyright notice.

  @copyright Copyright 2018, Fawno (https://github.com/fawno)
  @license MIT License (http://www.opensource.org/licenses/mit-license.php)
*/

  namespace Fawno\Facturae;

  use Fawno\Facturae\wsdlFACe;

  class wsdlFACeDFB extends wsdlFACe {
    protected $devel = 'http://80.245.0.101/CGS2/FacturaSSPPWebServiceProxyPort?WSDL';
    protected $wsdl = 'http://apps.bizkaia.net/CGS2/FacturaSSPPWebServiceProxyPort?WSDL';
    protected $private_key = null;
    protected $public_key = null;

    public function __construct ($pkcs12_file = null, $pkcs12_pass = null, $options = [], $devel = false, $ssl_verifypeer = true) {
      if ($devel) $this->wsdl = $this->devel;
      $options['location'] = $this->wsdl;

      return parent::__construct($pkcs12_file, $pkcs12_pass, $options, $devel, $ssl_verifypeer);
    }
  }
