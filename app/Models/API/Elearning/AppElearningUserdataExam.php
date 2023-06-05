<?php

namespace App\Models\API\Elearning;

use App\Models\API\User\AppUser;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AppElearningUserdataExam extends Model
{
  use HasFactory;
  protected $table = 'app_elearning_userdata_exams';
  protected $fillable = [
    'schedule_id',
    'user_nik',
    'questions_pattern',
    'answers_user',
    'user_start_exam',
    'user_end_exam',
    'timeleft_seconds',
    'isdone',
    'ispassed',
    'score',
    'certificate',
  ];

  protected $casts = [
    'questions_pattern' => 'array',
    'answers_user' => 'array',
  ];

  protected $appends = [
    'certificatelink'
  ];

  public function schedule()
  {
    // return $this->hasOne(AppElearningSchedule::class, 'schedule_id', 'id');
    return $this->hasOne(AppElearningSchedule::class, 'id', 'schedule_id');
  }

  public function datauser()
  {
    // return $this->hasOne(AppUser::class, 'nik', 'user_nik');
    return $this->hasOne(AppUser::class, 'nik', 'user_nik');
  }

  public function getCertificatelinkAttribute()
  {
    return url('storage/app_elearning/quiz').'/'.$this->attributes['certificate'];
  }

}
