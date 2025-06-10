`timescale 1ns / 1ps



module ALU(
    input  [2:0] opcode,
    input  [31:0] in1,
    input  [31:0] in2,
    output reg [31:0] result
);
    always @(*) begin
        case (opcode)
            3'b010: result = in1 + in2;           // ADD
            3'b011: result = in1 - in2;           // SUB
            3'b100: result = in1 << in2;          // SHIFTL
            3'b101: result = in1 >> in2;          // SHIFTR
            3'b110: result = in1 + in2;           // ADDI
            3'b111: result = in1 - in2;           // SUBI
            default: result = 32'b0;              // NOOP
        endcase
    end
endmodule

