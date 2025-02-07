module CLA_64 (
    input wire [63:0] A, 
    input wire [63:0] B, 
    input wire carry_in,
    output wire [63:0] result,
    output wire carry_out
); 
    wire [31:0] lower_sum; 
    wire [31:0] upper_sum; 
    wire carry_lower_out; 
    wire carry_upper_out;

    // Lower 32-bit Carry Lookahead Adder
    CLA #(.WIDTH(32)) lower_CLA (
        .registerA(A[31:0]), 
        .registerB(B[31:0]), 
        .carryIn(carry_in),
        .result(lower_sum),
        .carry_out(carry_lower_out)
    );

    // Upper 32-bit Carry Lookahead Adder
    CLA #(.WIDTH(32)) upper_CLA (
        .registerA(A[63:32]), 
        .registerB(B[63:32]), 
        .carryIn(carry_lower_out),
        .result(upper_sum),
        .carry_out(carry_upper_out)
    );
    
    assign result = {upper_sum, lower_sum};
    assign carry_out = carry_upper_out;
endmodule

