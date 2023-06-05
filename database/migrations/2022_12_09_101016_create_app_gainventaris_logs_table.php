<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAppGainventarisLogsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('app_gainventaris_logs', function (Blueprint $table) {
            $table->id();
            $table->unsignedInteger('gainventaris_id');
            $table->integer('action');
            $table->integer('n_status_id')->nullable();
            $table->integer('o_status_id')->nullable();
            $table->integer('n_lokasi_id')->nullable();
            $table->integer('o_lokasi_id')->nullable();
            $table->integer('n_user1_id')->nullable();
            $table->integer('o_user1_id')->nullable();
            $table->integer('n_user2_id')->nullable();
            $table->integer('o_user2_id')->nullable();
            $table->integer('n_dept_user')->nullable();
            $table->integer('o_dept_user')->nullable();
            $table->string('n_nama_brg')->nullable();
            $table->string('o_nama_brg')->nullable();
            $table->date('n_tgl_beli')->nullable();
            $table->date('o_tgl_beli')->nullable();
            $table->string('n_toko')->nullable();
            $table->string('o_toko')->nullable();
            $table->integer('n_harga')->nullable();
            $table->integer('o_harga')->nullable();
            $table->string('n_serialnumber')->nullable();
            $table->string('o_serialnumber')->nullable();
            $table->integer('n_merk_id')->nullable();
            $table->integer('o_merk_id')->nullable();
            $table->string('n_spesifikasi')->nullable();
            $table->string('o_spesifikasi')->nullable();
            $table->string('n_mtc_note')->nullable();
            $table->string('o_mtc_note')->nullable();
            $table->integer('n_active')->nullable();
            $table->integer('o_active')->nullable();
            $table->integer('created_by')->nullable();
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
        Schema::dropIfExists('app_gainventaris_logs');
    }
}
