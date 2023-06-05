<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddCertificateIdAppElearningSchedule extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('app_elearning_schedules', function (Blueprint $table) {
            $table->integer('certificate_id')->nullable()->after('isactive');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('app_elearning_schedules', function (Blueprint $table) {
            $table->dropColumn('certificate_id');
        });
    }
}
