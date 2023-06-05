<?php

namespace App\Http\Controllers\API\Hr;

use App\Http\Controllers\Controller;
use App\Models\API\Hr\AppPositions;
use App\Models\API\User\AppUser;
use Illuminate\Http\Request;

class AppPositionController extends Controller
{
  public function index()
  {
    $cari = request()->q;
    $data = AppPositions::with('user', 'deptname')
    ->where(function ($query) use ($cari){ $query
      ->whereHas('user', function($query2) use ($cari){ $query2
        ->where('name', 'LIKE', '%'.$cari.'%');
      })
      ->orWhereHas('deptname', function ($query) use ($cari){ $query
        ->where('name', 'LIKE', '%'.$cari.'%');
      })
      ->orWhere(function ($query) use ($cari){ $query
        ->whereNotIn('id', [1])
        ->where('name', 'LIKE', '%'.$cari.'%');
      });
    })
    ->orderBy(request()->sortby, request()->sortbydesc)
    ->paginate((request()->per_page));

    return response()->json(['message' => $data], 200);
  }

  public function store(Request $request)
  {
    //
  }

  public function detail($id)
  {
    //
  }

  public function update(Request $request, $id)
  {
    $keyword = request()->keyword;
    if($keyword == 'update-from-position-list'){
      // $posid = $request->input('positionid');
      $posid = $id;
      $requsersid =  $request->input('usersid');
      $currusersid = AppUser::where('position_id', $posid)->get()->pluck('id')->toArray();
      $to_set = array_diff($requsersid, $currusersid);
      $to_nulled = array_diff($currusersid, $requsersid);
      
      if(count($to_set) > 0 && count($to_nulled) > 0){
        foreach($to_set as $set){
          $setuser = AppUser::find($set);
          $setuser->position_id = $posid;
          $setuser->save();
        }

        foreach($to_nulled as $nulled){
          $nulleduser = AppUser::find($nulled);
          $nulleduser->position_id = null;
          $nulleduser->save();
        }
      }

      if(count($to_set) <= 0 && count($to_nulled) > 0){
        foreach($to_nulled as $nulled){
          $nulleduser = AppUser::find($nulled);
          $nulleduser->position_id = null;
          $nulleduser->save();
        }
      }

      if(count($to_set) > 0 && count($to_nulled) <= 0){
        foreach($to_set as $set){
          $setuser = AppUser::find($set);
          $setuser->position_id = $posid;
          $setuser->save();
        }
      }
    }else{
      return response(['message' => 'Tidak ditemukan'], 404);
    }
  }

  public function delete($id)
  {
    //
  }
}
