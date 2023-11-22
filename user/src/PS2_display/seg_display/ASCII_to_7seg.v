`timescale 1ps / 1ps
module ASCII_to_7seg(
    input [7:0] code,
    input en,
    output reg [6:0] hseg
);
	always @ (*) begin
        if (en) begin
            hseg = 7'd0;
            // $display("ASCIIcode %b", code);
            case (code)
                //	A
                8'h41 : hseg[3] = 1;
                //	a
                8'h61 : hseg[3] = 1;
                //	B
                8'h42 : begin hseg[0] = 1; hseg[1] = 1; end
                //	b
                8'h62 : begin hseg[0] = 1; hseg[1] = 1; end
                //	C
                8'h43 : begin hseg[1] = 1; hseg[2] = 1; hseg[6] = 1; end
                //	c
                8'h63 : begin hseg[1] = 1; hseg[2] = 1; hseg[6] = 1; end
                //	D
                8'h44 : begin hseg[0] = 1; hseg[5] = 1; end
                //	D
                8'h64 : begin hseg[0] = 1; hseg[5] = 1; end
                //	E
                8'h45 : begin hseg[1] = 1; hseg[2] = 1; end
                //	e
                8'h65 : begin hseg[1] = 1; hseg[2] = 1; end
                //	F
                8'h46 : begin hseg[1] = 1; hseg[2] = 1; hseg[3] = 1; end
                //	f
                8'h66 : begin hseg[1] = 1; hseg[2] = 1; hseg[3] = 1; end
                //	G
                8'h47 : begin hseg[4] = 1; end
                //	g
                8'h67 : begin hseg[4] = 1; end
                //	H
                8'h48 : begin hseg[0] = 1; hseg[3] = 1; end
                //	h
                8'h68 : begin hseg[0] = 1; hseg[3] = 1; end
                //	I
                8'h49 : begin hseg[4] = 1; hseg[5] = 1; end
                //	I
                8'h69 : begin hseg[4] = 1; hseg[5] = 1; end
                //	J
                8'h4A : begin hseg[0] = 1; hseg[5] = 1; hseg[6] = 1; end
                //	j
                8'h6A : begin hseg[0] = 1; hseg[5] = 1; hseg[6] = 1; end
                //	K
                8'h4B : begin hseg[0] = 1; hseg[3] = 1; end
                //	k
                8'h6B : begin hseg[0] = 1; hseg[3] = 1; end
                //	L
                8'h4C : begin hseg[0] = 1; hseg[1] = 1; hseg[2] = 1; hseg[6] = 1; end
                //	l
                8'h6C : begin hseg[0] = 1; hseg[1] = 1; hseg[2] = 1; hseg[6] = 1; end
                //	M
                8'h4D : begin hseg[1] = 1; hseg[5] = 1; hseg[3] = 1; hseg[6] = 1; end
                //	m
                8'h6D : begin hseg[1] = 1; hseg[5] = 1; hseg[3] = 1; hseg[6] = 1; end
                //	N
                8'h4E : begin hseg[0] = 1; hseg[1] = 1; hseg[3] = 1; hseg[5] = 1; end
                //	n
                8'h6E : begin hseg[0] = 1; hseg[1] = 1; hseg[3] = 1; hseg[5] = 1; end
                //	O
                8'h4F : begin hseg[6] = 1; end
                //	o
                8'h6F : begin hseg[6] = 1; end
                //	P
                8'h50 : begin hseg[2] = 1; hseg[3] = 1; end
                //	p
                8'h70 : begin hseg[2] = 1; hseg[3] = 1; end
                //	Q
                8'h51 : begin hseg[3] = 1; hseg[4] = 1; end
                //	q
                8'h71 : begin hseg[3] = 1; hseg[4] = 1; end
                //	R
                8'h52 : begin hseg[0] = 1; hseg[1] = 1; hseg[2] = 1; hseg[3] = 1; hseg[5] = 1; end
                //	r
                8'h72 : begin hseg[0] = 1; hseg[1] = 1; hseg[2] = 1; hseg[3] = 1; hseg[5] = 1; end
                //	S
                8'h53 : begin hseg[1] = 1; hseg[4] = 1; end
                //	s
                8'h73 : begin hseg[1] = 1; hseg[4] = 1; end
                //	T
                8'h54 : begin hseg[0] = 1; hseg[1] = 1; hseg[2] = 1; end
                //	t
                8'h74 : begin hseg[0] = 1; hseg[1] = 1; hseg[2] = 1; end
                //	U
                8'h55 : begin hseg[0] = 1; hseg[6] = 1; end
                //	u
                8'h75 : begin hseg[0] = 1; hseg[6] = 1; end
                //	V
                8'h56 : begin hseg[0] = 1; hseg[1] = 1; hseg[5] = 1; hseg[6] = 1; end
                //	v
                8'h76 : begin hseg[0] = 1; hseg[1] = 1; hseg[5] = 1; hseg[6] = 1; end
                //	W
                8'h57 : begin hseg[0] = 1; hseg[2] = 1; hseg[4] = 1; hseg[6] = 1; end
                //	w
                8'h77 : begin hseg[0] = 1; hseg[2] = 1; hseg[4] = 1; hseg[6] = 1; end
                //	X
                8'h58 : begin hseg[0] = 1; hseg[3] = 1; end
                //	x
                8'h78 : begin hseg[0] = 1; hseg[3] = 1; end
                //	Y
                8'h59 : begin hseg[0] = 1; hseg[4] = 1; end
                //	y
                8'h79 : begin hseg[0] = 1; hseg[4] = 1; end
                //	Z
                8'h5A : begin hseg[2] = 1; hseg[5] = 1; end
                //	z
                8'h7A : begin hseg[2] = 1; hseg[5] = 1; end
                //	0
                8'h30 : hseg[6] = 1;
                //	1
                8'h31 : begin hseg[0] = 1; hseg[3] = 1; hseg[4] = 1; hseg[5] = 1; hseg[6] = 1; end
                //	2
                8'h32 : begin hseg[2] = 1; hseg[5] =1 ; end
                //	3
                8'h33 : begin hseg[4] = 1; hseg[5] = 1; end
                //	4
                8'h34 : begin hseg[0] = 1; hseg[3] = 1; hseg[4] = 1; end
                //	5
                8'h35 : begin hseg[1] = 1; hseg[4] = 1; end
                //	6
                8'h36 : hseg[1] = 1;
                //	7
                8'h37 : begin hseg[3] = 1; hseg[4] = 1; hseg[5] = 1; hseg[6] = 1; end
                //	8
                8'h38 : hseg = 7'b0000000;
                //	9
                8'h39 : hseg[4] = 1;
                //	turn all the bits off by default
                default: hseg = 7'b1111111;
            endcase
            // $display("HexSegment %b", hseg);
        end
	end
endmodule