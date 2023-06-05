<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAppTodosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('app_simple_todos', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->date('dueDate');
            $table->text('detail');
            $table->unsignedBigInteger('assignee_id');
            $table->json('tags');
            $table->unsignedTinyInteger('isComplete');
            $table->unsignedTinyInteger('isImportant');
            $table->unsignedTinyInteger('isDeleted');
            $table->unsignedBigInteger('created_by');
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
        Schema::dropIfExists('app_simple_todos');
    }
}
