# wsdlFACe
Clase para el [Web Service de FACe](https://face.gob.es/es).

#### Información y descargas de manuales:

- http://administracionelectronica.gob.es/ctt/face/descargas

#### Para registrarse como proveedor

- Entorno de producción: https://face.gob.es/es/proveedores
- Entorno de pruebas: https://se-face.redsara.es/es/proveedores

# Requisitos

- PHP version 5.6 o superior con las extensiones openssl y soap habilitadas.
- [robrichards/xmlseclibs](https://github.com/robrichards/xmlseclibs) 2.0 o superior
- [robrichards/wse-php](https://github.com/robrichards/wse-php) 2.0 o superior

## Instalación

### Instalar con [`composer.phar`](http://getcomposer.org).

Añade `fawno/facturae` como requisito a tu proyecto:

```sh
php composer.phar require "fawno/facturae"
```
Carga la clase en tu script:

```php
<?php
  require 'vendor/autoload.php';

  use Fawno\Facturae\wsdlFACe;
```

### Instalación manual

Descarga los siguientes archivos y guardalos en una ruta accesible:

- [wsdlFACe.php](https://github.com/fawno/facturae/raw/master/src/wsdlFACe.php)
- [WSASoap.php](https://github.com/robrichards/wse-php/raw/master/src/WSASoap.php)
- [WSSESoap.php](https://github.com/robrichards/wse-php/raw/master/src/WSSESoap.php)
- [XMLSecurityKey.php](https://github.com/robrichards/xmlseclibs/raw/master/src/XMLSecurityKey.php)
- [XMLSecurityDSig.php](https://github.com/robrichards/xmlseclibs/raw/master/src/XMLSecurityDSig.php)
- [XMLSecEnc.php](https://github.com/robrichards/xmlseclibs/raw/master/src/XMLSecEnc.php)


Carga los archivos descargados en tu script:

```php
<?php
  require 'WSASoap.php';
  require 'WSSESoap.php';
  require 'XMLSecurityKey.php';
  require 'XMLSecurityDSig.php';
  require 'XMLSecEnc.php';
  require 'wsdlFACe.php';

  use Fawno\Facturae\wsdlFACe;
```

# Ejemplo:
Ejemplo de envío de una factura:

```php
<?php
  require 'vendor/autoload.php';

  use Fawno\Facturae\wsdlFACe;

  $verify_peer = true;
  $devel = true;

  try {
    $wsdlFACe = new wsdlFACe(null, null, array('trace' => true), $devel, $verify_peer);
  } catch (SoapFault $fault) {
    print_r($fault);
    die();
  }

  $wsdlFACe->set_pkcs12('certificado.pfx', 'contraseña');

  $xmlfile = 'factura-prueba-v1-2-0.xml';
  $correo = 'example@example.com';

  try {
    $response = $wsdlFACe->enviarFactura($correo, $xmlfile);
    print_r($response);
  } catch (SoapFault $fault) {
    print_r($fault);
  }
```
