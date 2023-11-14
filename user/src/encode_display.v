`timescale 1ns / 1ps
module encode_display (
    input [7:0] x,
    input en,
    output reg [6:0] h
);

    wire [2:0] code;
    wire en_display;
    
    priority_encode83 u_priority_encode83(
        .x  	( x    ),
        .en 	( en   ),
        .y  	( code )
    );

    assign en_display = (x == 8'b00000000) ? 0 : en;
    
    bcd7seg u_bcd7seg(
        .b  	( code       ),
        .en 	( en_display ),
        .h  	( h          )
    );
    
endmodule
