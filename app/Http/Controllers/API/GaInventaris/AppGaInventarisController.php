<?php

namespace App\Http\Controllers\API\GaInventaris;

use App\Http\Controllers\Controller;
use App\Models\API\GaInventaris\AppGaInventaris;
use App\Models\API\GaInventaris\AppGaInventarisLog;
use App\Models\API\GaInventaris\AppGaInventarisSell;
use App\Models\API\GaInventaris\ListLocation;
use App\Models\API\GaInventaris\ListMerk;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;
use SimpleSoftwareIO\QrCode\Facades\QrCode;

class AppGaInventarisController extends Controller
{
  public function index()
  {
    $cari = request()->q;
    $authusedept = request()->authuserdept;
    $authuseradmin = request()->authuseradmin;
    $data = AppGaInventaris::with('locname', 'merkname', 'user1name', 'user2name', 'user1name.position.deptname', 'user2name.position.deptname')
      ->where(function ($query) use ($cari, $authusedept, $authuseradmin){ $query
        ->where(function ($query2) use ($cari){ $query2
          ->whereHas('locname', function ($queryloc) use ($cari){ $queryloc
            ->where('name', 'LIKE', '%'.$cari.'%');
          })
          ->orWhereHas('merkname', function ($querymerk) use ($cari){ $querymerk
            ->where('name', 'LIKE', '%'.$cari.'%');
          })
          ->orWhereHas('user1name', function($queryuser1) use ($cari){ $queryuser1
            ->where('name', 'LIKE', '%'.$cari.'%')
            ->orWhereHas('position', function($queryuser1name) use ($cari){ $queryuser1name
              ->where('name', 'LIKE', '%'.$cari.'%'); 
            });
          })
          ->orWhereHas('user2name', function($queryuser2) use ($cari){ $queryuser2
            ->where('name', 'LIKE', '%'.$cari.'%')
            ->orWhereHas('position', function($queryuser2name) use ($cari){ $queryuser2name
              ->where('name', 'LIKE', '%'.$cari.'%'); 
            });
          })
          ->orWhere('kd_brg', 'LIKE', '%'.$cari.'%')
          ->orWhere('nama_brg', 'LIKE', '%'.$cari.'%');
        })
        ->when($authuseradmin == 0, function ($queryauthadmin) use ($authusedept){ $queryauthadmin
          ->where('pemilik_id', $authusedept, 3); // 3 for HSE
        });
      })
      ->orderBy(request()->sortby, request()->sortbydesc)
      ->paginate(request()->per_page);

    return response(['message' => $data], 200);
  }

