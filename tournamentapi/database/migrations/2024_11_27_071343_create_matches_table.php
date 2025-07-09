<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('matches', function (Blueprint $table) {
            $table->id(); // Primary key
            $table->foreignId('tournament_id') // Foreign key
                  ->constrained('tournaments') // References 'id' on 'tournaments'
                  ->onDelete('cascade'); // Delete matches if the tournament is deleted
            $table->string('team_one'); // Name of Team 1
            $table->string('team_two'); // Name of Team 2
            $table->integer('team_one_score')->default(0); // Score of Team 1
            $table->integer('team_two_score')->default(0); // Score of Team 2
            $table->dateTime('match_date'); // Match date and time
            $table->timestamps(); // Created at & Updated at
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('matches');
    }
};
