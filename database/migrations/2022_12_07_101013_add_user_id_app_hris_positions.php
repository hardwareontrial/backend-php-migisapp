<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddUserIdAppHrisPositions extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('app_hr_positions', function (Blueprint $table) {
            $table->unsignedBigInteger('user_id')->after('level')->nullable();
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
            $table->dropColumn('user_id');
        });
    }
}
