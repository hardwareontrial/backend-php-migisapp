<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAppElearningSchedulesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('app_elearning_schedules', function (Blueprint $table) {
            $table->id();
            $table->string('title')->nullable();
            $table->integer('nilai_min');
            $table->integer('duraion');
            $table->integer('question_id')->unsigned();
            $table->integer('type');
            $table->dateTime('startdate_exam');
            $table->dateTime('enddate_exam');
            $table->text('note');
            $table->json('participant_id')->nullable();
            $table->integer('questions_count');
            $table->integer('created_by')->unsigned();
            $table->integer('isactive');
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
        Schema::dropIfExists('app_elearning_schedules');
    }
}
