<?php

namespace App\Models\API\Elearning;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AppElearningQuestionCollection extends Model
{
  use HasFactory;
  protected $table = 'app_elearning_question_collections';
  protected $fillable = [
    'questions_id',
    'question',
    'answer_options',
    'answer_key',
    // 'sourcefile',
  ];
  protected $casts = [
    'question' => 'array',
    'answer_options' => 'array',
  ];
  public $timestamps = false;
}
