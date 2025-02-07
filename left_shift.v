module left_shift #(parameter WIDTH, parameter SHIFT) (
	input wire [WIDTH-1:0] in,
	input wire [SHIFT:0] shift_amount,
	input wire mode,
	output reg [WIDTH-1:0] out
	);
	integer i;
	reg [WIDTH-1:0] temp; 
	
	always @(*) begin
		temp = in;
		
		for(i=0;i<shift_amount;i=i+1) begin
			temp = mode ?  {temp[WIDTH-2:0],1'b0} : {temp[WIDTH-2:0],temp[WIDTH-1]}; //1 imples SHL, 0 implies ROL
		end
		out = temp;
	end
endmodule