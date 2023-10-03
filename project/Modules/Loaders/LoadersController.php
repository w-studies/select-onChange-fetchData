<?php

declare(strict_types=1);

namespace Modules\Loaders;

use Modules\Core\Controller;
use PDO;

class LoadersController extends Controller
{
  public function __construct()
  {
    parent::__construct();
  }

  public function index()
  {
    try {
      $query  = 'select * from suppliers';
      $result = $this->db->connection->query($query);
      jsonResponse($result->fetchAll(PDO::FETCH_OBJ));
    } catch(\PDOException $e) {
      jsonResponse($e->getMessage(), 500);
    }
  }

  public function loadSecond(string $id = null)
  {
    try {
      $query = "select * from categories where fk_supplier='{$id}'";
      $stmt  = $this->db->connection->prepare($query);
      $stmt->execute();
      jsonResponse($stmt->fetchAll(PDO::FETCH_OBJ));
    } catch(\PDOException $e) {
      jsonResponse($e->getMessage(), 500);
    }
  }

  public function loadThird(string $id = null)
  {
    try {
      $query = "select * from authors where fk_category='{$id}'";
      $stmt  = $this->db->connection->prepare($query);
      $stmt->execute();
      jsonResponse($stmt->fetchAll(PDO::FETCH_OBJ));
    } catch(\PDOException $e) {
      jsonResponse($e->getMessage(), 500);
    }
  }
}
