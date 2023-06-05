<?php

namespace App\Models\API\GaInventaris;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ListLocation extends Model
{
  use HasFactory;
  protected $table = 'app_general_listlocation';
  protected $fillable = [
    'name'
  ];
}
