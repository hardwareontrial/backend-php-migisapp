<?php

namespace App\Http\Controllers\API\User;

use App\Http\Controllers\Controller;
use App\Models\API\Auth\AppUserLogin;
use App\Models\API\User\AppUser;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class AppUserController extends Controller
{
  public function index()
  {
    $cari = request()->q;
    $initial = request()->initialpage;

    $data = AppUser::where(function ($query) use ($cari, $initial){ $query
      ->where(function ($query2) use ($cari){ $query2
        ->where('name', 'LIKE', '%'.$cari.'%')
        ->orWhere('nik', 'LIKE', '%'.$cari.'%')
        ->orWhereHas('datalogin', function ($query3) use ($cari){ $query3
          ->where('email', 'LIKE', '%'.$cari.'%');
        })
        ->orWhereHas('position', function ($query4) use ($cari){
          $query4->where('name', 'LIKE', '%'.$cari.'%');
        })
        ->orWhereHas('position.deptname', function ($query5) use ($cari){
          $query5->where('name', 'LIKE', '%'.$cari.'%');
        });
      })
      ->when($initial == 'raport', function($query6){ $query6
        ->where('nik', '>', '1000000')->where('nik', '<', '6000000');
      });
    })
    ->with('datalogin', 'position.deptname')
    ->orderBy(request()->sortby, request()->sortbydesc)
    ->paginate(request()->per_page);

    return response()->json(['message' => $data], 200);
  }

  public function store(Request $request)
  {
    $shortnik = substr($request->input('nik'), -3);
    $filter = $request->input('statusUser');
    $isadmin = $filter == 'Admin' ? 1 : 0;
    $permission = $filter == 'Admin' ? ['manage.all'] : ["read.Auth", "read.ACL"];

    $user = AppUser::create([
      'nik' => $request->input('nik'),
      'name' => strtoupper($request->input('name')),
      'active' => $request->input('userActive')
    ]);

    $login = AppUserLogin::create([
      's_nik' => $shortnik,
      'nik' => $request->input('nik'),
      'email' => $request->input('email'),
      'password' => Hash::make($request->input('password')),
      'active' => $request->input('loginActive'),
      'admin' => $isadmin
    ]);
    
    if(!$user && !$login){ return response()->json(['message' => 'Data gagal disimpan'], 500); }
    $givepermissionuser = AppUserLogin::where('nik', $request->input('nik'))->first();
    $givepermissionuser->syncPermissions($permission);
    return response()->json(['message' => 'Data berhasil disimpan'], 200);
  }

  public function detail($nik)
  {
    $nik = request()->nik;
    $data = AppUser::where('nik', $nik)
          ->with('datalogin.permissions', 'datalogin.roles')
          ->first();
    return response()->json([ 'message' => $data], 200);
  }

  public function update(Request $request, $id)
  {
    $keyword = request()->keyword;
    
    if($keyword == 'update-from-usermgmt'){
      $data = AppUser::find($id)->load('datalogin');
      // $datalogin = AppUserLogin::where('nik', $request->input('usernik'))->get()->first();
      if($request->hasFile('avatar')){
        $new_file = $request->file('avatar');
        $new_extension = $new_file->getClientOriginalExtension();
        $new_filename = str_replace(' ', '-',$data->name).'.'.$new_extension;
        $old_filename = $data->avatar;
        $storagepath = storage_path('app/public/app_user/avatar/');

        /** remove old one if exist */
        if($old_filename != null){
          $old_file = $storagepath.$old_filename;
          unlink($old_file);
        }

        /** store the new one */
        $new_file->move($storagepath, $new_filename);
        $data->update([ 'avatar' => $new_filename ]);
      }

      $data->update([
        'name' => strtoupper($request->input('name')),
        'position_id' => $request->input('position_id') !== 'null' ? $request->input('position_id') : null,
        'active' => $request->input('isactive'),
      ]);

      if($data->datalogin != null){
        if($request->input('isactive') == 0){ $data->datalogin()->update([ 'active' => 0 ]); }
      }

      return response(['message' => 'Data berhasi diperbarui.'], 200);
    }else{
      return response(['message' => 'Not Found'], 404);
    }
  }

  public function delete($id)
  {
    //
  }

  public function providenik()
  {
    $baseadmin = '9000';
    if(AppUser::where('nik', 'LIKE', $baseadmin.'%')->count() > 0){
      $last = AppUser::where('nik', 'LIKE', $baseadmin.'%')->orderBy('id', 'desc')->first();
      $count = substr($last->nik, 2) +1;
      $nikadmin = $baseadmin.$count;
    }else{
      $nikadmin = $baseadmin.'901';
    }

    $baseext = '8000';
    if(AppUser::where('nik', 'LIKE', $baseext.'%')->count() > 0){
      $last = AppUser::where('nik', 'LIKE', $baseext.'%')->orderBy('id', 'desc')->first();
      $count = substr($last->nik, 2) +1;
      $nikext = $baseext.$count;
    }else{
      $nikext = $baseext.'901';
    }
    return response(['num_admin' => $nikadmin, 'num_external' => $nikext], 200);
  }

  public function changeactive(Request $request, $id)
  {
    $data1 = AppUser::findOrFail($id);
    $data1->active = $request->input('newvalue');
    $data1->save();

    if($data1->datalogin != null){
      if($request->input('newvalue') == 0){ $data1->datalogin()->update([ 'active' => 0 ]); }
    }
    
    return response()->json(['message' => 'Data berhasil diupdate.'], 200);
  }
}
