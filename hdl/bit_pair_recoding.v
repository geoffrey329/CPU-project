module bit_pair_recoding (
	input [2:0] multiplier_bits,
	input [31:0] multiplicand,
	output reg [31:0] partial_product_out
	);
	reg [31:0] partial_product;
	always @(*) begin
		case(multiplier_bits)//Defining paritial product based off i+1,i+i-1,
			3'b000, 3'b111: partial_product = 32'b0;              // 0 * multiplier
            		3'b001, 3'b010: partial_product = multiplicand;       // +1 * multiplier
           		3'b011:         partial_product = multiplicand << 1;  // +2 * multiplier
            		3'b100:         partial_product = -(multiplicand << 1); // -2 * multiplier
            		3'b101, 3'b110: partial_product = -multiplicand;      // -1 * mulitplier
            		default:        partial_product = 32'b0;              // Should not happen
        	endcase
		partial_product_out = partial_product;
	end
endmodule
