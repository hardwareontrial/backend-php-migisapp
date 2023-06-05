<?php

namespace App\Http\Controllers\API\Misc;

use App\Http\Controllers\Controller;
use App\Models\API\Auth\AppUserLogin;
use App\Models\API\GaInventaris\AppGaInventaris;
use App\Models\API\GaInventaris\ListLocation;
use App\Models\API\GaInventaris\ListMerk;
use App\Models\API\Hr\AppDepartmens;
use App\Models\API\Hr\AppPositions;
use App\Models\API\User\AppUser;
use Illuminate\Http\Request;

class ListController extends Controller
{
  public function userWithoutLogin()
  {
    return AppUser::doesnthave('datalogin')->get();
  }

  public function userlist()
  {
    return AppUser::whereNotBetween('nik', [8000000, 9999999])->with('datalogin', 'position')->get();
  }

  public function departments()
  {
    return AppDepartmens::where('isactive', '1')->get();
  }

  public function positions()
  {
    return AppPositions::where('isactive', '1')->get();
  }

  public function listmerk()
  {
    return ListMerk::all();
  }

  public function listlocation()
  {
    return ListLocation::all();
  }

  public function gainventaris()
  {
    return AppGaInventaris::with('locname', 'merkname', 'user1name', 'user2name', 'user1name.position.deptname', 'user2name.position.deptname')->get();
  }
}
