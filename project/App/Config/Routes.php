<?php

declare(strict_types=1);

namespace App\Config;

use Framework\App;
use Modules\Loaders\LoadersController;

function registerRoutes(App $app)
{
  $app->get('/first', [LoadersController::class]);

  $app->get('/second/{id}', [LoadersController::class, 'loadSecond']);
  $app->get('/third/{id}', [LoadersController::class, 'loadThird']);
}
