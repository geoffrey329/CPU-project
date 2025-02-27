module array_divider #(parameter WIDTH) (
    input [31:0] dividend, 
    input [31:0] divisor,
    output [31:0] quotient, 
    output [31:0] remainder
);
    reg [63:0] dividend_ext;
    reg [63:0] divisor_ext;
    reg [63:0] remainder_ext;
    reg [31:0] quotient_reg;
    integer i;

    always @(*) begin
        dividend_ext = {32'b0, dividend}; // Extend the dividend to 64 bits
        divisor_ext = {divisor, 32'b0}; // Align the divisor
        quotient_reg = 32'b0;
        remainder_ext = 64'b0;

        for (i = 0; i < 32; i = i + 1) begin
            remainder_ext = remainder_ext << 1; // Shift left the remainder
            remainder_ext[0] = dividend_ext[63]; // Bring down the next bit of the dividend
            dividend_ext = dividend_ext << 1; // Shift left the dividend
            if (remainder_ext >= divisor_ext) begin
                remainder_ext = remainder_ext - divisor_ext; // Subtract the divisor from the remainder
                quotient_reg[31-i] = 1'b1; // Set the quotient bit
            end
        end
    end

    assign quotient = quotient_reg;
    assign remainder = remainder_ext[31:0];

endmodule
