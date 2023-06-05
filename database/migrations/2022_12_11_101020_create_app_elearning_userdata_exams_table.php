<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAppElearningUserdataExamsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('app_elearning_userdata_exams', function (Blueprint $table) {
            $table->id();
            $table->integer('schedule_id');
            $table->string('user_nik');
            $table->json('questions_pattern');
            $table->json('answers_user')->nullable();
            $table->dateTime('user_start_exam')->nullable();
            $table->dateTime('user_end_exam')->nullable();
            $table->integer('timeleft_seconds')->nullable();
            $table->integer('isdone')->comment('1: Selesai, 2: Belum Dikerjakan, 3: Proses');
            $table->integer('ispassed')->comment('1: Passed, 2: NotPassed');
            $table->integer('score')->default('0');
            $table->text('certificate')->nullable();
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
        Schema::dropIfExists('app_elearning_userdata_exams');
    }
}
