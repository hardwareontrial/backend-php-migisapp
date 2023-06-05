<?php

namespace App\Models\API\Elearning;

use App\Models\API\User\AppUser;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AppElearningSchedule extends Model
{
  use HasFactory;
  protected $table = "app_elearning_schedules";
  protected $fillable = [
    'title',
    'nilai_min',
    'duration',
    'question_id',
    'type',
    'startdate_exam',
    'enddate_exam',
    'note',
    'participant_id',
    'questions_count',
    'created_by',
    'isactive',
    'certificate_id',
  ];
  protected $casts = [
    'participant_id' => 'array',
  ];

  protected $appends = [
    'participantscount'
  ];

  public function dataquestion()
  {
    return $this->hasOne(AppElearningQuestion::class, 'id', 'question_id');
  }

  public function participants_exam()
  {
    return $this->hasMany(AppElearningUserdataExam::class, 'schedule_id', 'id');
  }

  public function getParticipantscountAttribute()
  {
    $x = AppElearningUserdataExam::where('schedule_id', $this->attributes['id'])->get();
    return count($x);
  }

  public function creator()
  {
    return $this->hasOne(AppUser::class, 'id', 'created_by');
  }

  public function certificate_data(){
    return $this->hasOne(AppElearningCertificate::class, 'schedule_id', 'id');
  }
}
