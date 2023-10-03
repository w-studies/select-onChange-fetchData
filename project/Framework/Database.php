<?php

declare(strict_types=1);

namespace Framework;

use PDO;
use PDOException;

class Database
{
  public PDO $connection;

  public function __construct(string $driver, array $config, string $user, string $password)
  {
    $config = http_build_query(data: $config, arg_separator: ';');

    $dns = "$driver:$config";

    try {
      $this->connection = new PDO($dns, $user, $password);
    } catch (PDOException $error) {
      exit('Database connection error: '.$error->getMessage());
      echo '<pre>$error: ';
      var_dump($error);
      echo '</pre>';
    }
  }
}
