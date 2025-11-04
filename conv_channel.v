// ==========================================
// conv_channel.v  --  sum across input channels
// ==========================================
module conv_channel #(parameter DATA_W=8, parameter ACC_W=32, parameter IN_CH=3)(
    input  clk,
    input  rstn,
    input  valid_in,
    input  [IN_CH*DATA_W*9-1:0]  window_in,
    input  [IN_CH*DATA_W*9-1:0]  weight_in,
    output reg  valid_out,
    output reg signed [ACC_W-1:0] acc_sum
);
    wire signed [ACC_W-1:0] acc_ch [0:IN_CH-1];
    wire valid_ch [0:IN_CH-1];
    genvar ch;

    generate
        for (ch=0; ch<IN_CH; ch=ch+1) begin: CH
            conv_core #(.DATA_W(DATA_W),.ACC_W(ACC_W)) CORE (
                .clk(clk),
                .rstn(rstn),
                .valid_in(valid_in),
                .window_in(window_in[(DATA_W*9*(IN_CH-ch))-1 -: (DATA_W*9)]),
                .weight_in(weight_in[(DATA_W*9*(IN_CH-ch))-1 -: (DATA_W*9)]),
                .valid_out(valid_ch[ch]),
                .acc_out(acc_ch[ch])
            );
        end
    endgenerate

    integer j;
    always @(*) begin
        acc_sum = 0;
        for (j=0;j<IN_CH;j=j+1)
            acc_sum = acc_sum + acc_ch[j];
    end

    always @(*) begin
        valid_out = 0;
        for (j=0;j<IN_CH;j=j+1)
            valid_out = valid_out | valid_ch[j];
    end
endmodule
