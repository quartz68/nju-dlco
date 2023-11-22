`timescale 1ps / 1ps
module PS2_display (
    input kbd_clk,
    input kbd_data,
    output [41:0] hseg
);

/* parameter */
parameter [31:0] clock_period = 2;

/* ps2_keyboard interface signals */
reg clk,clrn;
wire [7:0] data;
wire ready,overflow;
reg nextdata_n;
reg [7:0] scan_code;
reg [7:0] count;

// wire kbd_clk, kbd_data;

// PS2_keyboard_model model(
//     .ps2_clk(kbd_clk),
//     .ps2_data(kbd_data)
// );


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
    .ps2  	( scan_code   ),
    .ascii 	( ascii_code )
);

hex_code_to_ASCII PS2_code_to_ASCII_lower(
    .hex_code 	( scan_code[3:0]  ),
    .ascii    	( ascii[7:0]     )
);

hex_code_to_ASCII PS2_code_to_ASCII_upper(
    .hex_code 	( scan_code[7:4]  ),
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

hex_code_to_ASCII count_to_ASCII_lower(
    .hex_code 	( count[3:0]  ),
    .ascii    	( ascii[39:32]     )
);

hex_code_to_ASCII count_to_ASCII_upper(
    .hex_code 	( count[7:4]  ),
    .ascii    	( ascii[47:40]     )
);

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

ASCII_to_7seg ASCII_to_7seg_5(
    .code 	( ascii[39:32]  ),
    .en   	( 1'b1   ),
    .hseg 	( hseg[34:28]   )
);

ASCII_to_7seg ASCII_to_7seg_6(
    .code 	( ascii[47:40]  ),
    .en   	( 1'b1   ),
    .hseg 	( hseg[41:35]   )
);

initial begin
    count = 8'b0;
end

initial begin /* clock driver */
    clk = 0;
    clrn = 1'b0;  #20;
    clrn = 1'b1;  #20;
    forever
        #(clock_period/2) clk = ~clk;
end

reg [7:0] scan_code_prev;

always @(negedge clk) begin
    // $dumpfile("dump.vcd");
    // $dumpvars;
    // $display("ps2_clk %b", kbd_clk);
    if(ready == 1'b1) begin
        nextdata_n <= 1'b0;
        if (data != 8'hf0) scan_code <= data;
    end
    else begin
        nextdata_n <= 1'b1;
    end

    if (scan_code != scan_code_prev) begin
        $display("scan_code %h", scan_code);
        count <= count + 8'b1;
    end
    scan_code_prev <= scan_code;
end

endmodule