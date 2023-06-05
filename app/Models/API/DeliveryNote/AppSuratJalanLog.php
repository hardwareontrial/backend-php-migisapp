<?php

namespace App\Models\API\DeliveryNote;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AppSuratJalanLog extends Model
{
  use HasFactory;

  protected $table = 'app_suratjalan_logs';
  protected $fillable = [
      'deliveryno_id',
      'action_name',
      'created_by',
  ];

  public $timestamps = ["created_at"];
  const UPDATED_AT = null;
}
