<?php

namespace App\Http\Controllers\API\Hr;

use App\Http\Controllers\Controller;
use App\Models\API\Hr\AppAttendace;
use App\Models\API\Hr\AppAttendaceLog;
use App\Models\API\Hr\AppAttendaceSource;
use App\Models\API\Hr\AppKaryawanSource;
use App\Models\API\User\AppUser;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Storage;

class AppAttendanceController extends Controller
{
  public function index()
  {
    return AppAttendace::orderBy('id', 'desc')->get();
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
    //
  }

  public function delete($id)
  {
    //
  }

  public function sync()
  {
    $input_start = request()->startdate;
    $input_end = request()->enddate;

    $check = AppAttendace::count();

    if($check == 0){
      $start = $input_start;
      $end = $input_end;
    }
    else{
      $lastdata = AppAttendace::select('id', 'scan_date')->orderBy('scan_date', 'desc')->first();
      $source_lastdata = AppAttendaceSource::where('scan_date', '>', $lastdata->scan_date)->min('scan_date');
      $start = $source_lastdata;
      $end = $input_end;
    }

    $data = AppAttendaceSource::tanpaHarianLepas()
        ->whereBetween('scan_date', [$start, $end])
        ->with('name')
        ->get();

    foreach($data as $d){
      $pin = $d->pin;
      $scandate = date('Y-m-d H:i:s', strtotime($d->scan_date));
      $pin_name = $d->name ? $d->name['name'] : 'NULL';

      $store = AppAttendace::create([
        'pin' => $pin,
        'name' => $pin_name,
        'scan_date' => $scandate,
      ]);
    }
  }

  public function autosync()
  {
    $storelog = storage_path('app/public/app_hris/').'autosync_log';
    if(!File::exists($storelog)){
      File::makeDirectory($storelog, 0777, true);
    }

    $check = AppAttendace::count();

    if($check == 0){
      $start = Carbon::now()->format('Y-m-d 00:00:00');
      $end = Carbon::now()->format('Y-m-d H:i:s');
    }
    else{
      $lastdata = AppAttendace::select('id', 'scan_date')->orderBy('scan_date', 'desc')->first();
      $source_lastdata = AppAttendaceSource::where('scan_date', '>', $lastdata->scan_date)->min('scan_date');
      $start = $source_lastdata;
      $end = Carbon::now()->format('Y-m-d H:i:s');
    }

    $data = AppAttendaceSource::tanpaHarianLepas()
        ->whereBetween('scan_date', [$start, $end])
        ->with('name')
        ->get();

    if($data->count() > 0 ){
      foreach($data as $d){
        $pin = $d->pin;
        $scandate = date('Y-m-d H:i:s', strtotime($d->scan_date));
        $pin_name = $d->name ? $d->name['name'] : 'NULL';

        $store = AppAttendace::create([
          'pin' => $pin,
          'name' => $pin_name,
          'scan_date' => $scandate,
        ]);
      }
      /** Generate .txt File */
      // storage_path = storage_path('app/public/app_hris/presence_txt/')
      if(!$store){ return response()->json(['message' => 'Data gagal disimpan.'], 500); }
      return response()->json(['message' => 'Data berhasil disimpan.'], 200);
    }
  }

