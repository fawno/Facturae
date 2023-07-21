[![GitHub license](https://img.shields.io/github/license/fawno/Facturae.svg)](https://github.com/fawno/Facturae/blob/master/LICENSE)
[![GitHub release](https://img.shields.io/github/release/fawno/Facturae.svg)](https://github.com/fawno/Facturae/releases)
[![Packagist](https://img.shields.io/packagist/v/fawno/Facturae.svg)](https://packagist.org/packages/fawno/facturae)
[![Documentation](https://img.shields.io/badge/manual-wsdlFACe-blue.svg)](docs/wsdlFACe.md)

# Facturae
Clases para la gestión de facturas electrónicas [Facturae](http://www.facturae.gob.es)

## wsdlFACe
Clase para el [Web Service de FACe](https://face.gob.es/es)

[Documentación wsdlFACe](docs/wsdlFACe.md)

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

[Ver documentación wsdlFACe](docs/wsdlFACe.md)
