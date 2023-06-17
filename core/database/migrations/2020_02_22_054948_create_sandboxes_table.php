<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSandboxesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('sandboxes', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->integer('currency_id')->nullable();
            $table->string('trx')->nullable();
            $table->decimal('amount',11,8)->default(0);
            $table->decimal('charge',11,8)->default(0);
            $table->decimal('wallet_amount',11,8)->default(0);
            $table->tinyInteger('status')->default(0);
            $table->text('all_data')->nullable()->comment('amount, currency, public_key, custom, details, ipn_url, success_url, cancel_url');
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
        Schema::dropIfExists('sandboxes');
    }
}
