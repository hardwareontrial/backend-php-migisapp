<?php

namespace App\Models\API\Hr;

use App\Models\API\User\AppUser;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AppAttendace extends Model
{
  use HasFactory;
  protected $table = 'app_hr_attendaces';
  protected $fillable = [
    'pin',
    'name',
    'scan_date'
  ];

  public $timestamps = [ 'created_at' ];
  const UPDATED_AT = null;

  public static function tanpaHarianLepas()
  {
    return AppAttendace::whereNotIn('pin', ['002', '003', '004', '005', '006', '007', '008', '009']);
  }

  public function user()
  {
    return $this->hasOne(AppUser::class, 'nik', 'pin');
  }
}