  public function store(Request $request)
  {
    $ipf = env('IP_FRONTEND');
    if(!$ipf) return response()->json(['message' => 'Error (ENV_IP_FRONTEND) tidak dapat memproses.'], 500);
    $tablename = app(AppGaInventaris::class)->getTable();
    $base = 'NB ';
    if(AppGaInventaris::where('kd_brg', 'LIKE', $base.'%')->count() > 0){
      $last = AppGaInventaris::latest('id')->first();
      $count = substr($last->kd_brg, 2) +1;
      $kode = $base.str_pad($count, 4, '0', STR_PAD_LEFT);
    }else{
      $kode = $base.'0001';
    }

    $storedir = storage_path('app/public/app_inventaris/').'qrcode';
    if(!File::exists($storedir)){
      File::makeDirectory($storedir, 0777, true);
    }

    $db = DB::select("SHOW TABLE STATUS LIKE '".$tablename."'");
    $id = $db[0]->Auto_increment;

    $url = 'http://'.$ipf.'/inventaris/show/'.$id;

    $qrname = str_replace(' ', '', $kode).'.png';
    QrCode::size(300)
      ->format('png')
      ->style('round')
      ->merge('/public/image/mig.png', .25)
      ->generate($url, storage_path('app/public/app_inventaris/qrcode/'.$qrname));
    
    
    if ($request->input('status') == 1 || $request->input('status') == 3) {
      $store = AppGaInventaris::create([
        'kd_brg' => $kode,
        'nama_brg' => strtoupper($request->input('nama_brg')),
        'tgl_beli' => $request->input('tglbeli'),
        'harga' => $request->input('harga'),
        'toko' => strtoupper($request->input('toko')),
        'spesifikasi' => strtoupper($request->input('spesifikasi')),
        'merk_id' => $request->input('merk'),
        'lokasi_id' => $request->input('lokasi'),
        'status_id' => $request->input('status'),
        'pemilik_id' => $request->input('deptbeli'),
        'serialnumber' => strtoupper($request->input('sn')),
        'active' => true,
        'qrcode' => $qrname,
      ]);
    }
    else if ($request->input('status') == 2) {
      $user1 = $request->input('user1');
      $user2 = $request->input('user2');
      $store = AppGaInventaris::create([
        'kd_brg' => $request->input('kode_brg'),
        'nama_brg' => strtoupper($request->input('nama_brg')),
        'tgl_beli' => $request->input('tglbeli'),
        'harga' => $request->input('harga'),
        'toko' => strtoupper($request->input('toko')),
        'spesifikasi' => strtoupper($request->input('spesifikasi')),
        'merk_id' => $request->input('merk'),
        'lokasi_id' => $request->input('lokasi'),
        'status_id' => $request->input('status'),
        'pemilik_id' => $request->input('deptbeli'),
        'serialnumber' => strtoupper($request->input('sn')),
        'active' => true,
        'qrcode' => $qrname,
        'user1_id' => $user1,
        'user2_id' => $user2,
      ]);
    }
    if(!$store) { return response()->json(['message' => 'Data gagal disimpan.'], 500); }
    return response()->json(['message' => 'Data berhasil disimpan.'], 201);
  }

  public function detail($id)
  {
    return AppGaInventaris::find($id)->load('locname', 'merkname', 'user1name.position.deptname', 'user2name.position.deptname',
    'logs.creator', 'logs.user1namenew', 'logs.user1nameold', 'logs.user2nameold', 'logs.user2namenew', 'logs.locnamenew', 'logs.locnameold', 'logs.merknamenew', 'logs.merknameold');
  }

  public function update(Request $request, $kode)
  {
    /** Update from Form */
    $keyword = request()->keyword;
    $code = str_replace('-', ' ', $kode);
    $update = AppGaInventaris::where('kd_brg', $code)->first();

    if($keyword == 'update-from-form'){
      // $code = str_replace('-', ' ', $kode);
      // $update = AppGaInventaris::where('kd_brg', $code)->first();
      if ($request->input('status') == 1 || $request->input('status') == 3) {
        $update->update([
          'nama_brg' => strtoupper($request->input('nama_brg')),
          'tgl_beli' => $request->input('tglbeli'),
          'harga' => $request->input('harga'),
          'toko' => strtoupper($request->input('toko')),
          'spesifikasi' => strtoupper($request->input('spesifikasi')),
          'merk_id' => $request->input('merk'),
          'lokasi_id' => $request->input('lokasi'),
          'status_id' => $request->input('status'),
          'pemilik_id' => $request->input('deptbeli'),
          'serialnumber' => strtoupper($request->input('sn')),
          'user1_id' => null,
          'user2_id' => null,
          'dept_user' => null,
        ]);
      }else if ($request->input('status') == 2) {
        $user1 = $request->input('user1');
        $user2 = $request->input('user2');
        $update->update([
          'nama_brg' => strtoupper($request->input('nama_brg')),
          'tgl_beli' => $request->input('tglbeli'),
          'harga' => $request->input('harga'),
          'toko' => strtoupper($request->input('toko')),
          'spesifikasi' => strtoupper($request->input('spesifikasi')),
          'merk_id' => $request->input('merk'),
          'lokasi_id' => $request->input('lokasi'),
          'status_id' => $request->input('status'),
          'pemilik_id' => $request->input('deptbeli'),
          'serialnumber' => strtoupper($request->input('sn')),
          'user1_id' => $user1,
          'user2_id' => $user2,
        ]);
      }else{
        $update->update([
          'status_id' => $request->input('status'),
          'mtc_note' => strtoupper($request->input('mtc_note')),
        ]);
      }
      if(!$update){ return response()->json(['message' => 'Update gagal'], 500); }
      return response()->json(['message' => 'Data berhasil diperbarui.'], 200);
    }
    else if($keyword == 'update-active-from-table'){
      // $data = AppGainventaris::find($id);
      $active = !$update->active;
      $update->update([
        'user1_id' => null,
        'user2_id' => null,
        'status_id' => 1,
        'dept_user' => null,
        'active' => $active,
      ]);
      if(!$update){ return response()->json(['message' => 'Update gagal'], 500); }
      return response()->json(['message' => 'Update berhasil'], 200);
    }
    else{
      return response(['message' => 'Tidak ditemukan.'], 404);
    }
  }

