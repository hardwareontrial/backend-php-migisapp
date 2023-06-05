<?php

namespace App\Http\Controllers\API\DeliveryNote;

use App\Exports\API\SuratJalan\ByDefault;
use App\Http\Controllers\Controller;
use App\Models\API\DeliveryNote\AppSuratJalan;
use App\Models\API\DeliveryNote\AppSuratJalanDetail;
use App\Models\API\DeliveryNote\AppSuratJalanLog;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\File;
use Maatwebsite\Excel\Facades\Excel;

class AppSuratJalanController extends Controller
{
  public function index()
  {
    $cari = request()->q;
    $data = AppSuratJalan::orderBy(request()->sortby, request()->sortbydesc)
      ->whereHas('detail', function($query) use ($cari){
        $query->where(function ($query) use ($cari){
          $query->where('detail_customer', 'LIKE', '%'.$cari.'%')
              ->orWhere('detail_address', 'LIKE', '%'.$cari.'%')
              ->orWhere('detail_city', 'LIKE', '%'.$cari.'%')
              ->orWhere('detail_nopol', 'LIKE', '%'.$cari.'%')
              ->orWhere('detail_driver', 'LIKE', '%'.$cari.'%')
              ->orWhere('detail_item', 'LIKE', '%'.$cari.'%')
              ->orWhere('detail_qty', 'LIKE', '%'.$cari.'%')
              ->orWhere('detail_uom', 'LIKE', '%'.$cari.'%')
              ->orWhere('detail_sending_date', 'LIKE', '%'.$cari.'%');
        })
        ->orWhere('delivery_no', 'LIKE', '%'.$cari.'%')
        ->orWhere('do_no', 'LIKE', '%'.$cari.'%')
        ->orWhere('po_no', 'LIKE', '%'.$cari.'%')
        ->orWhere('invoice_no', 'LIKE', '%'.$cari.'%');
      })
      ->orWhereHas('creator', function($query) use ($cari){
        $query->where('name', 'LIKE', '%'.$cari.'%');
      })
      ->with('detail', 'creator')
      ->paginate(request()->per_page);

    return response()->json(['message' => $data], 200);
  }

  public function store(Request $request)
  {
    /** set delivery no. */
    $base = 'S-'.Carbon::now()->format('ymd');
    if(AppSuratJalan::where('delivery_no', 'LIKE', $base.'%')->count()>0){
      $lastno = AppSuratJalan::orderBy('delivery_no', 'desc')->first();
      $count = substr($lastno->delivery_no, 2)+1;
      $delivery_no = 'S-'.$count; 
    }else{ $delivery_no = $base.'0001'; }

    /** creator */
    $user = Auth::guard('sanctum')->user()->detailuser;

    /** log description */
    if($request->input('btnRequest') == 1){ 
      $desc = 'Create and Print Surat Jalan';
    }
    else{ 
      $desc = 'Create Surat Jalan'; 
    }

    $deliverydetail = new AppSuratJalanDetail([
      'deliveryno_id' => $delivery_no,
      'detail_customer' => ucfirst($request->input('customernama')),
      'detail_address' => ucfirst($request->input('customeralamat')),
      'detail_city' => strtoupper($request->input('customerkota')),
      'detail_nopol' => strtoupper($request->input('nopol')),
      'detail_driver' => strtoupper($request->input('drivernama')),
      'detail_item' => $request->input('item'),
      'detail_qty' => $request->input('qty'),
      'detail_uom' => $request->input('uom'),
      'detail_sending_date' => $request->input('tanggalkirim')
    ]);

    $deliverylog = new AppSuratJalanLog([
      'deliveryno_id' => $delivery_no,
      'action_name' => $desc,
      'created_by' => $user->id,
    ]);

    $delivery = AppSuratJalan::create([
      'delivery_no' => $delivery_no,
      'do_no' => $request->input('donumber'),
      'po_no' => $request->input('ponumber'),
      'created_by' => $user->id,
      'is_processing' => '1',
      'is_remark' => '0',
    ]);
    $delivery->detail()->save($deliverydetail);
    $delivery->logs()->save($deliverylog);
    $result = $delivery->load('detail');

    return response()->json([
      'message' => 'Surat Jalan berhasil disimpan.',
      'result' => $result,
    ], 200);
  }

