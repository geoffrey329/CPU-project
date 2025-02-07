module right_shift #(parameter WIDTH, parameter SHIFT) (
	input wire [WIDTH-1:0] in,
	input wire [SHIFT:0] shift_amount,//possibility for 32 bits, so require 32 shift values. 5 only gets to 31
	input wire [3:0]mode,//0001=Logical,0010=arithmetic, 1000 =rotate right
	output reg [WIDTH-1:0] out
	//output wire fall_off //add reg?
	);
	
	integer i;
	reg [WIDTH-1:0] temp;

	always @(*) begin
		temp = in;
		
		for(i=0;i<shift_amount;i=i+1) begin
			case (mode)
				4'b0001:temp = {1'b0, temp[WIDTH-1:1]};
				4'b0010: temp = {temp[WIDTH-1], temp[WIDTH-1:1]};
				4'b1000: temp = {temp[0], temp[WIDTH-1:1]};
				default: temp = temp; //Throw an error return same thing
			endcase
		end
		out = temp;
	end
endmodule