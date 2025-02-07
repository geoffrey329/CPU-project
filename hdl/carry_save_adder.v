module carry_save_adder #(parameter WIDTH) (
	input  [WIDTH-1:0] ppA,
	input  [WIDTH-1:0] ppB,
	input  [WIDTH-1:0] ppC,
	output wire [WIDTH-1:0] sum,
	output wire [WIDTH-1:0] carry
	);
	genvar i;
	generate
        	for (i = 0; i < 64; i = i + 1) begin: csa_generator
        		full_adder full_adder (.A(ppA[i]), .B(ppB[i]), .Cin(ppC[i]), .sum(sum[i]), .Cout(carry[i]));
        	end
    	endgenerate
endmodule
