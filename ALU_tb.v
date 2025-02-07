`timescale 1ns/10ps
module ALU_tb;
    // Testbench variables
    reg [31:0] registerA;
    reg [31:0] registerB;
    reg [12:0] ALU_select; //change to add one hot encoding for each type of ALU operation
    wire [31:0] result;
    wire [31:0] result_hi;
    wire carryOut;

    // Instantiate the ALU
    ALU #(.WIDTH(32)) uut (
        .registerA(registerA),
        .registerB(registerB),
        .ALU_instruc(ALU_select),
        .result(result),
	.result_hi(result_hi),
        .carryOut(carryOut)
    );

    initial begin
        // Test ADD operation
        registerA = 32'hFFFFFFFF; // 5
        registerB = 32'hFFFFFFFF; // 3
        ALU_select = 13'b0000000000100;        // ADD operation
        #10;                      // Wait for result
	
	// Test SUB operation
        registerA = 32'h0000000A; // 15
        registerB = 32'h0000000F; // 10
        ALU_select = 13'b0000000001000;        // sub operation
        #10;  
        
        // Test OR operation
        registerA = 32'h0000000F; // 15
        registerB = 32'h000000F0; // 240
        ALU_select = 13'b0000000000010;        // OR operation
        #10;                      // Wait for result

        // Test AND operation
        registerA = 32'hFFFFFFFF; // 15
        registerB = 32'hFFFFFFFF; // 240
        ALU_select = 13'b0000000000001;        // AND operation
        #10;                      // Wait for result
	// Test ROTATERIGHT operation
        registerA = 32'h00000001;
        registerB = 32'h0000000A;
        ALU_select = 13'b0001000000000;
        #10;                      

        // Test SHIFTRIGHTLOGIC operation
        registerA = 32'h1;
        registerB = 32'h0000000A;
        ALU_select = 13'b0000001000000;
        #10;                      

        // Test SHIFTRIGHTARITH operation
        registerA = 32'h80000001;
        registerB = 32'h0000000A;
        ALU_select = 13'b0000010000000;
        #10;
	
	// Test left logical shift
        registerA = 32'hFFFFFFFF;
        registerB = 5'h0A;// Shift by 10 bits
        ALU_select = 13'b0000100000000; // Logical shift
        #10;

        // Test left rotate
        registerA = 32'h80000001;
        registerB = 32'h0000000A;// Rotate by 10 bits
        ALU_select = 13'b0010000000000;// Rotate
        #10;
	
	//Test mul operation
	registerA = 32'h00054351;
	registerB = 32'h00004351;
	ALU_select = 13'b0000000010000;//mulitplication
	#10;
    end

endmodule