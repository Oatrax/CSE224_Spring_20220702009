`timescale 1ns / 1ps

module Display(
    input  CLK,
    input  [15:0] value,
    output reg [4:0] an,
    output  [6:0] seg
);
    wire [3:0] d0, d1, d2, d3, d4;
    reg [3:0] current_digit;
    reg [2:0] digit_sel = 0;

    // Convert to BCD
    BinaryToBCD bcd_converter (
        .binary(value),
        .digit0(d0),
        .digit1(d1),
        .digit2(d2),
        .digit3(d3),
        .digit4(d4)
    );

    always @(posedge CLK) begin
        digit_sel <= digit_sel + 1;
    end

    always @(*) begin
        case (digit_sel)
            3'b000: begin an = 4'b11110; current_digit = d0; end
            3'b001: begin an = 4'b11101; current_digit = d1; end
            3'b010: begin an = 4'b11011; current_digit = d2; end
            3'b011: begin an = 4'b10111; current_digit = d3; end
            3'b100: begin an = 4'b01111; current_digit = d4; end
            default: begin an = 4'b11111; current_digit = 4'b0000; end
        endcase
    end

    SevenSegment decoder (
        .digit(current_digit),
        .seg(seg)
    );
endmodule

