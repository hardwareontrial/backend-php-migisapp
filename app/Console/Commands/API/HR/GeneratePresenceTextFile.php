<?php

namespace App\Console\Commands\API\HR;

use App\Models\API\Hr\AppAttendace;
use App\Models\API\Hr\AppAttendaceLog;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Storage;

class GeneratePresenceTextFile extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'migisapp:genpresencefile';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Generate Presence in .txt File';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
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
}
