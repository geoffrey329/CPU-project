module CLA #(parameter WIDTH) (
	input wire [WIDTH-1:0] registerA, 
	input wire [WIDTH-1:0] registerB, 
	input wire carryIn,
	output wire [WIDTH-1:0] result,
	output wire carry_out
	); 
	//Carry Lookahead Adder
	wire [WIDTH-1:0] sum_acc; //Dont keep carry out saved in a seperate place holder.
	wire [WIDTH-1:0] propagate_block;
	wire [WIDTH-1:0] generate_block;
	wire [WIDTH:0] carry_in_block;//32 blocks including carry in and carry out.

	assign carry_in_block[0] = carryIn;//Carry in for block 0 is always 0.
	
	//Instantiate 32 full adders here,
	genvar z;
	generate //full_adder full_adder_module;
		for(z = 0; z<WIDTH; z = z+1) begin: adder_generator
			full_adder full_adder_module
			(
				.A(registerA[z]),
				.B(registerB[z]),
				.Cin(carry_in_block[z]),
				.sum(sum_acc[z]),
				.Cout()//Carry out not used in CLA. 
			);
		end
	endgenerate
	//use loops to determine the generate or propagate terms. 
	genvar i;
	generate
		for(i = 0;i<WIDTH;i=i+1)begin: propogate_generator
			assign generate_block[i] = registerA[i]&registerB[i]; 
			assign propagate_block[i] = registerA[i]|registerB[i];
			assign carry_in_block[i+1] = generate_block[i]|(propagate_block[i] & carry_in_block[i]);//Recursive search through the propagate block
		end
	endgenerate
	
	assign result = sum_acc;
	assign carry_out = carry_in_block[WIDTH];//Carry in for 32 block is carry out bit
endmodule