<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAppGainventarisSellsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('app_gainventaris_sells', function (Blueprint $table) {
            $table->id();
            $table->string('ex_kd_brg');
            $table->string('nama_brg');
            $table->date('tgl_beli');
            $table->integer('harga_beli')->nullable();
            $table->string('toko')->nullable();
            $table->text('spesifikasi')->nullable();
            $table->string('serialnumber')->nullable();
            $table->string('pemilik');
            $table->string('merk');
            $table->integer('harga_jual')->nullable();
            $table->json('history');
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
        Schema::dropIfExists('app_gainventaris_sells');
    }
}
