<?php

namespace App\Http\Controllers\API\Hr;

use App\Http\Controllers\Controller;
use App\Models\API\Hr\AppDepartmens;
use App\Models\API\Hr\AppPositions;
use Illuminate\Http\Request;

class AppDepartmenController extends Controller
{
  public function index()
  {
    $cari = request()->q;
    $data = AppDepartmens::orderBy(request()->sortby, request()->sortbydesc)
      ->with('positions')
      ->whereHas('positions', function ($query) use ($cari){
        $query->where('name', 'LIKE', '%'.$cari.'%');
      })
      ->orWhere(function ($query) use ($cari){
        $query->where('name', 'LIKE', '%'.$cari.'%');
      })
      ->paginate(request()->per_page);
    return response()->json(['message' => $data], 200);
  }

  public function store(Request $request)
  {
    $arrpos = count($request->input('idpos'));
    $data = AppDepartmens::create([
      'name' => $request->input('deptname'),
      'isactive' => '1',
    ]);
    if($arrpos > 0){
      $data = $data->fresh();
      $idpos = $request->input('idpos');
      foreach ($idpos as $idpv){
        $pos = AppPositions::find($idpv);
        $pos->update([ 'dept_id' => $data->id ]);
      }
      return response(['message' => 'Data berhasil ditambah'], 201);
    }
    return response(['message' => 'Data berhasil ditambah'], 201);
  }

  public function detail($id)
  {
    //
  }

  public function update(Request $request, $id)
  {
    $keyword = request()->keyword;
    if($keyword == 'update-from-dept-list'){
      // $deptid = $request->input('deptid');
      $deptid = $id;
      $reqposid =  $request->input('posid');
      $currposid = AppPositions::where('dept_id', $deptid)->get()->pluck('id')->toArray();
      $to_set = array_diff($reqposid, $currposid);
      $to_nulled = array_diff($currposid, $reqposid);
      
      if(count($to_set) > 0 && count($to_nulled) > 0){
        foreach($to_set as $set){
          $setdept = AppPositions::find($set);
          $setdept->dept_id = $deptid;
          $setdept->save();
        }
        foreach($to_nulled as $nulled){
          $nulleddept = AppPositions::find($nulled);
          $nulleddept->dept_id = null;
          $nulleddept->save();
        }
        if($setdept && $nulleddept){ return response(['message' => 'Data berhasil dirubah.'], 200); }
      }

      if(count($to_set) <= 0 && count($to_nulled) > 0){
        foreach($to_nulled as $nulled){
          $nulleddept = AppPositions::find($nulled);
          $nulleddept->dept_id = null;
          $nulleddept->save();
        }
        if($nulleddept){ return response(['message' => 'Data berhasil dirubah.'], 200); }
      }

      if(count($to_set) > 0 && count($to_nulled) <= 0){
        foreach($to_set as $set){
          $setdept = AppPositions::find($set);
          $setdept->dept_id = $deptid;
          $setdept->save();
        }
        if($setdept){ return response(['message' => 'Data berhasil dirubah.'], 200); }
      }
    }else if('update-active-from-dept-list'){
      $data = AppDepartmens::find($id);
      $data->isactive = $request->input('newactive');
      $data->save();
      return response(['message' => 'Data berhasil dirubah.'], 200);
    }else{
      return response(['message' => 'Tidak ditemukan.'], 404);
    }
  }

  public function delete($id)
  {
    //
  }
}
