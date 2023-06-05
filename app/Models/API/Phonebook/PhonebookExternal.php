<?php

namespace App\Models\API\Phonebook;

use App\Models\API\User\AppUser;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PhonebookExternal extends Model
{
  use HasFactory;

  protected $table = 'app_phonebooks';
  protected $fillable = [
    'type',
    'name',
    'address',
    'city',
    'company_name',
    'company_address',
    'company_city',
    'email',
    'note',
    'created_by',
  ];

  public function detail()
  {
    return $this->hasMany(PhonebookExternalDetail::class, 'phonebook_id', 'id');
  }

  public function logs()
  {
    return $this->hasMany(PhonebookExternalLog::class, 'phonebook_id', 'id');
  }

  public function creator()
  {
    return $this->hasOne(AppUser::class, 'id', 'created_by');
  }
}
