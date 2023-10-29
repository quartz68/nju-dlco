module right_shift_reg8 (
    input clk,
    input clear,
    input ld,
    input [7:0] Din,
    input shift,
    input Sin,
    output reg [7:0] Dout,
    output Sout
);
    assign Sout = Dout[0];

    always @(posedge clk) begin
        if (clear) Dout <= 0;
        else if (ld) Dout <= Din;
        else if (shift) Dout <= {  Sin, Dout[7:1] };
    end

endmodule