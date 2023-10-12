module priority_encode83 (
    input [7:0] x,
    input en,
    output reg [2:0] y
);

    always @(x or en) begin
        if (en) begin
            assign y[0] = ~x[6] & (~x[4] & ~x[2] & x[1] | ~x[4] & x[3] | x[5]) | x[7];
            assign y[1] = ~x[5] & ~x[4] & (x[2] | x[3]) | x[6] | x[7];
            assign y[2] = x[4] | x[5] | x[6] | x[7];
        end
        else y = 3'b000;
    end

endmodule

module priority_encode83_alt (
    input [7:0] x,
    input en,
    output reg [2:0] y
);

    integer i;
    always @(x or en) begin
        if (en) begin
            y = 0;
            for( i = 0; i <= 7; i = i+1)
                if(x[i] == 1)  y = i[1:0];
        end
        else  y = 0;
    end

endmodule
