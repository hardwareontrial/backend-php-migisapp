<?php

namespace App\Models\API\DeliveryNote;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\API\DeliveryNote\AppSuratJalan;

class AppSuratJalanDetail extends Model
{
  use HasFactory;

  protected $table = 'app_suratjalan_details';
  protected $fillable = [
    'deliveryno_id',
    'detail_customer',
    'detail_address',
    'detail_city',
    'detail_nopol',
    'detail_driver',
    'detail_item',
    'detail_qty',
    'detail_uom',
    'detail_sending_date',
  ];

  protected $primaryKey = 'deliveryno_id';
  public $incrementing = false;
  
  public function delivery()
  {
    return $this->belongsTo(AppSuratJalan::class, 'delivery_no', 'deliveryno_id');
  }
}
