<?php

namespace App\Models\API\GaInventaris;

use App\Models\API\User\AppUser;
use App\Models\API\GaInventaris\ListLocation;
use App\Models\API\GaInventaris\ListMerk;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AppGaInventarisLog extends Model
{
  use HasFactory;
  protected $table = 'app_gainventaris_logs';
  protected $fillable = [
    'gainventaris_id',
    'action',
    'n_status_id',
    'o_status_id',
    'n_lokasi_id',
    'o_lokasi_id',
    'n_user1_id',
    'o_user1_id',
    'n_user2_id',
    'o_user2_id',
    'n_dept_user',
    'o_dept_user',
    'n_nama_brg',
    'o_nama_brg',
    'n_tgl_beli',
    'o_tgl_beli',
    'n_toko',
    'o_toko',
    'n_harga',
    'o_harga',
    'n_serialnumber',
    'o_serialnumber',
    'n_merk_id',
    'o_merk_id',
    'n_spesifikasi',
    'o_spesifikasi',
    'n_mtc_note',
    'o_mtc_note',
    'n_active',
    'o_active',
    'created_by',
  ];

  public function creator()
  {
    return $this->hasOne(AppUser::class, 'id', 'created_by');
  }

  public function user1namenew()
  {
    return $this->hasOne(AppUser::class, 'id', 'n_user1_id');
  }

  public function user1nameold()
  {
    return $this->hasOne(AppUser::class, 'id', 'o_user1_id');
  }

  public function user2namenew()
  {
    return $this->hasOne(AppUser::class, 'id', 'n_user2_id');
  }

  public function user2nameold()
  {
    return $this->hasOne(AppUser::class, 'id', 'o_user2_id');
  }

  public function locnamenew()
  {
    return $this->hasOne(ListLocation::class, 'id', 'n_lokasi_id');
  }

  public function locnameold()
  {
    return $this->hasOne(ListLocation::class, 'id', 'o_lokasi_id');
  }

  public function merknamenew()
  {
    return $this->hasOne(ListMerk::class, 'id', 'n_merk_id');
  }

  public function merknameold()
  {
    return $this->hasOne(ListMerk::class, 'id', 'o_merk_id');
  }
}
