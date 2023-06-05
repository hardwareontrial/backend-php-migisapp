<?php

namespace App\Http\Controllers\API\Phonebook;

use App\Http\Controllers\Controller;
use App\Models\API\Phonebook\PhonebookExternal;
use App\Models\API\Phonebook\PhonebookExternalDetail;
use App\Models\API\Phonebook\PhonebookExternalLog;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class PhonebookExternalController extends Controller
{
  public function index()
  {
    $cari = request()->q;
    $data = PhonebookExternal::orderBy(request()->sortby, request()->sortbydesc)
      ->whereHas('detail', function($query) use ($cari){
        $query->where(function ($query) use ($cari){
          $query->where('pic', 'LIKE', '%'.$cari.'%')
                ->orWhere('number', 'LIKE', '%'.$cari.'%');
        })
        ->orWhere('name', 'LIKE', '%'.$cari.'%')
        ->orWhere('address', 'LIKE', '%'.$cari.'%')
        ->orWhere('company_name', 'LIKE', '%'.$cari.'%')
        ->orWhere('company_address', 'LIKE', '%'.$cari.'%')
        ->orWhere('email', 'LIKE', '%'.$cari.'%')
        ->orWhere('note', 'LIKE', '%'.$cari.'%');
      })
    ->with('detail')
    ->paginate(request()->per_page);

    return response()->json(['message' => $data], 200);
  }

  public function store(Request $request)
  {
    /** creator */
    $user = Auth::guard('sanctum')->user()->detailuser;
    $details = $request->input('inputs');
    
    $arrdetails = [];
    foreach($details as $d)
    {
      $detail = new PhonebookExternalDetail([
        'number' => $d['number'],
        'pic' => $d['pic'],
      ]);
      array_push($arrdetails, $detail);
    }

    $log = new PhonebookExternalLog([
      'phonebook_type' => $request->input('typeinput'),
      'activity' => 'menambah data baru',
      'user_id' => $user->id,
    ]);

    $storedata = PhonebookExternal::create([
      'type' => $request->input('typeinput'),
      'name' => $request->input('name'),
      'address' => $request->input('address'),
      'city' => $request->input('city'),
      'company_name' => $request->input('company'),
      'company_address' => $request->input('company_address'),
      'email' => $request->input('email'),
      'note' => $request->input('keterangan'),
      'created_by' => $user->id,
    ]);
    $storedata->detail()->saveMany($arrdetails);
    $storedata->logs()->save($log);
    return response()->json(['message' => 'Data berhasil disimpan.'], 201);
  }

  public function detail($id)
  {
    return PhonebookExternal::find($id)->load('detail', 'logs', 'creator');
  }

  public function update(Request $request, $id)
  {
    $data = PhonebookExternal::find($id);
    $user = Auth::guard('sanctum')->user()->detail;

    $log = new PhonebookExternalLog([
      'phonebook_type' => $request->input('typeinput'),
      'activity' => 'merubah/menambah data.',
      'user_id' => $user->id,
    ]);

    $data->update([
      'name' => $request->input('name'),
      'address' => $request->input('address'),
      'city' => $request->input('city'),
      'company_name' => $request->input('company'),
      'company_address' => $request->input('company_address'),
      'email' => $request->input('email'),
      'note' => $request->input('keterangan'),
    ]);

    $detail = $request->input('inputs');
    foreach ($detail as $d)
    {
      $updatedetail = PhonebookExternal::updateOrCreate(
        [ 'id' => $d['id'], 'phonebook_id' => $id ],
        [ 'number' => $d['number'], 'pic' => $d['pic'] ]
      );
    }

    $data->logs()->save($log);
    return response()->json(['message' => 'Data berhasil dirubah.'], 200);
  }

  public function delete($id)
  {
    $data = PhonebookExternal::find($id);
    $data->detail()->delete();
    $data->logs()->delete();
    $data->delete();
    return response()->json(['message' => 'Data dihapus.'], 200);
  }

  public function deletedetail($id, $iddetail)
  {
    $data = PhonebookExternal::find($id);
    $data->detail()->where('id', $iddetail)->delete();
    return response()->json(['message' => 'Nomor dihapus.'], 200);
  }
}
