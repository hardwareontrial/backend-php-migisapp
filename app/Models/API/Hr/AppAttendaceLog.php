<?php

namespace App\Models\API\Hr;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AppAttendaceLog extends Model
{
  use HasFactory;
  protected $table = 'app_hr_attendace_logs';
  protected $fillable = [
    'startdate',
    'enddate',
    'note',
  ];

  public $timestamps = [ "created_at" ];
  const UPDATED_AT = null;
}
