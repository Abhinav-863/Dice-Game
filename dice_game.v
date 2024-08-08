module dice_game (
    input rb,
    input reset,
    input clk,
    input [3:0] sum, 
    output reg roll,
    output reg win,
    output reg lose
);

    // State declarations
    reg [2:0] state, nextstate;
    reg [3:0] point;
    reg sp;

    parameter WAIT = 3'b000;
    parameter FIRST_ROLL = 3'b001;
    parameter WIN_STATE = 3'b010;
    parameter LOSE_STATE = 3'b011;
    parameter ROLL_AGAIN = 3'b100;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= WAIT;
        end else begin
            state <= nextstate;
        end
    end

    always @(rb or reset or sum or state) begin
        // Default outputs
        sp <= 1'b0;
        roll <= 1'b0;
        win <= 1'b0;
        lose <= 1'b0;

        case (state)
            WAIT: begin
                if (rb) begin
                    nextstate <= FIRST_ROLL;
                end 
                else begin
                    nextstate <= WAIT;
                end
            end
            FIRST_ROLL: begin
                if (rb) begin
                    roll <= 1'b1;
                end 
                else if (sum == 7 || sum == 11) begin
                    nextstate <= WIN_STATE;
                end 
                else if (sum == 2 || sum == 3 || sum == 12) begin
                    nextstate <= LOSE_STATE;
                end 
                else begin
                    sp <= 1'b1;
                    nextstate <= ROLL_AGAIN;
                end
            end
            WIN_STATE: begin
                win <= 1'b1;
                if (reset) begin
                    nextstate <= WAIT;
                end
            end
            LOSE_STATE: begin
                lose <= 1'b1;
                if (reset) begin
                    nextstate <= WAIT;
                end
            end
            ROLL_AGAIN: begin
                if (rb) begin
                    roll <= 1'b1;
                
                    if (sum == point) begin
                        nextstate <= WIN_STATE;
                    end 
                    else if (sum == 7) begin
                        nextstate <= LOSE_STATE;
                    end 
                    else begin
                        nextstate <= ROLL_AGAIN;
                    end
                end
            end
        endcase
    end

    always @(posedge clk) begin
        if (sp) begin
            point <= sum;
        end
    end

endmodule
