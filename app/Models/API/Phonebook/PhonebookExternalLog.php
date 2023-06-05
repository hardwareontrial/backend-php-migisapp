<?php

namespace App\Models\API\Phonebook;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PhonebookExternalLog extends Model
{
  use HasFactory;
  protected $table = 'app_phonebook_logs';
  protected $fillable = [
    'phonebook_id',
    'phonebook_type',
    'activity',
    'user_id'
  ];
}
