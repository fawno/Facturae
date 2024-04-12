[![GitHub license](https://img.shields.io/github/license/fawno/Facturae.svg)](https://github.com/fawno/Facturae/blob/master/LICENSE)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/fawno/Facturae.svg)](https://github.com/fawno/Facturae/tags)
[![GitHub release](https://img.shields.io/github/release/fawno/Facturae.svg)](https://github.com/fawno/Facturae/releases)
[![Packagist](https://img.shields.io/packagist/v/fawno/facturae.svg)](https://packagist.org/packages/fawno/facturae)
[![Packagist Downloads](https://img.shields.io/packagist/dt/fawno/Facturae.svg)](https://packagist.org/packages/fawno/Facturae/stats)
[![GitHub issues](https://img.shields.io/github/issues/fawno/Facturae.svg)](https://github.com/fawno/Facturae/issues)
[![GitHub forks](https://img.shields.io/github/forks/fawno/Facturae.svg)](https://github.com/fawno/Facturae/network)
[![GitHub stars](https://img.shields.io/github/stars/fawno/Facturae.svg)](https://github.com/fawno/Facturae/stargazers)
[![Documentation](https://img.shields.io/badge/manual-wsdlFACe-blue.svg)](docs/wsdlFACe.md)

# Facturae
Clases para la gestión de facturas electrónicas [Facturae](http://www.facturae.gob.es)

## wsdlFACe
Clase para el [Web Service de FACe](https://face.gob.es/es)

[Documentación wsdlFACe](docs/wsdlFACe.md)

# Requisitos

- PHP version 7.4 o superior con las extensiones openssl y soap habilitadas.
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