  public function delete(Request $request, $id)
  {
    $hargajual = $request->input('hargajual');
    $data = AppGaInventaris::find($id)->load('merkname');
    $pemilikname = '';
    if($data->pemilik_id == 1){
      $pemilikname = 'GA';
    }elseif($data->pemilik_id == 2){
      $pemilikname = 'IT';
    }elseif($data->pemilik_id == 3){
      $pemilikname = 'HSE';
    }

    $hist = AppGaInventarisLog::where('gainventaris_id', $id)->get();
    $qrname = $data->qrcode;
    $storesell = AppGaInventarisSell::create([
      'ex_kd_brg' => $data->kd_brg,
      'nama_brg' => $data->nama_brg,
      'tgl_beli' => $data->tgl_beli,
      'harga_beli' => $data->harga,
      'toko' => $data->toko,
      'spesifikasi' => $data->spesifikasi,
      'serialnumber' => $data->serialnumber,
      'pemilik' => $pemilikname,
      'merk' => $data->merkname->name,
      'harga_jual' => $hargajual,
      'history' => $hist,
    ]);

    if($storesell){
      $data->delete();
      AppGaInventarisLog::where('gainventaris_id', $id)->delete();
      unlink(storage_path('app/public/app_inventaris/qrcode/'.$qrname));
    }

    if(!$data){ return response()->json(['message' => 'Menandai '. $data->kd_brg.' gagal'], 500); }
    return response()->json(['message' => 'Menandai '. $data->kd_brg.' berhasil'], 200);
  }

  public function addmerk(Request $request)
  {
    $this->validate($request, [ 'name' => 'required' ],[ 'name.required' => 'Input Nama Merk.' ]);
    DB::beginTransaction();
      $merk = new ListMerk();
      $merk->name = strtoupper($request->input('name'));
      $merk->save();
    DB::commit();
    return response()->json(['message' => 'Merk baru berhasil ditambah.'], 200);
  }

  public function addlocation(Request $request)
  {
    $this->validate($request, [ 'name' => 'required' ],[ 'name.required' => 'Input Nama Lokasi.' ]);
    DB::beginTransaction();
      $merk = new ListLocation();
      $merk->name = strtoupper($request->input('name'));
      $merk->save();
    DB::commit();
    return response()->json(['message' => 'Lokasi baru berhasil ditambah.'], 200);
  }

  public function sellinventaris(Request $request, $id)
  {
    //
  }

  public function setactive($id)
  {
    //
  }

  public function detailbyuser()
  {
    $userid = request()->id;
    $data = AppGaInventaris::where('user1_id', $userid)->orWhere('user2_id', $userid)
      ->with('locname', 'merkname', 'user1name.position.deptname', 'user2name.position.deptname', 'logs.creator', 'logs.user1namenew', 'logs.user1nameold', 'logs.user2nameold', 'logs.user2namenew', 'logs.locnamenew', 'logs.locnameold', 'logs.merknamenew', 'logs.merknameold')
      ->get();
    return response()->json(['message' => $data]);
  }
}
