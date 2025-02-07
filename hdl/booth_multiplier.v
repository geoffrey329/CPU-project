module booth_multiplier #(parameter WIDTH) (
	input [WIDTH-1:0] multiplicand,
	input [WIDTH-1:0] multiplier,
	output [2*WIDTH-1:0] product			
	);
	//Implementing bit pair recoding along with carry save addition in a tree configuration. 16 bit recoded mulitplier => 5 stages CSA plus one stage CLA
	
	//extend the muliplier to 
	
	wire [31:0] pp0;
	wire [31:0] pp1;
	wire [31:0] pp2;
	wire [31:0] pp3;
	wire [31:0] pp4;
	wire [31:0] pp5;
	wire [31:0] pp6;
	wire [31:0] pp7;
	wire [31:0] pp8;
	wire [31:0] pp9;
	wire [31:0] pp10;
	wire [31:0] pp11;
	wire [31:0] pp12;
	wire [31:0] pp13;
	wire [31:0] pp14;
	wire [31:0] pp15;
	wire [63:0] intermediate_product;
	//Create all partial products.
	bit_pair_recoding partial_product_0 ({multiplier[1:0], 1'b0}, multiplicand, pp0); //Here conatonate the invisible 0 to the right of bit 0. To get bit recoding
	bit_pair_recoding partial_product_1 (multiplier[3:1], multiplicand, pp1);
	bit_pair_recoding partial_product_2 (multiplier[5:3], multiplicand, pp2);
	bit_pair_recoding partial_product_3 (multiplier[7:5], multiplicand, pp3);
	bit_pair_recoding partial_product_4 (multiplier[9:7], multiplicand, pp4);
	bit_pair_recoding partial_product_5 (multiplier[11:9], multiplicand, pp5);
	bit_pair_recoding partial_product_6 (multiplier[13:11], multiplicand, pp6);
	bit_pair_recoding partial_product_7 (multiplier[15:13], multiplicand, pp7);
	bit_pair_recoding partial_product_8 (multiplier[17:15], multiplicand, pp8);
	bit_pair_recoding partial_product_9 (multiplier[19:17], multiplicand, pp9);
	bit_pair_recoding partial_product_10 (multiplier[21:19], multiplicand, pp10);
	bit_pair_recoding partial_product_11 (multiplier[23:21], multiplicand, pp11);
	bit_pair_recoding partial_product_12 (multiplier[25:23], multiplicand, pp12);
	bit_pair_recoding partial_product_13 (multiplier[27:25], multiplicand, pp13);
	bit_pair_recoding partial_product_14 (multiplier[29:27], multiplicand, pp14);
	bit_pair_recoding partial_product_15 (multiplier[31:29], multiplicand, pp15);
	
	//level # 0
	wire [63:0] sum_0_0, carry_0_0;
    	wire [63:0] sum_0_1, carry_0_1;
    	wire [63:0] sum_0_2, carry_0_2;
    	wire [63:0] sum_0_3, carry_0_3;
    	wire [63:0] sum_0_4, carry_0_4;
	
	carry_save_adder #(.WIDTH(64)) CSA_0_0 (.ppA({{32{pp0[31]}}, pp0}), .ppB({{30{pp1[31]}}, pp1, 2'b0}), .ppC({{28{pp2[31]}}, pp2, 4'b0}), .sum(sum_0_0), .carry(carry_0_0)); // Add correct sign extension to each term
	carry_save_adder #(.WIDTH(64)) CSA_0_1 (.ppA({{26{pp3[31]}}, pp3, 6'b0}), .ppB({{24{pp4[31]}}, pp4, 8'b0}), .ppC({{22{pp5[31]}}, pp5,10'b0}), .sum(sum_0_1), .carry(carry_0_1)); // Each PP requires 2 less than the one before, add 2 more zeros to the end
	carry_save_adder #(.WIDTH(64)) CSA_0_2 (.ppA({{20{pp6[31]}}, pp6, 12'b0}), .ppB({{18{pp7[31]}}, pp7, 14'b0}), .ppC({{16{pp8[31]}}, pp8,16'b0}), .sum(sum_0_2), .carry(carry_0_2));
	carry_save_adder #(.WIDTH(64)) CSA_0_3 (.ppA({{14{pp9[31]}}, pp9, 18'b0}), .ppB({{12{pp10[31]}}, pp10, 20'b0}), .ppC({{10{pp11[31]}}, pp11, 22'b0}), .sum(sum_0_3), .carry(carry_0_3));
	carry_save_adder #(.WIDTH(64)) CSA_0_4 (.ppA({{8{pp12[31]}}, pp12, 24'b0}), .ppB({{6{pp13[31]}}, pp13, 26'b0}), .ppC({{4{pp14[31]}}, pp14, 28'b0}), .sum(sum_0_4), .carry(carry_0_4));

	
	//level # 1
	wire [63:0] sum_1_0, carry_1_0;
    	wire [63:0] sum_1_1, carry_1_1;
    	wire [63:0] sum_1_2, carry_1_2;
    	
	carry_save_adder #(.WIDTH(64)) CSA_1_0 (.ppA(sum_0_0),.ppB({carry_0_0[62:0],1'b0}),.ppC(sum_0_1),.sum(sum_1_0),.carry(carry_1_0)); //Make sure that the carry's have an offset of 1, shifted to the left by 1.
	carry_save_adder #(.WIDTH(64)) CSA_1_1 (.ppA({carry_0_1[62:0],1'b0}),.ppB(sum_0_2),.ppC({carry_0_2[62:0],1'b0}),.sum(sum_1_1),.carry(carry_1_1));
	carry_save_adder #(.WIDTH(64)) CSA_1_2 (.ppA(sum_0_3),.ppB({carry_0_3[62:0],1'b0}),.ppC(sum_0_4),.sum(sum_1_2),.carry(carry_1_2));
	
	//level # 2
	wire [63:0] sum_2_0, carry_2_0;
    	wire [63:0] sum_2_1, carry_2_1;
	
	carry_save_adder #(.WIDTH(64)) CSA_2_0 (.ppA(sum_1_0),.ppB({carry_1_0[62:0],1'b0}),.ppC(sum_1_1),.sum(sum_2_0),.carry(carry_2_0));
	carry_save_adder #(.WIDTH(64)) CSA_2_1 (.ppA({carry_1_1[62:0],1'b0}),.ppB(sum_1_2),.ppC({carry_1_2[62:0],1'b0}),.sum(sum_2_1),.carry(carry_2_1));
	
	//level # 3
	wire [63:0] sum_3_0, carry_3_0;
    	wire [63:0] sum_3_1, carry_3_1;

	carry_save_adder #(.WIDTH(64)) CSA_3_0 (.ppA(sum_2_0),.ppB({carry_2_0[62:0],1'b0}),.ppC(sum_2_1),.sum(sum_3_0),.carry(carry_3_0));
	carry_save_adder #(.WIDTH(64)) CSA_3_1 (.ppA({carry_2_1[62:0],1'b0}),.ppB({carry_0_4[62:0],1'b0}),.ppC({pp15,32'b0}),.sum(sum_3_1),.carry(carry_3_1));
	
	//level # 4
	wire [63:0] sum_4_0, carry_4_0;
	
	carry_save_adder #(.WIDTH(64)) CSA_4_0 (.ppA(sum_3_0),.ppB({carry_3_0[62:0],1'b0}),.ppC(sum_3_1),.sum(sum_4_0),.carry(carry_4_0));
	
	//level # 5
	wire [63:0] sum_5_0, carry_5_0;
	
	carry_save_adder #(.WIDTH(64)) CSA_5_0 (.ppA(sum_4_0),.ppB({carry_4_0[62:0],1'b0}),.ppC({carry_3_1[62:0],1'b0}),.sum(sum_5_0),.carry(carry_5_0));
	
	//level # 6
	//implement 64 bit carry lookaged adder
	
	CLA_64 carry_adder (.A(sum_5_0), .B({carry_5_0[62:0],1'b0}), .carry_in(1'b0), .result(intermediate_product), .carry_out());
		
	assign product = intermediate_product;
endmodule

