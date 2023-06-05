<?php

namespace App\Models\API\Auth;

use App\Models\API\User\AppUser;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Laravel\Sanctum\Sanctum;
use Spatie\Permission\Traits\HasRoles;

class AppUserLogin extends Authenticatable
{
  use HasFactory, HasApiTokens, Notifiable, HasRoles;

  protected $table = 'app_user_logins';
  protected $fillable = [
    'nik',
    's_nik',
    'email',
    'password',
    'active',
    'admin',
  ];
  protected $hidden = [
    'password'
  ];

  protected $primaryKey = 'nik';

  public function hasToken()
  {
    return $this->hasMany(AppUserToken::class, 'app_userlogin_nik', 'nik');
  }

  public function tokens()
  {
    return $this->morphMany(Sanctum::$personalAccessTokenModel, 'tokenable', 'tokenable_type', 'tokenable_nik', 'nik');
  }

  public function detailuser()
  {
    return $this->belongsTo(AppUser::class, 'nik', 'nik');
  }
}