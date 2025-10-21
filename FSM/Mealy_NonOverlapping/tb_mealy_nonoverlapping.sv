`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module tb_mealy_overlapping;

    logic clk, rst, inp;
    logic y;

    mealy_nonoverlapping dut (
        .clk(clk),
        .rst(rst),
        .inp(inp),
        .y(y)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;   // 100 MHz clock (10 ns period)
    end

    initial begin
        $display("\n--- Starting 1010 sequence detection test ---");
        $display("Time\tclk\tinp\ty\tState");

        // Reset
        rst = 1; inp = 0;
        #10;
        rst = 0;

        repeat (2) @(posedge clk); inp = 1;  
        @(posedge clk); inp = 0;             
        @(posedge clk); inp = 1;             
        @(posedge clk); inp = 0;             
        @(posedge clk); inp = 1;             
        @(posedge clk); inp = 0;             
        @(posedge clk); inp = 1;             
        @(posedge clk); inp = 1;             
        @(posedge clk); inp = 0;             
        @(posedge clk); inp = 1;             
        @(posedge clk); inp = 0;             

        #20;
        $finish;
    end

    always @(posedge clk) begin
        $display("%0t\t%b\t%b\t%b", $time, clk, inp, y);
        if (y)
            $display(">>> Sequence 1010 detected at time %0t <<<", $time);
    end

endmodule
