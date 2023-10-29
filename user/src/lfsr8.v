module lfsr8 (
    input clk,
    input reset,
    input clear,
    output [7:0] out
);

    wire feedback;
    assign feedback = out[4] ^ out[3] ^ out[2] ^ out[0];
    
    right_shift_reg8 u_right_shift_reg8(
        .clk   	( clk      ),
        .clear 	( clear    ),
        .ld    	( reset    ),
        .Din   	( 8'hFF    ),
        .shift 	( 1        ),
        .Sin   	( feedback ),
        .Dout  	( out     ),
        .Sout  	(  )
    );
    
endmodule