`timescale 1ns / 1ps



module RegisterFile(
    input wire CLK,
    input wire WE3,
    input wire [4:0] A1, A2, A3,
    input wire [31:0] WD3,
    output wire [31:0] RD1, RD2
);
    reg [31:0] registers [0:31];

    assign RD1 = registers[A1];
    assign RD2 = registers[A2];

    always @(posedge CLK) begin
        if (WE3) begin
            registers[A3] <= WD3;
        end
    end
endmodule
