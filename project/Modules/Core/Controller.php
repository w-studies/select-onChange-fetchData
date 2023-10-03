<?php

declare(strict_types=1);

namespace Modules\Core;

use Framework\Database;

class Controller
{
  protected $db;

  public function __construct()
  {
    $this->db = new Database(
      'mysql',
      [
        'host'   => DB_HOST,
        'port'   => DB_PORT,
        'dbname' => DB_NAME,
      ],
      DB_USER,
      DB_PASSWORD
    );
  }
}
