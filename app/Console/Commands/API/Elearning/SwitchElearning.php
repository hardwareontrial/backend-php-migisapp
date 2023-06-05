<?php

namespace App\Console\Commands\API\Elearning;

use App\Models\API\Elearning\AppElearningSchedule;
use Carbon\Carbon;
use Illuminate\Console\Command;

class SwitchElearning extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'migisapp:turnofflearning';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Switch Off Available Schedule Learning';

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
        $now = Carbon::now()->format('Y-m-d');
        $datas = AppElearningSchedule::where('isactive', 1)->where('enddate_exam', '<', $now)->get();
        $datas_count = $datas->count();
        if($datas_count > 0) {
            foreach($datas as $d){
                $x = AppElearningSchedule::find($d->id);
                $x->isactive = 0;
                $x->save();
            }
        }
    }
}
