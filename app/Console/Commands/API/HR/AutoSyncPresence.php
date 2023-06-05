<?php

namespace App\Console\Commands\API\HR;

use App\Models\API\Hr\AppAttendace;
use App\Models\API\Hr\AppAttendaceSource;
use Carbon\Carbon;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Log;

class AutoSyncPresence extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'migisapp:syncpresence';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Auto Sync Presence';

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
//            $end = '2023-03-20 12:00:00';
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
            if(!$store){
                Log::info('Sync onfly failed!');
            }else{
                Log::info('Sync onfly successfully');
            }
        }
    }
}
