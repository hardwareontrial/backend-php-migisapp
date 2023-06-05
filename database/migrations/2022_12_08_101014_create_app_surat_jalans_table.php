<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAppSuratJalansTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('app_suratjalans', function (Blueprint $table) {
            $table->string('delivery_no')->primary();
            $table->string('do_no')->nullable();
            $table->string('po_no')->nullable();
            $table->bigInteger('created_by');
            $table->enum('is_processing', ['0', '1'])->default('0');
            $table->enum('is_remark', ['0', '1'])->default('0');
            $table->string('invoice_no')->nullable();
            $table->integer('print_count')->default(0);
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
        Schema::dropIfExists('app_suratjalans');
    }
}
