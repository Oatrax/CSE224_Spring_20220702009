`timescale 1ns / 1ps

module InstructionMemory(
    input [4:0] PC,
    output [31:0] instruction
);
    reg [31:0] memory [0:31];

    initial begin
        // ADDI R10, R0, 10
        memory[0] = {6'b110000, 5'd0,5'd0, 5'd10, 11'd10};
        // ADDI R15, R0, 15
        memory[1] = {6'b110000, 5'd0,5'd0, 5'd15, 11'd15};
        // ADD R25, R10, R15
        memory[2] = {6'b010000, 5'd10, 5'd15, 5'd25, 11'b0};
        // SUBI R20, R25, 5
        memory[3] = {6'b111000, 5'd25,5'd0, 5'd20, 11'd5};
        // ADDI R5, R0, 2
        memory[4] = {6'b110000, 5'd0,5'd0, 5'd5, 11'd2};
        // J 12 (PC = 10)
        memory[5] = {6'b000010, 26'd12};
        // SHIFTL R30, R7, R21
        memory[6] = {6'b100000, 5'd7, 5'd21, 5'd30, 11'b0};
        // NOP
        memory[7] = 32'b0;
        // NOP
        memory[8] = 32'b0;
        // NOP
        memory[9] = 32'b0;
        // NOP
        memory[10] = 32'b0;
        // NOP
        memory[11] = 32'b0;
        // ADDI R4, R0, 4
        memory[12] = {6'b110000, 5'd0,5'd0, 5'd4, 11'd4};
        // ADD R5, R0, R0
        memory[13] = {6'b010000, 5'd0, 5'd0, 5'd5, 11'b0};
        // BEQ R4, R5, 7
        memory[14] = {6'b001000, 5'd4, 5'd5, 16'd7};
        // ADDI R6, R0, 1
        memory[15] = {6'b110000, 5'd0,5'd0, 5'd6, 11'd1};
        // ADDI R7, R0, 1
        memory[16] = {6'b110000, 5'd0,5'd0, 5'd7, 11'd1};
        // ADD R8, R6, R7
        memory[17] = {6'b010000, 5'd6, 5'd7, 5'd8, 11'b0};
        // ADD R6, R7, R0
        memory[18] = {6'b010000, 5'd7, 5'd0, 5'd6, 11'b0};
        // ADD R7, R8, R0
        memory[19] = {6'b010000, 5'd8, 5'd0, 5'd7, 11'b0};
        // ADDI R5, R5, 1
        memory[20] = {6'b110000, 5'd5,5'd0, 5'd5, 11'd1};
        // J 14 (PC = 12)
        memory[21] = {6'b000010, 26'd14};
    end

    assign instruction = memory[PC];
endmodule