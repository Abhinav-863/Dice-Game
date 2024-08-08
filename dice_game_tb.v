`timescale 1ns/1ps
`include "dice_game.v"
module dice_game_tb;

    reg rb;
    reg reset;
    reg clk;
    reg [3:0] sum;
    wire roll;
    wire win;
    wire lose;

    dice_game uut (
        .rb(rb),
        .reset(reset),
        .clk(clk),
        .sum(sum),
        .roll(roll),
        .win(win),
        .lose(lose)
    );

    always #5 clk = ~clk;

    initial begin
        $monitor("At time %t: rb = %b, reset = %b, clk = %b, sum = %d, roll = %b, win = %b, lose = %b",$time, rb, reset, clk, sum, roll, win, lose);

        //Initialize
        clk = 0;
        rb = 0;
        reset = 1;
        sum = 4'd0;

        #10 reset = 0;

        //Case 1
        #10 rb = 1;
        #10 rb = 0; sum = 4'd7; //win

        #10 reset=1;
        #10 reset=0;

        //case 2
        #20 rb = 1;
        #10 rb = 0; sum = 4'd3; //lose

        #10 reset=1;
        #10 reset=0;

        // Test case 3
        #20 rb = 1;
        #10 rb = 0; sum = 4'd4; //go to ROLL_AGAIN state
        #20 rb = 1;
        #10 rb = 0; sum = 4'd4; //win

        #10 reset=1;
        #10 reset=0;

        // Test case 4
        #20 rb = 1;
        #10 rb = 0; sum = 4'd12; //go to ROLL_AGAIN state
        #20 rb = 1;
        #10 rb = 0; sum = 4'd7; //lose

        #20 $finish;
    end

    initial begin
        $dumpfile("dice_game.vcd");
        $dumpvars(0, dice_game_tb);
    end
endmodule
