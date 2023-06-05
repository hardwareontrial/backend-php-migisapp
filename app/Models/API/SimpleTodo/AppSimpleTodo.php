<?php

namespace App\Models\API\SimpleTodo;

use App\Models\API\User\AppUser;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AppSimpleTodo extends Model
{
  use HasFactory;

  protected $table = 'app_simple_todos';
  protected $fillable = [
    'title',
    'dueDate',
    'detail',
    'assignee_id',
    'tags',
    'requestor_id',
    'isComplete',
    'isImportant',
    'isDeleted',
    'created_by'
  ];

  protected $casts = [
    'tags' => 'array'
  ];

  public function requestorname()
  {
    return $this->hasOne(AppUser::class, 'id', 'requestor_id');
  }

  public function assigneename()
  {
    return $this->hasOne(AppUser::class, 'id', 'assignee_id');
  }

  public function creatorname()
  {
    return $this->hasOne(AppUser::class, 'id', 'created_by');
  }
}
