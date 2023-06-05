<?php

namespace App\Models\API\GaInventaris;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AppGaInventarisSell extends Model
{
  use HasFactory;
  protected $table = 'app_gainventaris_sells';
  protected $fillable = [
    'ex_kd_brg',
    'nama_brg',
    'tgl_beli',
    'harga_beli',
    'toko',
    'spesifikasi',
    'serialnumber',
    'pemilik',
    'merk',
    'harga_jual',
    'history',
  ];
  protected $casts = [
    'history' => 'array'
  ];
}
