`timescale 1ns / 1ps

module ProgramCounter(
    input RESET,
    input CTRL,
    input isBranch,
    input isJump,
    input branchTaken,
    input [31:0] branchTarget,
    input [31:0] jumpTarget,
    output reg [4:0] PC
);
    always @(CTRL, RESET) begin
        if (RESET)
            PC <= 5'b0;
        else if (CTRL) begin
            if (isJump)
                PC <= jumpTarget[4:0];
            else if (isBranch && branchTaken)
                PC <= branchTarget[4:0];
            else
                PC <= PC + 1;
        end
    end
endmodule