<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddRequestorIdAppTodosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('app_simple_todos', function (Blueprint $table) {
            $table->unsignedBigInteger('requestor_id')->unsigned()->after('tags');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('app_simple_todos', function (Blueprint $table) {
            $table->dropColumn('requestor_id');
        });
    }
}
