`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

// Mealy Non-Overlapping FSM for 1010 detection.
module mealy_nonoverlapping(
    input  logic clk, rst, inp,
    output logic y
);

    typedef enum logic [1:0] {A, B, C, D} state_type;
    state_type cur_state, nxt_state;

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            cur_state <= A;
        else
            cur_state <= nxt_state;
    end

    // Mealy output: high when in D and inp == 0 (i.e. last input completes 1010)
    assign y = (cur_state == D && inp == 0) ? 1 : 0;

    always_comb begin
        case (cur_state)
            A: begin
                if (inp==1)
                    nxt_state = B;   
                else
                    nxt_state = A;
            end

            B: begin
                if (inp==0)
                    nxt_state = C;    
                else
                    nxt_state = B;   
            end

            C: begin
                if (inp==1)
                    nxt_state = D;    
                else
                    nxt_state = A;
            end

            D: begin
                if (inp==0)
                    nxt_state = A;    
                else
                    nxt_state = B;    
            end
            default: nxt_state <= cur_state;
            
        endcase
    end

endmodule

