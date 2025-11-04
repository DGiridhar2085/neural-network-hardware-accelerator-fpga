`timescale 1ns / 1ps
// ==========================================
// tb_cnn_top.v  --  Testbench for cnn_top (Pure Verilog)
// ==========================================
module tb_cnn_top;

    // ===================================================
    // Clock and Reset
    // ===================================================
    reg clk = 0;
    reg rstn = 0;
    always #5 clk = ~clk;  // Generates 100 MHz clock

    // ===================================================
    // DUT Inputs and Outputs
    // ===================================================
    reg valid_in;
    reg [3*8*9-1:0] window;
    reg [8*3*8*9-1:0] weights;
    wire [7:0] valid_out;
    wire [8*32-1:0] acc_out;

    // ===================================================
    // Instantiate DUT (cnn_top)
    // ===================================================
    cnn_top DUT (
        .clk(clk),
        .rstn(rstn),
        .valid_in(valid_in),
        .window_in(window),
        .weight_bank(weights),
        .valid_out(valid_out),
        .acc_out(acc_out)
    );

    // ===================================================
    // Test Sequence
    // ===================================================
    integer i;
    initial begin
        // Initialize
        rstn = 0;
        valid_in = 0;
        #20 rstn = 1;

        // Prepare window data (each channel has 1..9)
        window = {
            {8'd1,8'd2,8'd3,8'd4,8'd5,8'd6,8'd7,8'd8,8'd9}, // ch3
            {8'd1,8'd2,8'd3,8'd4,8'd5,8'd6,8'd7,8'd8,8'd9}, // ch2
            {8'd1,8'd2,8'd3,8'd4,8'd5,8'd6,8'd7,8'd8,8'd9}  // ch1
        };

        // Set all weights = 1
        for (i = 0; i < 8*3*9; i = i + 1)
            weights[i*8 +: 8] = 8'd1;

        // Apply single valid input pulse
        #10 valid_in = 1;
        #10 valid_in = 0;

        // Wait for pipeline to settle
        #100;

        // Display results
        $display("====================================");
        $display("Simulation complete");
        $display("Valid_out = %b", valid_out);
        $display("acc_out[0] = %d", acc_out[31:0]);
        $display("====================================");
        $finish;
    end

endmodule
