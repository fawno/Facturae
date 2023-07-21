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

  class wsdlFACeGV extends wsdlFACe {
    protected $devel = 'https://svc.integracion.test.euskadi.net/ctxweb/secured_ssl/w42ajEFacturaSSPP2?WSDL';
    protected $wsdl = 'https://svc.integracion.euskadi.net/ctxweb/secured_ssl/w42ajEFacturaSSPP2?WSDL';
    protected $private_key = null;
    protected $public_key = null;

    public function __construct (?string $pkcs12_file = null, ?string $pkcs12_pass = null, array $options = [], bool $devel = false, bool $ssl_verifypeer = true) {
      $options['location'] = $options['location'] ?? ($devel ? $this->devel : $this->wsdl);

      return parent::__construct($pkcs12_file, $pkcs12_pass, $options, $devel, $ssl_verifypeer);
    }
  }
