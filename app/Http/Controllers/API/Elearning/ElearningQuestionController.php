<?php

namespace App\Http\Controllers\API\Elearning;

use App\Http\Controllers\Controller;
use App\Imports\API\AppElearning\QuestionImport;
use App\Jobs\API\Elearning\QuestionFromExcel;
use App\Models\API\Elearning\AppElearningQuestion;
use App\Models\API\Elearning\AppElearningQuestionCollection;
use App\Models\API\Elearning\AppElearningQuestionStatusUpload;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Facades\Excel;
use PhpOffice\PhpSpreadsheet\Cell\Coordinate;
use PhpOffice\PhpSpreadsheet\Reader\Xlsx;
use PhpOffice\PhpSpreadsheet\Worksheet\MemoryDrawing;
use Illuminate\Support\Facades\File;
use stdClass;

class ElearningQuestionController extends Controller
{
  public function dataquestion()
  {
    $cari = request()->q;
    $isactive = request()->isactive;

    $data = AppElearningQuestion::with('material', 'questions', 'scheduled')
      ->where(function ($query) use ($cari, $isactive){
        $query->whereHas('material', function ($query2) use ($cari){
          $query2->where(function ($query3) use ($cari){
            $query3->where('m_title', 'LIKE', '%'.$cari.'%');
          })
          ->orWhere('title', 'LIKE', '%'.$cari.'%');
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

  public function detailquestion($id)
  {
    return AppElearningQuestion::find($id)->load('material', 'questions', 'scheduled');
  }

  public function updatedetailquestion(Request $request, $id)
  {
    $data = AppElearningQuestion::find($id);
    $slug = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $request->input('exam_title'))));
    $data->update([
      // 'nilai_min' => $request->input('exam_point'),
      // 'duration' => $request->input('exam_duration'),
      'material_id' => $request->input('exam_material_id'),
      'title' => strtoupper($request->input('exam_title')),
      'slug' => $slug,
    ]);

    if(!$data){ return response()->json(['message' => 'Update gagal'], 500); }
    return response()->json(['message' => 'Update berhasil'], 200);
  }

  public function storequestion(Request $request)
  {
    $this->validate($request, [
      'exam_title' => 'required',
      'exam_material' => 'required',
      // 'exam_point' => 'required',
      // 'exam_duration' => 'required',
    ]);

    $tablename = app(AppElearningQuestion::class)->getTable();
    $db = DB::select("SHOW TABLE STATUS LIKE '".$tablename."'");
    $newid = $db[0]->Auto_increment;
    $slug = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $request->input('exam_title'))));
    
    $statusaddqst = AppElearningQuestionStatusUpload::create([
      'material_id' => $request->input('exam_material'),
      'question_id' => $newid,
      'status' => 1,
    ]);
    $statusid = $statusaddqst->id;

