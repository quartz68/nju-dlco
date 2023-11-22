`timescale 1ps / 1ps
module hex_code_to_ASCII(
    input [3:0] hex_code,
    output reg [7:0] ascii
);

always @(hex_code) begin
    case (hex_code)
        4'h1: ascii <= 8'h31;	// 1
        4'ha: ascii <= 8'h61;	// a
        4'h2: ascii <= 8'h32;	// 2
        4'hc: ascii <= 8'h63;	// c
        4'hd: ascii <= 8'h64;	// d
        4'he: ascii <= 8'h65;	// e
        4'h4: ascii <= 8'h34;	// 4
        4'h3: ascii <= 8'h33;	// 3
        4'hf: ascii <= 8'h66;	// f
        4'h5: ascii <= 8'h35;	// 5
        4'hb: ascii <= 8'h62;	// b
        4'h6: ascii <= 8'h36;	// 6
        4'h7: ascii <= 8'h37;	// 7
        4'h8: ascii <= 8'h38;	// 8
        4'h0: ascii <= 8'h30;	// 0
        4'h9: ascii <= 8'h39;	// 9
        default: ascii <= 8'h00;
    endcase
end

endmodule