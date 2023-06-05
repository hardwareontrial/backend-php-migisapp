<?php

namespace App\Models\API\GaInventaris;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ListMerk extends Model
{
  use HasFactory;
  protected $table = 'app_general_listmerk';
  protected $fillable = [
    'name'
  ];
}
