`timescale 1ns / 1ps

module BinaryToBCD(
    input  [15:0] binary,
    output reg [3:0] digit0, // Ones
    output reg [3:0] digit1, // Tens
    output reg [3:0] digit2, // Hundreds
    output reg [3:0] digit3, // Thousands
    output reg [3:0] digit4  // Ten-thousands
);
    integer i;
    reg [27:0] shift;

    always @(*) begin
        // Initialize shift register
        shift = 28'b0;
        shift[15:0] = binary;

        // Perform shift-add-3 algorithm (Double Dabble)
        for (i = 0; i < 16; i = i + 1) begin
            if (shift[19:16] >= 5)
                shift[19:16] = shift[19:16] + 3;
            if (shift[23:20] >= 5)
                shift[23:20] = shift[23:20] + 3;
            if (shift[27:24] >= 5)
                shift[27:24] = shift[27:24] + 3;

            shift = shift << 1;
        end

        digit4 = shift[27:24]; // Ten-thousands
        digit3 = shift[23:20]; // Thousands
        digit2 = shift[19:16]; // Hundreds
        digit1 = shift[15:12]; // Tens
        digit0 = shift[11:8];  // Ones
    end
endmodule
