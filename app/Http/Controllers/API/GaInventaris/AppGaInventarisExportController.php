<?php

namespace App\Http\Controllers\API\GaInventaris;

use App\Http\Controllers\Controller;
use App\Models\API\GaInventaris\AppGaInventaris;
use App\Models\API\User\AppUser;
use Illuminate\Http\Request;

class AppGaInventarisExportController extends Controller
{
  public function exportbylocation()
  {
    return AppGainventaris::where('lokasi_id', request()->id)
      ->with('locname', 'deptusername', 'user1name', 'user2name', 'merkname')
      ->get();
  }

  public function exportbyuser()
  {
    $data = AppGaInventaris::where('user1_id', request()->id)
      ->orWhere('user2_id', request()->id)
      ->with('locname', 'deptusername', 'user1name', 'user2name', 'merkname')
      ->get();
    $datauser = AppUser::where('id', request()->id)->first();
    return response(['message' => $data, 'message2' => $datauser], 200);
  }
}
