<?php

namespace App\Console;

use App\Http\Controllers\API\Elearning\ElearningScheduleController;
use App\Http\Controllers\API\Hr\AppAttendanceController;
use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;

class Kernel extends ConsoleKernel
{
    protected $commands = [
        Commands\API\HR\AutoSyncPresence::class,
        Commands\API\HR\GeneratePresenceTextFile::class,
        Commands\API\HR\ScanNewEmp::class,
        Commands\General\FirstTime::class,
    ];

    /**
     * Define the application's command schedule.
     *
     * @param  \Illuminate\Console\Scheduling\Schedule  $schedule
     * @return void
     */
    protected function schedule(Schedule $schedule)
    {
        // $schedule->command('inspire')->hourly();

        /** Command running using supervisor */
        $schedule->command('migisapp:syncpresence')->cron('58 0,7,11,16 * * *')->description('Sync Attendance from DB att_log');
        $schedule->command('migisapp:genpresencefile')->cron('2 1,8,12,17 * * *')->description('Generate data presence to txt file');
        $schedule->command('migisapp:scannewemp')->everySixHours()->description('Sync New Employee from DB att_log');
        // $schedule->command('migisapp:turnofflearning')->cron('13 0 * * *')->description('Turn Off Exam Schedule');
    }

    /**
     * Register the commands for the application.
     *
     * @return void
     */
    protected function commands()
    {
        $this->load(__DIR__.'/Commands');

        require base_path('routes/console.php');
    }
}
