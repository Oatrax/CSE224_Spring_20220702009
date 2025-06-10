`timescale 1ns / 1ps

module InstructionDecoder(
    input [31:0] instruction,
    output reg [2:0] ALUop,
    output reg [4:0] rs, rt, rd,
    output reg [31:0] imm,
    output reg isImm,
    output reg isBranch,
    output reg isJump
);
    always @(*) begin
        rs = instruction[25:21];
        rt = instruction[20:16];
        rd = instruction[15:11];
        imm = {{21{instruction[10]}}, instruction[10:0]}; 
        isBranch = 0;
        isJump = 0;
        
        case (instruction[31:26])
            6'b000000, 6'b000001: begin
                ALUop = 3'b000; isImm = 0; // NOOP
            end
            6'b010000: begin
                ALUop = 3'b010; isImm = 0; // ADD
            end
            6'b011000: begin
                ALUop = 3'b011; isImm = 0; // SUB
            end
            6'b100000: begin
                ALUop = 3'b100; isImm = 0; // SHIFTL
            end
            6'b101000: begin
                ALUop = 3'b101; isImm = 0; // SHIFTR
            end
            6'b110000: begin
                ALUop = 3'b110; isImm = 1; // ADDI
            end
            6'b111000: begin
                ALUop = 3'b111; isImm = 1; // SUBI
            end
            6'b001000: begin  // BEQ
                ALUop = 3'b000; isImm = 0; isBranch = 1;
            end
            6'b000010: begin  // J
                ALUop = 3'b000; isImm = 0; isJump = 1;
            end
            default: begin
                ALUop = 3'b000; isImm = 0;
            end
        endcase
    end
endmodule