  public function generateAutoText()
  {
    $checkpresence = AppAttendace::count();
    $checkexport = AppAttendaceLog::count();

    $storedir = storage_path('app/public/app_hris/').'presence_txt';
    if(!File::exists($storedir)){
      File::makeDirectory($storedir, 0777, true);
    }

    if($checkpresence == 0){
      AppAttendaceLog::create([
        'startdate' => NULL,
        'enddate' => NULL,
        'note' => 'No Presence Available To Export.'
      ]);
    }else{
      if($checkexport == 0){
        $inputstart = AppAttendace::select('id', 'scan_date')->orderBy('scan_date', 'asc')->first();
        $inputend = AppAttendace::select('id', 'scan_date')->orderBy('scan_date', 'desc')->first();
        $data = AppAttendace::whereBetween('scan_date', [$inputstart->scan_date, $inputend->scan_date])->get();
        $filename = str_replace(['-', ' ', ':'], ['', '',''], $inputstart->scan_date).'-'.str_replace(['-', ' ', ':'], ['', '',''], $inputend->scan_date).'.txt';
        $content = "";
        foreach ($data as $d){
          $content .= $d->pin;
          $content .= ',';
          $content .= $d->name;
          $content .= ',';
          $content .= date('d/m/Y H:i', strtotime($d->scan_date));
          $content .= "\n";
        }
        Storage::disk('absensiexport')->put($filename, $content);
        AppAttendaceLog::create([
          'startdate' => $inputstart->scan_date,
          'enddate' => $inputend->scan_date,
          'note' => 'Export created with filename '.$filename,
        ]);
      }else{
        $lastexportdata = AppAttendaceLog::orderBy('id', 'desc')->first();
        if(empty($lastexportdata->enddate)){
          $inputstart = AppAttendace::select('id', 'scan_date')->orderBy('scan_date', 'asc')->first();
          $inputend = AppAttendace::select('id', 'scan_date')->orderBy('scan_date', 'desc')->first();
          $data = AppAttendace::whereBetween('scan_date', [$inputstart->scan_date, $inputend->scan_date])->get();
          $filename = str_replace(['-', ' ', ':'], ['', '',''], $inputstart->scan_date).'-'.str_replace(['-', ' ', ':'], ['', '',''], $inputend->scan_date).'.txt';
          $content = "";
          foreach ($data as $d){
            $content .= $d->pin;
            $content .= ',';
            $content .= $d->name;
            $content .= ',';
            $content .= date('d/m/Y H:i', strtotime($d->scan_date));
            $content .= "\n";
          }
          Storage::disk('absensiexport')->put($filename, $content);
          AppAttendaceLog::create([
            'startdate' => $inputstart->scan_date,
            'enddate' => $inputend->scan_date,
            'note' => 'Export created with filename '.$filename,
          ]);
        }else{
          $inputstart = $lastexportdata->enddate;
          $inputend = AppAttendace::select('id', 'scan_date')->orderBy('scan_date', 'desc')->first();
          $data = AppAttendace::whereBetween('scan_date', [$inputstart, $inputend->scan_date])->get();
          $filename = str_replace(['-', ' ', ':'], ['', '',''], $inputstart).'-'.str_replace(['-', ' ', ':'], ['', '',''], $inputend->scan_date).'.txt';
          $content = "";
          foreach ($data as $d){
            $content .= $d->pin;
            $content .= ',';
            $content .= $d->name;
            $content .= ',';
            $content .= date('d/m/Y H:i', strtotime($d->scan_date));
            $content .= "\n";
          }
          Storage::disk('absensiexport')->put($filename, $content);
          AppAttendaceLog::create([
            'startdate' => $inputstart,
            'enddate' => $inputend->scan_date,
            'note' => 'Export created with filename '.$filename,
          ]);
        }
      }
    }
  }

  public function generateText()
  {
    $input_start = request()->startdate;
    $input_end = request()->enddate;
    return AppAttendace::whereBetween('scan_date', [$input_start, $input_end])->orderBy('id', 'asc')->get();
  }

  public function scanNewPegawai()
  {
    $lastpin = AppUser::registeredkaryawan()->get()->pluck('nik')->last();
    $lastpinsource = AppKaryawanSource::pluck('pegawai_pin')->last();

    if($lastpin !== $lastpinsource){
      $nextpin = AppKaryawanSource::where('pegawai_pin', '>', $lastpin)->min('pegawai_pin');
      $getdata = AppKaryawanSource::whereBetween('pegawai_pin', [$nextpin, $lastpinsource])->get();

      if($getdata->count() > 0){
        foreach ($getdata as $newuser){
          $storenewuser = AppUser::create([
            'nik' => $newuser->pegawai_pin,
            'name' => $newuser->pegawai_nama,
            'active' => 1,
          ]);
        }
        if(!$storenewuser){ return response()->json(['message' => 'Data gagal disimpan']); }
        return response()->json(['message' => 'Data berhasil disimpan.']);
      }
    }
  }
}
