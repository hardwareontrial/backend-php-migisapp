<?php

namespace App\Models\API\Auth;

use Laravel\Sanctum\PersonalAccessToken as BasePersonalAccessToken;

class AppUserToken extends BasePersonalAccessToken
{
  public function tokenable()
  {
    return $this->morphTo('tokenable', 'tokenable_type', 'tokenable_nik', 'nik');
  }
}
