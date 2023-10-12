module bcd7seg_alt (
  input  [2:0] b,
  input en,
  output reg [6:0] h
);

    always @(b or en) begin
        if (en) begin
            
        end
        else h = 7'b1111111;
    end

endmodule

module bcd7seg (
  input  [2:0] b,
  input en,
  output reg [6:0] h
);

    always @(b or en) begin
        if (en) begin
            case (b)
                3'b000: h = 7'b1000000;
                3'b001: h = 7'b1111001;
                3'b010: h = 7'b0100100;
                3'b011: h = 7'b0110000;
                3'b100: h = 7'b0011001;
                3'b101: h = 7'b0010010;
                3'b110: h = 7'b0000010;
                3'b111: h = 7'b1111000;
                default: h = 7'b1111111;
            endcase
        end
        else h = 7'b1111111;
    end

endmodule
