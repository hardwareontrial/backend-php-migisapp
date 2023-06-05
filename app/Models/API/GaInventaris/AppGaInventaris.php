<?php

namespace App\Models\API\GaInventaris;

use App\Models\API\Hr\AppDepartmens;
use App\Models\API\User\AppUser;
use App\Models\API\GaInventaris\AppGaInventarisLog;
use App\Models\API\GaInventaris\ListLocation;
use App\Models\API\GaInventaris\ListMerk;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AppGaInventaris extends Model
{
  use HasFactory;
  use SoftDeletes;

  protected $table = 'app_gainventaris';
  protected $fillable = [
    'kd_brg',
    'nama_brg',
    'tgl_beli',
    'harga',
    'toko',
    'spesifikasi',
    'serialnumber',
    'pemilik_id',
    'merk_id',
    'status_id',
    'lokasi_id',
    'user1_id',
    'user2_id',
    'dept_user',
    'mtc_note',
    'qrcode',
    'active',
  ];

  protected $appends = [
    'qrlink'
  ];

  public function locname()
  {
    return $this->hasOne(ListLocation::class, 'id', 'lokasi_id');
  }

  public function merkname()
  {
    return $this->hasOne(ListMerk::class, 'id', 'merk_id');
  }

  public function logs()
  {
    return $this->hasMany(AppGaInventarisLog::class, 'gainventaris_id', 'id');
  }

  public function pemilikname()
  {
    return $this->hasOne(AppDepartmens::class, 'id', 'pemilik_id');
  }

  public function deptusername()
  {
    return $this->hasOne(AppDepartmens::class, 'id', 'dept_user');
  }

  public function user1name()
  {
    return $this->hasOne(AppUser::class, 'id', 'user1_id');
  }

  public function user2name()
  {
    return $this->hasOne(AppUser::class, 'id', 'user2_id');
  }

  public function getQrlinkAttribute()
  {
    return url('storage/app_inventaris/qrcode').'/'.$this->attributes['qrcode'];
  }

  public function userassign()
  {
    return $this->belongsToMany(AppUser::class, 'app_gainventaris_app_user');
  }
}
