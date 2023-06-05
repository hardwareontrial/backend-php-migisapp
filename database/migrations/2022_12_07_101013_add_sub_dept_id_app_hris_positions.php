<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddSubDeptIdAppHrisPositions extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('app_hr_positions', function (Blueprint $table) {
            $table->unsignedBigInteger('sub_dept_id')->after('dept_id')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('app_hr_positions', function (Blueprint $table) {
            $table->dropColumn('sub_dept_id');
        });
    }
}
