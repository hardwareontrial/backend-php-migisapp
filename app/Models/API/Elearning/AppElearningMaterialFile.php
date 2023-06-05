<?php

namespace App\Models\API\Elearning;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AppElearningMaterialFile extends Model
{
  use HasFactory;
  protected $table = 'app_elearning_material_files';
  protected $fillable = [
    'm_id',
    'm_file',
    'view_count',
    'download_count'
  ];

  protected $appends = [
    'filematerial'
  ];

  public function material()
  {
    // return $this->belongsTo(AppElearningMaterial::class, 'id', 'm_id');
    return $this->belongsTo(AppElearningMaterial::class, 'id', 'm_id');
  }

  public function getFilematerialAttribute()
  {
    // return url('storage/app_elearning/material').'/m-'.$this->attributes['m_id'].'/'.$this->attributes['m_file'];
    return 'data:application/pdf;base64,'.$this->attributes['m_file'];
  }
}
