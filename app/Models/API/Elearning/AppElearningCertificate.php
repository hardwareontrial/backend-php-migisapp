<?php

namespace App\Models\API\Elearning;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AppElearningCertificate extends Model
{
    use HasFactory;

    protected $table = 'app_elearning_certificates';
    protected $fillable = [
        'schedule_id',
        'signer_name',
        'signer_position',
        'folder_name',
    ];
}
