`timescale 1ns / 1ps
// ==========================================
// cnn_top.v  --  top-level CNN convolution block (Pure Verilog)
// ==========================================
module cnn_top (
    input clk,
    input rstn,
    input valid_in,
    input [IN_CH*DATA_W*9-1:0] window_in,
    input [OUT_CH*IN_CH*DATA_W*9-1:0] weight_bank,
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
    // Convolution Output Module Instance
    // ===================================================
    conv_output #(
        .DATA_W(DATA_W),
        .ACC_W(ACC_W),
        .IN_CH(IN_CH),
        .OUT_CH(OUT_CH)
    ) U_OUT (
        .clk(clk),
        .rstn(rstn),
        .valid_in(valid_in),
        .window_in(window_in),
        .weight_bank(weight_bank),
        .valid_out(valid_out),
        .acc_out(acc_out)
    );

endmodule
