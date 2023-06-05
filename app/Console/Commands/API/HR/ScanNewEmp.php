<?php

namespace App\Console\Commands\API\HR;

use App\Models\API\Hr\AppKaryawanSource;
use App\Models\API\User\AppUser;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Log;

class ScanNewEmp extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'migisapp:scannewemp';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Scan New Register Employee';

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
                if(!$storenewuser){ Log::info('Failed to Add Employee'); }
                else{ Log::info('Add new Employee Successfully'); }
            }
        }
    }
}
