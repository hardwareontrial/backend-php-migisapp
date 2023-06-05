<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAppSuratJalanDetailsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('app_suratjalan_details', function (Blueprint $table) {
            $table->string('deliveryno_id')->primary();
            $table->string('detail_customer');
            $table->string('detail_address');
            $table->string('detail_city');
            $table->string('detail_nopol');
            $table->string('detail_driver');
            $table->string('detail_item');
            $table->integer('detail_qty');
            $table->string('detail_uom');
            $table->date('detail_sending_date');
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
        Schema::dropIfExists('app_suratjalan_details');
    }
}
