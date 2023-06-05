<?php

namespace App\Http\Controllers\API\DeliveryNote;

use App\Exports\API\SuratJalan\ByDefault;
use App\Http\Controllers\Controller;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Maatwebsite\Excel\Facades\Excel;
use SimpleSoftwareIO\QrCode\Facades\QrCode;

class AppSuratJalanExportController extends Controller
{
  public function export()
  {
    $creatorid = json_decode(request('creator'));
    $sentstartdate = request('sentstartdate');
    $sentenddate = request('sentenddate');
    $createstartdate = request('createstartdate');
    $createenddate = request('createenddate');
    $filename = 'sjexport_'. Carbon::now()->format('ymd_hi').'.xlsx';
    
    return Excel::download(new ByDefault($creatorid, $createstartdate, $createenddate, $sentstartdate, $sentenddate), $filename);
  }
}
