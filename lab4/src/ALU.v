`timescale 1ns / 1ps



module ALU(
    input wire [1:0] opcode,
    input wire [31:0] in1,
    input wire [31:0] in2,
    output reg [31:0] result
);
    always @(*) begin
        case (opcode)
            2'b00: result = in1 + in2;          // ADD
            2'b01: result = in1 - in2;          // SUB
            2'b10: result = in1 << in2;         // SHIFTL
            2'b11: result = in1 >> in2;         // SHIFTR
            default: result = 32'b0;
        endcase
    end
endmodule
