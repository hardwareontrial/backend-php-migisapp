<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAppElearningQuestionCollectionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('app_elearning_question_collections', function (Blueprint $table) {
            $table->id();
            $table->integer('questions_id');
            $table->json('question');
            $table->json('answer_options');
            $table->integer('answer_key');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('app_elearning_question_collections');
    }
}
