`timescale 1ns / 10ps

module register_TB;
   
    // Testbench Signals
    reg clk;
    reg clr;
    reg enable;
    reg [31:0] datain;
    wire [31:0] dataout;
   
    // Instantiate the register module
    register uut(
        .clock(clk),
        .clear(clr),
        .enable(enable),
        .DataIn(datain),
        .DataOut(dataout)
    );

	 initial 
		begin
			clk = 0;
			forever #50 clk = ~clk;
	 end
	 
	 initial 
		begin
        // Initialize inputs
        clr = 1'b0;
        enable = 1'b1;
        datain = 32'h00000000;
		  
		   // Add your test cases here
        // Example: Load data into register
        #75 datain = 32'h1;
		  
		  #150 clr = 1'b1;
		  #155 clr = 1'b0;
		  #155 enable = 1'b0;
		  #160 datain = 32'h12;
		  
		  #250 $finish;
		  

        // Finish simulation
		  		  
    end
	 
	

	
endmodule
