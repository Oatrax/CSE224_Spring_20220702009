`timescale 1ns / 1ps

module lab4 (
    input wire CLK,
    input wire WE3,
    input wire [4:0] A1, A2, A3,
    input wire [1:0] opcode,
    output wire [31:0] ALU_result
);

    wire [31:0] RD1, RD2;

    // Register File instance
    RegisterFile regfile_inst (
        .CLK(CLK),
        .WE3(WE3),
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .WD3(ALU_result),
        .RD1(RD1),
        .RD2(RD2)
    );

    // ALU instance
    ALU alu_inst (
        .opcode(opcode),
        .in1(RD1),
        .in2(RD2),
        .result(ALU_result)
    );

endmodule