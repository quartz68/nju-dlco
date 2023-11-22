// `include "seg_display/ASCII_to_7seg.v"
// `include "luts/PS2_to_ASCII.v"
// `include "PS2_keyboard/PS2_keyboard_controller.v"
// `include "PS2_keyboard/PS2_keyboard_model.v"
// `include "luts/hex_code_to_ASCII.v"
`timescale 1ns / 1ps
module PS2_display_sim;

/* parameter */
parameter [31:0] clock_period = 10;

/* ps2_keyboard interface signals */
reg clk,clrn;
wire [7:0] data;
wire ready,overflow;
wire kbd_clk, kbd_data;
reg nextdata_n;

PS2_keyboard_model model(
    .ps2_clk(kbd_clk),
    .ps2_data(kbd_data)
);

PS2_keyboard_controller inst(
    .clk(clk),
    .clrn(clrn),
    .ps2_clk(kbd_clk),
    .ps2_data(kbd_data),
    .data(data),
    .ready(ready),
    .nextdata_n(nextdata_n),
    .overflow(overflow)
);

// outports wire
wire [47:0] 	ascii;
wire [7:0] ascii_code;

PS2_to_ASCII u_PS2_to_ASCII(
    .ps2  	( data   ),
    .ascii 	( ascii_code )
);

hex_code_to_ASCII PS2_code_to_ASCII_lower(
    .hex_code 	( data[3:0]  ),
    .ascii    	( ascii[7:0]     )
);

hex_code_to_ASCII PS2_code_to_ASCII_upper(
    .hex_code 	( data[7:4]  ),
    .ascii    	( ascii[15:8]     )
);

hex_code_to_ASCII ASCII_code_to_ASCII_lower(
    .hex_code 	( ascii_code[3:0]  ),
    .ascii    	( ascii[23:16]     )
);

hex_code_to_ASCII ASCII_code_to_ASCII_upper(
    .hex_code 	( ascii_code[7:4]  ),
    .ascii    	( ascii[31:24]     )
);

// outports wire
wire [41:0] 	hseg;

ASCII_to_7seg ASCII_to_7seg_1(
    .code 	( ascii[7:0]  ),
    .en   	( 1'b1   ),
    .hseg 	( hseg[6:0]   )
);

ASCII_to_7seg ASCII_to_7seg_2(
    .code 	( ascii[15:8]  ),
    .en   	( 1'b1   ),
    .hseg 	( hseg[13:7]   )
);

ASCII_to_7seg ASCII_to_7seg_3(
    .code 	( ascii[23:16]  ),
    .en   	( 1'b1   ),
    .hseg 	( hseg[20:14]   )
);

ASCII_to_7seg ASCII_to_7seg_4(
    .code 	( ascii[31:24]  ),
    .en   	( 1'b1   ),
    .hseg 	( hseg[27:21]   )
);

initial begin /* clock driver */
    clk = 0;
    forever
        #(clock_period/2) clk = ~clk;
end

initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    clrn = 1'b0;  #20;
    clrn = 1'b1;  #20;
    model.kbd_sendcode(8'h1C); // press 'A'
    #20 nextdata_n =1'b0; #20 nextdata_n =1'b1;//read data
    model.kbd_sendcode(8'hF0); // break code
    #20 nextdata_n =1'b0; #20 nextdata_n =1'b1; //read data
    model.kbd_sendcode(8'h1C); // release 'A'
    #20 nextdata_n =1'b0; #20 nextdata_n =1'b1; //read data
    model.kbd_sendcode(8'h1B); // press 'S'
    #20 model.kbd_sendcode(8'h1B); // keep pressing 'S'
    #20 model.kbd_sendcode(8'h1B); // keep pressing 'S'
    model.kbd_sendcode(8'hF0); // break code
    model.kbd_sendcode(8'h1B); // release 'S'
    #20;
    $stop;
end

endmodule