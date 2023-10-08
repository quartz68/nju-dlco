module mux42(
    input [7:0] x,
    input [1:0] y,
    output [1:0] f );

    MuxKeyWithDefault #(4, 2, 2) i0 (f, y, 2'b0, {
        2'b00, x[1:0],
        2'b01, x[3:2],
        2'b10, x[5:4],
        2'b11, x[7:6]
    });

endmodule
