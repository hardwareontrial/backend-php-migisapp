<?php

namespace App\Models\API\Hr;

use App\Models\API\User\AppUser;
use App\Models\API\Hr\AppDepartmens;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AppPositions extends Model
{
  use HasFactory;
  protected $table = 'app_hr_positions';
  protected $fillable = [
    'parent_id',
    'name',
    'dept_id',
    'sub_dept_id',
    'level',
    'user_id',
    'isactive',
  ];

  public function children()
  {
    return $this->hasMany(self::class, 'parent_id')->with('children', 'children.user');
  }

  public function deptname()
  {
    return $this->hasOne(AppDepartmens::class, 'id', 'dept_id');
  }

  public function parent()
  {
    return $this->belongsTo(self::class, 'parent_id', 'id')->with('parent', 'parent.user');
  }

  public function user()
  {
    return $this->hasMany(AppUser::class, 'position_id', 'id');
  }
}
