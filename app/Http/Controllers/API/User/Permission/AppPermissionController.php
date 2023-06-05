<?php

namespace App\Http\Controllers\API\User\Permission;

use App\Http\Controllers\Controller;
use App\Models\API\Auth\AppUserLogin;
use Illuminate\Http\Request;
use Spatie\Permission\Models\Permission;

class AppPermissionController extends Controller
{
  public function index()
  {
    if(request()->f == 'table-list-permission'){
      $cari = request()->q;
      $data = Permission::orderBy(request()->sortby, request()->sortbydesc)
                        ->where(function ($query) use ($cari){
                          $query->where('text', 'LIKE', '%'.$cari.'%');
                        })
                        ->paginate(request()->per_page);
      return response()->json(['message' => $data], 200);
    }
    if(request()->f == 'form-list-permission'){
      // $data = Permission::all();
      // return response()->json(['message' => $data], 200);
      $p = Permission::all();
      $result = array();
      foreach ($p as $pres){
        $result[$pres['group_name']][] = $pres;
      }
      return response()->json(['message' => $result], 200);
    }
  }

  public function store()
  {
    //
  }

  public function detail()
  {
    //
  }

  public function update(Request $request, $nik)
  {
    $keyword = request()->keyword;

    /** update user-permission */
    if($keyword == 'update-user-permission'){
      $user = AppUserLogin::where('nik', $nik)->first();
      $permissions = $request->input('selectedPermission');
      $user->syncPermissions($permissions);
      return response()->json(['message' => 'Data berhasil diperbarui']);
    }

  }

  public function delete()
  {
    //
  }
}
