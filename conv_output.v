`timescale 1ns / 1ps
// ==========================================
// conv_output.v  --  multiple filters (outputs)
// Pure Verilog (Vivado Compatible)
// ==========================================
module conv_output (
    input  clk,
    input  rstn,
    input  valid_in,
    input  [IN_CH*DATA_W*9-1:0] window_in,
    input  [OUT_CH*IN_CH*DATA_W*9-1:0] weight_bank,
    output [OUT_CH-1:0] valid_out,
    output [OUT_CH*ACC_W-1:0] acc_out
);
    // ===================================================
    // Parameter Declarations
    // ===================================================
    parameter DATA_W = 8;
    parameter ACC_W  = 32;
    parameter IN_CH  = 3;
    parameter OUT_CH = 8;

    // ===================================================
    // Generate Convolution Channels
    // ===================================================
    genvar out;
    generate
        for (out = 0; out < OUT_CH; out = out + 1) begin : OUT
            conv_channel #(
                .DATA_W(DATA_W),
                .ACC_W(ACC_W),
                .IN_CH(IN_CH)
            ) OUT_CORE (
                .clk(clk),
                .rstn(rstn),
                .valid_in(valid_in),
                .window_in(window_in),
                // Select corresponding weights for each output channel
                .weight_in(weight_bank[(IN_CH*DATA_W*9*(OUT_CH - out)) - 1 -: (IN_CH*DATA_W*9)]),
                .valid_out(valid_out[out]),
                .acc_sum(acc_out[(ACC_W*(OUT_CH - out)) - 1 -: ACC_W])
            );
        end
    endgenerate

endmodule
