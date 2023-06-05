<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAppGainventarisAppUserTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('app_gainventaris_app_user', function (Blueprint $table) {
            $table->id();
            $table->integer('app_gainventaris_id')->unsigned();
            $table->integer('app_user_id')->unsigned();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('app_gainventaris_app_user');
    }
}
