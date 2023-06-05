<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAppElearningQuestionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('app_elearning_questions', function (Blueprint $table) {
            $table->id();
            $table->integer('material_id')->unsigned();
            $table->string('title');
            $table->integer('nilai_min')->nullable();
            $table->integer('duration')->nullable();
            $table->integer('created_by')->unsigned();
            $table->integer('level');
            $table->integer('isactive');
            $table->text('slug');
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
        Schema::dropIfExists('app_elearning_questions');
    }
}
