// ==========================================
// conv_core.v  --  single 3x3 convolution core
// ==========================================
module conv_core #(parameter DATA_W = 8, parameter ACC_W = 32)(
    input  clk,
    input  rstn,
    input  valid_in,
    input  [DATA_W*9-1:0]  window_in,
    input  [DATA_W*9-1:0]  weight_in,
    output reg             valid_out,
    output reg signed [ACC_W-1:0] acc_out
);
    integer i;
    reg signed [DATA_W-1:0] pix [0:8];
    reg signed [DATA_W-1:0] wt  [0:8];
    reg signed [ACC_W-1:0] sum;

    always @(*) begin
        for (i=0;i<9;i=i+1) begin
            pix[i] = window_in[(DATA_W*(9-i))-1 -: DATA_W];
            wt[i]  = weight_in[(DATA_W*(9-i))-1 -: DATA_W];
        end
    end

    always @(*) begin
        sum = 0;
        for (i=0;i<9;i=i+1)
            sum = sum + pix[i]*wt[i];
    end

    always @(posedge clk) begin
        if (!rstn) begin
            acc_out   <= 0;
            valid_out <= 1'b0;
        end else if (valid_in) begin
            acc_out   <= sum;
            valid_out <= 1'b1;
        end else begin
            valid_out <= 1'b0;
        end
    end
endmodule
