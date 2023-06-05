<?php

namespace App\Http\Controllers\API\Elearning;

use App\Http\Controllers\Controller;
use App\Models\API\Elearning\AppElearningMaterial;
use App\Models\API\Elearning\AppElearningMaterialFile;
use App\Models\API\HRIS\AppHrisDepartment;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;

class ElearningMaterialController extends Controller
{
  public function storematerial(Request $request)
  {
    $tablename = app(AppElearningMaterial::class)->getTable();
    $db = DB::select("SHOW TABLE STATUS LIKE '".$tablename."'");
    $iddata = $db[0]->Auto_increment;

    $authuser = auth('sanctum')->user()->detailuser->id;
    $slug = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $request->input('title'))));

    if($request->hasFile('filematerial') && $request->file('filematerial')){
      $this->storefilematerial($iddata, $request->file('filematerial'));
    };

    AppElearningMaterial::create([
      'm_title' => strtoupper($request->input('title')),
      'dept_id' => $request->input('dept'),
      'm_level' => $request->input('level'),
      'm_duration' => $request->input('duration'),
      'm_desc' => $request->input('desc'),
      'slug' => $slug,
      'created_by' => $authuser,
      'isactive' => 1,
    ]);

    return response()->json(['message' => 'Data berhasil disimpan.']);
  }

  public function addfilematerial(Request $request)
  {
    $store = $this->storefilematerial($request->id, $request->file('filematerial'));
    if(!$store){
      return response()->json(['message' => 'File gagal disimpan.'], 500);
    }
    return response()->json(['message' => 'File berhasil disimpan.'], 200);
  }

  private function storefilematerial($dataid, $datafile)
  {
    $storedir = storage_path('app/public/app_elearning/material/').'m-'.$dataid;
    if(!File::exists($storedir)){
      File::makeDirectory($storedir, 0777, true);
    }

    // $filename = Carbon::now()->timestamp.'_'.$datafile->getClientOriginalName();
    // $datafile->move($storedir, $filename);

    $filename = chunk_split((base64_encode(file_get_contents($datafile))));

    $data = AppElearningMaterialFile::create([
      'm_id' => $dataid,
      'm_file' => $filename,
      'view_count' => 0,
      'download_count' => 0
    ]);

    return $data;
  }

  public function handleListDept()
  {
    // return AppHrisDepartment::all();
  }

  public function handleList()
  {
    return AppElearningMaterial::where('isactive', 1)->orderBy('id', 'desc')->with('deptname')->get();
  }

  public function materialall()
  {
    $cari = request()->q;
    $isactive = request()->isactive;

    $data = AppElearningMaterial::with('deptname', 'creator', 'questionslist.scheduled')
      ->where(function ($query) use ($cari, $isactive){
        $query->whereHas('deptname', function ($query2) use ($cari){
          $query2->where(function ($query3) use ($cari){
            $query3->where('name', 'LIKE', '%'.$cari.'%');
          })
          ->orWhere('m_title', 'LIKE', '%'.$cari.'%');
        })
        ->when($isactive == '1', function ($query4){
          $query4->where('isactive', 1);
        })
        ->when($isactive == '0', function ($query4){
          $query4->where('isactive', 0);
        });
      })
      ->orderBy(request()->sortby, request()->sortbydesc)
      ->paginate(request()->per_page);

    return response()->json(['message' => $data], 200);
  }

  public function detailmaterial($id)
  {
    return AppElearningMaterial::find($id)->load('materialfile', 'questionslist.scheduled');
  }

  public function updatematerial(Request $request, $id)
  {
    $slug = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $request->input('title'))));
    $data = AppElearningMaterial::find($id);
    $data->update([
      'm_title' => strtoupper($request->input('title')),
      'dept_id' => $request->input('dept'),
      'm_level' => $request->input('level'),
      'm_duration' => $request->input('duration'),
      'm_desc' => $request->input('desc'),
      'slug' => $slug,
      'isactive' => $request->input('isactive'),
    ]);
    if(!$data) {
      return response()->json(['message' => 'Data gagal diperbarui'], 500);
    }
    return response()->json([
      'message' => 'Data berhasil diperbarui',
      'slug' => $slug,
      'id' => $id,
    ], 200);
  }

  public function deletematerial($id)
  {
    $data = AppElearningMaterial::find($id)->load('materialfile', 'questionslist', 'questionslist.questions');
    if(count($data->questionslist) > 0){
      foreach($data->questionslist as $qstdata){
        File::deleteDirectory(storage_path('app/public/app_elearning/soal/').'s-'.$qstdata->id);
        $qstdata->questions()->delete();
      }
      $data->questionslist()->delete();
    }
    if($data->materialfile !== null){
      File::deleteDirectory(storage_path('app/public/app_elearning/material/').'m-'.$data->materialfile->m_id);
      $data->materialfile()->delete();
    }
    $data->delete();
    return response()->json(['message' => 'Data berhasil dihapus.'], 200);
  }

  public function deletefilematerial($id)
  {
    $data = AppElearningMaterial::find($id)->load('materialfile');
    unlink(storage_path('app/public/app_elearning/material/').'m-'.$data->materialfile->m_id.'/'.$data->materialfile->m_file);
    $data->materialfile()->delete();
    if(!$data){
      return response()->json(['message' => 'File gagal dihapus.'], 500);
    }
    return response()->json(['message' => 'File dihapus.'], 200);
  }
}
