`timescale 1ns / 1ps
module signed_alu4 (
    input [3:0] A,
    input [3:0] B,
    input [2:0] ALUControl,
    output reg [3:0] Result,
    output reg N,
    output reg Z,
    output reg C,
    output reg V
);

    assign N = Result[3];
    assign Z = ~(| Result);

    always @(*) begin
        case (ALUControl)
            3'b000: begin
                {C, Result} = A + B;
                V = (A[3] == B[3]) && (A[3] != Result[3]);
            end
            3'b001: begin
                {C, Result} = A - B;
                V = (A[3] != B[3]) && (A[3] != Result[3]);
            end
            3'b010: Result = ~A;
            3'b011: Result = A & B;
            3'b100: Result = A | B;
            3'b101: Result = A ^ B;
            3'b110: Result = (A<B) ? 1 : 0;
            3'b111: Result = (A==B) ? 1 : 0;
        endcase
    end

endmodule