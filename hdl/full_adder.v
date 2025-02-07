module full_adder (
	input wire A,
	input wire B,
	input wire Cin,
	output wire sum,
	output wire Cout
);//Implemented in Carry lookahead adder, so we must ignore the Cout since will be generated later. 
	
	assign sum = A^B^Cin;
	assign Cout = A&B | A&Cin | B&Cin;
endmodule
