<?php

namespace App\Models\API\User;

use App\Models\API\Auth\AppUserLogin;
use App\Models\API\Hr\AppPositions;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AppUser extends Model
{
  use HasFactory;

  protected $table = 'app_users';
  protected $fillable = [
    'nik',
    'name',
    'dept_id',
    'position_id',
    'avatar',
    'active',
  ];

  protected $appends = [
    'avatarlink'
  ];

  public function datalogin()
  {
    return $this->hasOne(AppUserLogin::class, 'nik', 'nik');
  }

  public function getAvatarlinkAttribute()
  {
    return url('storage/app_user/avatar').'/'.$this->attributes['avatar'];
  }

  public function position()
  {
    return $this->hasOne(AppPositions::class, 'id', 'position_id');
  }
}
