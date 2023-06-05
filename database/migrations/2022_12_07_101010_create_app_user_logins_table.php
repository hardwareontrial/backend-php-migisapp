<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAppUserLoginsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('app_user_logins', function (Blueprint $table) {
            $table->string('nik')->primary();
			$table->string('s_nik');
			$table->string('email')->unique();
			$table->string('password');
            $table->tinyInteger('active');
            $table->tinyInteger('admin');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('app_user_logins');
    }
}
