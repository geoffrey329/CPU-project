module register (

	input clock, clear, enable, 
	input [31:0] DataIn,
	output wire [31:0] DataOut
);

reg [31:0]q;
initial q = 32'b0;

always @ (posedge clock) begin 

	if (clear) begin
		q <= 32'b0;
	end
	else if (enable) begin
		q <= DataIn;
	end
end

assign DataOut = q[31:0];

endmodule
