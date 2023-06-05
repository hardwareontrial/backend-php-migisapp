<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAppElearningMaterialsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('app_elearning_materials', function (Blueprint $table) {
            $table->id();
            $table->text('m_title');
            $table->integer('dept_id')->unsigned();
            $table->integer('m_level');
            $table->integer('m_duration')->nullable();
            $table->text('m_desc');
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
        Schema::dropIfExists('app_elearning_materials');
    }
}
