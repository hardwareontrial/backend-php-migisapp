<?php

namespace App\Http\Controllers\API\SimpleTodo;

use App\Http\Controllers\Controller;
use App\Models\API\SimpleTodo\AppSimpleTodo;
use Illuminate\Http\Request;

class AppSimpleTodoController extends Controller
{
  public function index()
  {
    $typeuser = auth('sanctum')->user()->admin;
    $iduser = auth('sanctum')->user()->detailuser->id;

    $filter = request()->filter;
    $tag = request()->tag;
    $search = request()->search;

    if($filter === 'important'){ 
      $important = 1;
      $completed = '';
      $deleted = '';
    }elseif($filter === 'completed'){
      $important = '';
      $completed = 1;
      $deleted = '';
    }
    elseif($filter === 'deleted'){ 
      $important = '';
      $completed = '';
      $deleted = 1;
    }
    else {
      $important = '';
      $completed = 0;
      $deleted = 0;
    }
    $data = AppSimpleTodo::where('isImportant', 'LIKE', '%'.$important.'%')
      ->where('isComplete', 'LIKE', '%'.$completed.'%')
      ->where('isDeleted', 'LIKE', '%'.$deleted.'%')
      ->where('tags', 'LIKE', '%'.$tag.'%')
      ->where(function($query) use ($search) { $query
        ->where('title', 'LIKE', '%'.$search.'%')
        ->orWhere('detail', 'LIKE', '%'.$search.'%')
        ->orWhereHas('requestorname', function($query) use ($search){ $query
          ->where('name', 'LIKE', '%'.$search.'%');
        })
        ->orWhereHas('assigneename', function($query) use ($search){ $query
          ->where('name', 'LIKE', '%'.$search.'%');
        });
      })
      ->with('requestorname', 'assigneename')
      ->orderBy('dueDate', 'ASC')
      ->get();
    return $data;
  }

  public function store(Request $request)
  {
    $store = AppSimpleTodo::create([
      'title' => $request->input('title'),
      'dueDate' => $request->input('duedate'),
      'detail'  => $request->input('detail'),
      'assignee_id' => $request->input('assignee'),
      'tags' => $request->input('tags'),
      'requestor_id' => $request->input('requestor'),
      'isComplete' => $request->input('isComplete'),
      'isImportant' => $request->input('isImportant'),
      'isDeleted' => $request->input('isDeleted'),
      'created_by' => auth('sanctum')->user()->detailuser->id
    ]);

    if(!$store){ return response()->json([ 'message' => 'Gagal Tersimpan.'], 500); }
    return response()->json([ 'message' => 'Berhasil Tersimpan.'], 200);
  }

  public function detail()
  {
    //
  }

  public function update(Request $request, $id)
  {
    $data = AppSimpleTodo::find($id);
    $data->update([
      'title' => $request->input('title'),
      'dueDate' => $request->input('duedate'),
      'detail'  => $request->input('detail'),
      'assignee_id' => $request->input('assignee'),
      'tags' => $request->input('tags'),
      'requestor_id' => $request->input('requestor'),
      'isComplete' => $request->input('isComplete'),
      'isImportant' => $request->input('isImportant'),
      'isDeleted' => $request->input('isDeleted'),
    ]);
    if(!$data){ return response()->json([ 'message' => 'Gagal Tersimpan.'], 500); }
    return response()->json([ 'message' => 'Berhasil Tersimpan.'], 200);
  }

  public function delete()
  {
    //
  }

  public function markcomplete(Request $request, $id)
  {
    $data = AppSimpleTodo::find($id);
    $data->update([
      'isComplete' => $request->input('newstatus'),
    ]);
    if(!$data){ return response()->json([ 'message' => 'Gagal Tersimpan.'], 500); }
    return response()->json([ 'message' => 'Berhasil Tersimpan.'], 200);
  }

  public function markdelete(Request $request, $id)
  {
    $data = AppSimpleTodo::find($id);
    $data->update([
      'isDeleted' => $request->input('newstatus'),
    ]);
    if(!$data){ return response()->json([ 'message' => 'Gagal Tersimpan.'], 500); }
    return response()->json([ 'message' => 'Berhasil Tersimpan.'], 200);
  }
}
