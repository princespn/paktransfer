<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUserActionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('user_actions', function (Blueprint $table) {
            $table->id();
            $table->integer('otp')->default(0);
            $table->integer('user_id')->default(0);
            $table->integer('type')->default(0);
            $table->string('act',40)->comment('Action')->nullable();
            $table->text('details')->nullable();
            $table->datetime('send_at')->nullable();
            $table->datetime('used_at')->nullable();
            $table->datetime('expired_at')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('user_actions');
    }
}
