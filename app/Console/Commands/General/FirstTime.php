<?php

namespace App\Console\Commands\General;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\File;

class FirstTime extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'migisapp:first';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'First Time deploy migisapp';

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
        $this->call('key:generate');
        $this->call('storage:link');
        /** Make app folders on storage app folder */
        $store_elearning = storage_path('app/public/app_elearning');
        if(!File::exist($store_elearning)){ File::makeDirectory($store_elearning, 0777, true); }
        $store_hr = storage_path('app/public/app_hris');
        if(!File::exist($store_hr)){ File::makeDirectory($store_hr, 0777, true); }
        $store_inventaris = storage_path('app/public/app_inventaris');
        if(!File::exist($store_inventaris)){ File::makeDirectory($store_inventaris, 0777, true); }
        $store_suratjalan = storage_path('app/public/app_suratjalan');
        if(!File::exist($store_suratjalan)){ File::makeDirectory($store_suratjalan, 0777, true); }
        $store_user = storage_path('app/public/app_user');
        if(!File::exist($store_user)){ File::makeDirectory($store_user, 0777, true); }
        $this->call('config:cache');
        $this->call('cache:clear');
        $this->call('migrate');
    }
}
