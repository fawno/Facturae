<?php
/*
  Copyright 2018, Fawno (https://github.com/fawno)

  Licensed under The MIT License
  Redistributions of files must retain the above copyright notice.

  @copyright Copyright 2018, Fawno (https://github.com/fawno)
  @license MIT License (http://www.opensource.org/licenses/mit-license.php)
*/
  declare(strict_types=1);

  namespace Fawno\Facturae\Error;

  use Fawno\Facturae\Error\FacturaeError;
  use LibXMLError;

  class SchemaError extends FacturaeError {
    protected LibXMLError $error;

    public function __construct (LibXMLError $error) {
      $this->error = $error;
      parent::__construct($error->message, self::SCHEMA | $error->code);
    }

    public function getLevel () : int {
      return $this->error->level;
    }

    public function getColumn () : int {
      return $this->error->column;
    }

    public function getXMLFile () : string {
      return $this->error->file;
    }

    public function getXMLLine () : int {
      return $this->error->line;
    }
  }
