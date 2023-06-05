<?php

namespace App\Models\API\Elearning;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AppElearningQuestionStatusUpload extends Model
{
  use HasFactory;
  protected $table = 'app_elearning_question_status_uploads';
  protected $fillable = [
    'material_id',
    'question_id',
    'question_collection_id',
    'status',
  ];

}
