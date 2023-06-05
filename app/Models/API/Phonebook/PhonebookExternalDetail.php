<?php

namespace App\Models\API\Phonebook;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PhonebookExternalDetail extends Model
{
  use HasFactory;
  protected $table = 'app_phonebook_details';
  protected $fillable = [
      'phonebook_id',
      'number',
      'pic',
  ];

  public function master()
  {
    return $this->belongsTo(PhonebookExternal::class, 'id', 'phonebook_id');
  }
}
