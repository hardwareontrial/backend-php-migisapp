<?php

namespace App\Models\API\Elearning;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AppElearningQuestion extends Model
{
  use HasFactory;
  protected $table = 'app_elearning_questions';
  protected $fillable = [
    'material_id',
    'title',
    'nilai_min',
    'duration',
    'created_by',
    'level',
    'isactive',
    'slug',
  ];

  protected $appends = [
    'questionscount'
  ];

  public function material()
  {
    return $this->belongsTo(AppElearningMaterial::class, 'material_id', 'id');
  }

  public function questions()
  {
    return $this->hasMany(AppElearningQuestionCollection::class, 'questions_id', 'id');
  }

  public function getQuestionscountAttribute()
  {
    $x = AppElearningQuestionCollection::where('questions_id', $this->attributes['id'])->get();
    return count($x);
  }

  public function scheduled()
  {
    return $this->hasMany(AppElearningSchedule::class, 'question_id', 'id');
  }
}
