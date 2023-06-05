<?php

namespace App\Models\API\Elearning;

use App\Models\API\Hr\AppDepartmens;
use App\Models\API\HRIS\AppHrisDepartment;
use App\Models\API\User\AppUser;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AppElearningMaterial extends Model
{
  use HasFactory;
  protected $table = 'app_elearning_materials';
  protected $fillable = [
    'm_title',
    'dept_id',
    'm_level',
    'm_duration',
    'm_desc',
    'slug',
    'created_by',
    'isactive'
  ];

  public function materialfile()
  {
    // return $this->hasOne(AppElearningMaterialFile::class, 'm_id', 'id');
    return $this->hasOne(AppElearningMaterialFile::class, 'm_id', 'id');
  }

  public function deptname()
  {
    // return $this->hasOne(AppHrisDepartment::class, 'id', 'dept_id');
    return $this->hasOne(AppDepartmens::class, 'id', 'dept_id');
  }

  public function creator()
  {
    // return $this->hasOne(AppUser::class, 'id', 'created_by');
    return $this->hasOne(AppUser::class, 'id', 'created_by');
  }

  public function questionslist()
  {
    // return $this->hasMany(AppElearningQuestion::class, 'material_id', 'id');
    return $this->hasMany(AppElearningQuestion::class, 'material_id', 'id');
  }
}
