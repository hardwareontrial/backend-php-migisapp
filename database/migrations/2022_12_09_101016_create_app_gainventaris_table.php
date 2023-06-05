<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAppGainventarisTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('app_gainventaris', function (Blueprint $table) {
            $table->id();
            $table->string('kd_brg');
            $table->string('nama_brg');
            $table->date('tgl_beli');
            $table->integer('harga')->nullable();
            $table->string('toko')->nullable();
            $table->text('spesifikasi')->nullable();
            $table->string('serialnumber')->nullable();
            $table->integer('pemilik_id');
            $table->integer('merk_id');
            $table->integer('status_id');
            $table->integer('lokasi_id');
            $table->integer('user1_id')->nullable();
            $table->integer('user2_id')->nullable();
            $table->integer('dept_user')->nullable();
            $table->string('mtc_note')->nullable();
            $table->string('qrcode')->nullable();
            $table->tinyInteger('active');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('app_gainventaris');
    }
}
