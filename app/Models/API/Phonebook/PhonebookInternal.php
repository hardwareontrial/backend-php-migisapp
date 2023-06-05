<?php

namespace App\Models\API\Phonebook;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PhonebookInternal extends Model
{
  use HasFactory;
  protected $table = 'app_phonebook_extensions';
  protected $fillable = [
    'user_id',
    'ext',
    'lokasi_id'
  ];

  /**
   * Get the user associated with the AppPhonebookExtension
   *
   * @return \Illuminate\Database\Eloquent\Relations\HasOne
   */
  public function user()
  {
    return $this->hasOne(AppUser::class, 'id', 'user_id');
  }
}