    if($request->hasFile('exam_add_upload')){
      $this->validate($request, [
        'exam_add_upload' => 'mimes:xlsx',
      ],[
        'exam_add_upload.mimes' => 'File harus bertipe xlsx.'
      ]);
      
      $materialid = $request->input('exam_material');
      /** File dipindah ke folder materi */
      $file = $request->file('exam_add_upload');
      $pathfile = storage_path('app/public/app_elearning/soal/').'s-'.$newid;
      if(!File::exists($pathfile)){
        File::makeDirectory($pathfile, 0777, true);
      }
      $filename = Carbon::now()->format('ymdHi').'.'.$file->getClientOriginalExtension();
      $file->move($pathfile, $filename);
      QuestionFromExcel::dispatch($filename, $materialid, $newid, $statusid);
      // $this->testreadfile($filename, $materialid, $newid, $statusid);
      AppElearningQuestion::create([
        'material_id' => $request->input('exam_material'),
        'title' => strtoupper($request->input('exam_title')),
        'nilai_min' => $request->input('exam_point'),
        'duration' => $request->input('exam_duration'),
        'created_by' => auth('sanctum')->user()->detailuser->id,
        'level' => $request->input('exam_level'),
        'isactive' => 1,
        'slug' => $slug,
      ]);
      return response()->json([
        'message' => 'Berhasil menambah data.',
        'id' => $newid,
        'slug' => $slug,
        'title' => strtoupper($request->input('exam_title')),
      ], 200);
    }else if(sizeof(json_decode($request->input('exam_add_manual'))) !== 0){
      $question_id = $newid;
      $question_collection_status = $this->store_exam_manual($question_id, json_decode($request->input('exam_add_manual')), $statusid);

      if(!$question_collection_status){
        return response()->json(['message' => 'Gagal menambah data.'], 500);
      }else{
        AppElearningQuestion::create([
          'material_id' => $request->input('exam_material'),
          'title' => strtoupper($request->input('exam_title')),
          'nilai_min' => $request->input('exam_point'),
          'duration' => $request->input('exam_duration'),
          'created_by' => auth('sanctum')->user()->detailuser->id,
          'level' => $request->input('exam_level'),
          'isactive' => 1,
          'slug' => $slug,
        ]);
        return response()->json([
          'message' => 'Berhasil menambah data.',
          'id' => $newid,
          'slug' => $slug,
          'title' => strtoupper($request->input('exam_title')),
        ], 200);
      }
    }
  }

  private function store_exam_manual($id, $questions, $statusaddid)
  {
    $update = AppElearningQuestionStatusUpload::find($statusaddid);
    $newquestions = array();
    foreach($questions as $vqst){
      $newansopt = array();
      foreach($vqst->answer_options as $iao => $vao){
        $vao->value = $iao +1;
        array_push($newansopt, $vao);
      }
      array_push($newquestions, $vqst);
    }
    foreach($questions as $question){
      $data = AppElearningQuestionCollection::create([
        'questions_id' => $id,
        'question' => $question->question,
        'answer_options' => $question->answer_options,
        'answer_key' => $question->answer_key,
        // 'sourcefile' => null,
      ]);
    }
    if(!$data){ $update->update([ 'status' => 3 ]); return false; }
    else{ $update->update([ 'status' => 2 ]); return true; }
  }

  public function deletequestion($id)
  {
    $data = AppElearningQuestion::find($id);
    $data->questions()->delete();
    $data->delete();
    if(!$data){
      return response()->json(['message' => 'Data gagal dihapus.'], 500);
    }
    return response()->json(['message' => 'Data berhasil dihapus.'], 200);
  }

  public function setactive(Request $request, $id)
  {
    $data = AppElearningQuestion::find($id);
    $data->update([ 'isactive' => $request->input('setactive') ]);
    return response()->json(['message' => 'Data berhasil diupdate.'], 200);
  }

  public function questionlist()
  {
    return AppElearningQuestion::where('isactive', 1)->orderBy('id', 'desc')->get();
  }


  /** Collection */
  public function detailQuestionCollection($id)
  {
    return AppElearningQuestionCollection::find($id);
  }

  public function updateQuestionCollection(Request $request, $id)
  {
    $ansopts = json_decode($request->input('answer_options'));
    $nqst = json_decode($request->input('question'));
    $nansopts = array();
    foreach($ansopts as $iao => $vao){
      $vao->value = $iao +1;
      array_push($nansopts, $vao);
    }

    $data =  AppElearningQuestionCollection::updateOrCreate(
      [
        'id' => $id,
        'questions_id' => $request->input('questions_id')
      ],
      [
        'question' => $nqst,
        'answer_options' => $nansopts,
        'answer_key' => $request->input('answer_key')
      ]
    );

    if(!$data){ return response()->json(['message' => 'Update gagal'], 500); }
    return response()->json(['message' => 'Update berhasil'], 200);
  }

  public function deleteQuestionCollection($id)
  {
    $data =  AppElearningQuestionCollection::find($id);
    $data->delete();

    if(!$data){ return response()->json(['message' => 'Data gagal dihapus'], 500); }
    return response()->json(['message' => 'Hapus data berhasil'], 200);
  }

  public function statusQuestionCollection($id)
  {
    return AppElearningQuestionStatusUpload::where('question_id', $id)->orderBy('id', 'desc')->first();
  }

  public function addQuesitionCollectionUploadFile(Request $request, $id)
  {
    // $this->validate($request, 
    //   ['exam_add_upload' => 'mimes:xlsx'],
    //   ['exam_add_upload.mimes' => 'File harus bertipe xlsx.']
    // );
    $materialid = $request->input('exam_material');
    $data = AppElearningQuestion::find($id);
    $newid = $data->id;
    $statusaddqst = AppElearningQuestionStatusUpload::create([
      'material_id' => $request->input('exam_material'),
      // 'question_id' => $newid,
      'question_id' => $id,
      'status' => 1,
    ]);
    $statusid = $statusaddqst->id;
    
    $file = $request->file('exam_add_upload');

    // $pathfile = storage_path('app/public/app_elearning/soal/').'s-'.$newid;
    $pathfile = storage_path('app/public/app_elearning/soal/').'s-'.$id;
    if(!File::exists($pathfile)){
      File::makeDirectory($pathfile, 0777, true);
    }
    $filename = Carbon::now()->format('ymdHi').'.'.$file->getClientOriginalExtension();
    $file->move($pathfile, $filename);
    // QuestionFromExcel::dispatch($filename, $materialid, $newid, $statusid);
    QuestionFromExcel::dispatch($filename, $materialid, $id, $statusid);
    return response()->json([
      'message' => 'Berhasil menambah data.',
      // 'id' => $newid,
      'id' => $id,
      'slug' => $data->slug,
      'title' => $data->title,
    ], 200);
  }
}
