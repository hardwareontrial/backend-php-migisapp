<?php

namespace App\Models\API\Hr;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AppDepartmens extends Model
{
  use HasFactory;

  protected $table = 'app_hr_departments';
  protected $fillable = [
    'name',
    'parent_id',
    'isactive',
  ];

  public function positions()
  {
    return $this->hasMany(AppPositions::class, 'dept_id', 'id');
  }

  /**
   * Temporary disabled caused backend reason.
   * 
   * public function subdept()
   * {
   * return $this->hasMany(AppHrisSubDepartment::class, 'dept_id', 'id');
   * }
   */
}
