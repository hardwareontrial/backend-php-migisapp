<?php

namespace App\Models\API\Hr;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AppKaryawanSource extends Model
{
  use HasFactory;
  protected $connection = 'mysql_absensi';
  protected $table = 'pegawai';
}
