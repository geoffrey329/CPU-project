module array_divider_cell (
    input mode, // 1 for subtraction, 0 for addition
    input a, b, cin,
    output sum, cout
);
    wire b_xor_mode;
    assign b_xor_mode = b ^ mode; // Flip bit if subtracting
    full_adder FA (.A(a), .B(b_xor_mode), .Cin(cin), .sum(sum), .Cout(cout));
endmodule
