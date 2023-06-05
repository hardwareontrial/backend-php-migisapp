<?php

namespace App\Models\API\DeliveryNote;

use App\Models\API\DeliveryNote\AppSuratJalanDetail;
use App\Models\API\User\AppUser;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AppSuratJalan extends Model
{
  use HasFactory;

  protected $table = 'app_suratjalans';
  protected $fillable = [
    'delivery_no',
    'do_no',
    'po_no',
    'created_by',
    'is_processing',
    'is_remark',
    'invoice_no',
    'print_count',
  ];

  protected $primaryKey = 'delivery_no';
  public $incrementing = false;

  public function detail()
  {
    return $this->hasOne(AppSuratJalanDetail::class, 'deliveryno_id', 'delivery_no');
  }

  public function creator()
  {
    return $this->hasOne(AppUser::class, 'id', 'created_by');
  }

  public function logs()
  {
    return $this->hasMany(AppSuratJalanLog::class, 'deliveryno_id', 'delivery_no');
  }
}