  public function detail($deliveryno)
  {
    return AppSuratJalan::find($deliveryno)->load('detail', 'logs');
  }

  public function update(Request $request, $deliveryno)
  {
    $keyword = request()->keyword;

    if($keyword == 'update-form-sj'){
      /** log description */
      if($request->input('btnRequest') == 1){ $desc = 'Update and Print Surat Jalan'; }
      else{ $desc = 'Update Surat Jalan'; }

      /** creator */
      $user = Auth::guard('sanctum')->user()->detailuser;

      $data = AppSuratJalan::findOrFail($deliveryno);
      $data->update([
        'do_no' => $request->input('donumber'),
        'po_no' => $request->input('ponumber'),
      ]);

      $data->detail()->update([
        'detail_customer' => ucfirst($request->input('customernama')),
        'detail_address' => ucfirst($request->input('customeralamat')),
        'detail_city' => strtoupper($request->input('customerkota')),
        'detail_nopol' => strtoupper($request->input('nopol')),
        'detail_driver' => strtoupper($request->input('drivernama')),
        'detail_item' => $request->input('item'),
        'detail_qty' => $request->input('qty'),
        'detail_uom' => $request->input('uom'),
        'detail_sending_date' => $request->input('tanggalkirim')
      ]);

      $deliverylog = new AppSuratJalanLog([
        'deliveryno_id' => $deliveryno,
        'action_name' => $desc,
        'created_by' => $user->id,
      ]);

      $data->logs()->save($deliverylog);
      $result = $data->load('detail');

      return response()->json([
        'message' => 'Surat Jalan berhasil disimpan.',
        'result' => $result
      ], 200);
    }

    else if($keyword == 'update-print-count'){
      $data = AppSuratJalan::findOrFail($deliveryno);
      $count = $data->print_count +1;

      /** creator */
      $user = Auth::guard('sanctum')->user()->detailuser;

      $deliverylog = new AppSuratJalanLog([
        'deliveryno_id' => $deliveryno,
        'action_name' => 'Print Surat Jalan',
        'created_by' => $user->id,
      ]);

      $data->update([ 'print_count' => $count ]);
      $data->logs()->save($deliverylog);

      return response()->json(['message' => 'Print Counted +1.'], 200);
    }

    else if($keyword == 'update-post-invoice'){
      $data = AppSuratJalan::findOrFail($deliveryno);
      
      /** creator */
      $user = Auth::guard('sanctum')->user()->detailuser;
      
      $deliverylog = new AppSuratJalanLog([
        'deliveryno_id' => $deliveryno,
        'action_name' => 'Invoiced',
        'created_by' => $user->id,
      ]);

      $data->update([
        'invoice_no' => $request->input('invoiceno'),
        'is_processing' => '0',
        'is_remark' => '1',
      ]);
      $data->logs()->save($deliverylog);

      return response()->json(['message' => 'Print Counted +1.'], 200);
    }
  }

  public function delete()
  {
    //
  }

  public function export()
  {
    $storedir = storage_path('app/public/app_suratjalan/').'export';
    if(!File::exists($storedir)){
      File::makeDirectory($storedir, 0777, true);
    }

    $creatorid = json_decode(request('creator'));
    $sentstartdate = request('sentstartdate');
    $sentenddate = request('sentenddate');
    $createstartdate = request('createstartdate');
    $createenddate = request('createenddate');
    $filename = 'sjexport_'. Carbon::now()->format('ymd_hi').'.xlsx';
    
    return Excel::download(new ByDefault($creatorid, $createstartdate, $createenddate, $sentstartdate, $sentenddate), $filename);
  }
}
