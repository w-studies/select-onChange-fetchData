<?php

declare(strict_types=1);

namespace Framework;

require 'helpers/httpResponse.php';

class App
{
  private Router $router;

  public function __construct()
  {
    $this->router = new Router();
  }

  public function run()
  {

    $path   = parse_url($_SERVER['PATH_INFO'], PHP_URL_PATH);
    $method = $_SERVER['REQUEST_METHOD'];

    $this->router->dispatch($path, $method);
  }

  public function get(string $path, array $controller): void
  {
    $this->router->add('GET', $path, $controller);
  }

  public function post(string $path, array $controller): void
  {
    $this->router->add('POST', $path, $controller);
  }
}
