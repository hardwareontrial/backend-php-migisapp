<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAppElearningQuestionStatusUploadsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('app_elearning_question_status_uploads', function (Blueprint $table) {
            $table->id();
            $table->integer('material_id')->unsigned();
            $table->integer('question_id')->unsigned();
            $table->integer('question_collection_id')->unsigned()->nullable();
            $table->integer('status');
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
        Schema::dropIfExists('app_elearning_question_status_uploads');
    }
}
