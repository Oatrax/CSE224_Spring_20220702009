`timescale 1ns / 1ps

module TopModule(
    input BtnL, BtnR,    
    input clk,
    output [6:0] seg,  
    output [4:0] an         
);
    wire [31:0] Result;
    wire [4:0] PC;
    wire [31:0] instruction;
    wire [2:0] ALUop;
    wire [4:0] rs, rt, rd;
    wire [31:0] imm;
    wire isImm, isBranch, isJump;
    wire [31:0] regData1, regData2, aluInput2;
    wire [31:0] aluResult;
    wire branchTaken;

    // Branch condition
    assign branchTaken = (regData1 == regData2);
    // Branch/Jump target is the immediate value
    wire [31:0] branchTarget = imm;
    wire [31:0] jumpTarget = imm;

    ProgramCounter pc_module (
        .RESET(BtnR),
        .CTRL(BtnL),
        .isBranch(isBranch),
        .isJump(isJump),
        .branchTaken(branchTaken),
        .branchTarget(branchTarget),
        .jumpTarget(jumpTarget),
        .PC(PC)
    );

    InstructionMemory imem (
        .PC(PC),
        .instruction(instruction)
    );

    InstructionDecoder decoder (
        .instruction(instruction),
        .ALUop(ALUop),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .imm(imm),
        .isImm(isImm),
        .isBranch(isBranch),
        .isJump(isJump)
    );

    RegisterFile regfile (
        .CLK(clk),
        .WE3(1'b1),       
        .A1(rs),
        .A2(rt),
        .A3(rd),
        .WD3(aluResult),
        .RD1(regData1),
        .RD2(regData2)
    );

    assign aluInput2 = isImm ? imm : regData2;

    ALU alu (
        .opcode(ALUop),
        .in1(regData1),
        .in2(aluInput2),
        .result(aluResult)
    );

    assign Result = aluResult;
    
    Display display (
        .CLK(clk),
        .value(Result[15:0]),
        .seg(seg),
        .an(an)
    );
endmodule