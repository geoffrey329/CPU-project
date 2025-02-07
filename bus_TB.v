`timescale 1ns / 10ps

module bus_TB;
   
    reg clk, clr;

    // For Register File
    reg [31:0] R0_mux;
    reg [31:0] R1_mux;
    reg [31:32] R2_mux;
    reg [31:0] R3_mux;
    reg [31:0] R4_mux;
    reg [31:0] R5_mux;
    reg [31:0] R6_mux;
    reg [31:0] R7_mux;
    reg [31:0] R8_mux;
    reg [31:0] R9_mux;
    reg [31:0] R10_mux;
    reg [31:0] R11_mux;
    reg [31:0] R12_mux;
    reg [31:0] R13_mux;
    reg [31:0] R14_mux;
    reg [31:0] R15_mux;

    reg R0_select;
    reg R1_select;
    reg R2_select;
    reg R3_select;
    reg R4_select;
    reg R5_select;
    reg R6_select;
    reg R7_select;
    reg R8_select;
    reg R9_select;
    reg R10_select;
    reg R11_select;
    reg R12_select;
    reg R13_select;
    reg R14_select;
    reg R15_select;

    // For Registers in Datapath
    reg [31:0] PC_mux;
    reg [31:0] MDR_mux;
    reg [31:0] InPort_mux;
    reg [31:0] HI_mux;
    reg [31:0] LO_mux;
    reg [31:0] ZHI_mux;
    reg [31:0] ZLO_mux;
    reg [31:0] C_mux;

    reg PC_select;
    reg MDR_select;
    reg InPort_select;
    reg HI_select;
    reg LO_select;
    reg ZHI_select;
    reg ZLO_select;
    reg C_select;

    // Output to other devices
    wire [31:0] Bus_Mux_out;

    // Instantiate the bus module
    bus uut(
        .clk(clk), .clr(clr), 
        .R0_mux(R0_mux), .R1_mux(R1_mux), .R2_mux(R2_mux), .R3_mux(R3_mux),
        .R4_mux(R4_mux), .R5_mux(R5_mux), .R6_mux(R6_mux), .R7_mux(R7_mux),
        .R8_mux(R8_mux), .R9_mux(R9_mux), .R10_mux(R10_mux), .R11_mux(R11_mux),
        .R12_mux(R12_mux), .R13_mux(R13_mux), .R14_mux(R14_mux), .R15_mux(R15_mux),
        .R0_select(R0_select), .R1_select(R1_select), .R2_select(R2_select), .R3_select(R3_select),
        .R4_select(R4_select), .R5_select(R5_select), .R6_select(R6_select), .R7_select(R7_select),
        .R8_select(R8_select), .R9_select(R9_select), .R10_select(R10_select), .R11_select(R11_select),
        .R12_select(R12_select), .R13_select(R13_select), .R14_select(R14_select), .R15_select(R15_select),
        .PC_mux(PC_mux), .MDR_mux(MDR_mux), .InPort_mux(InPort_mux), .HI_mux(HI_mux),
        .LO_mux(LO_mux), .ZHI_mux(ZHI_mux), .ZLO_mux(ZLO_mux), .C_mux(C_mux),
        .PC_select(PC_select), .MDR_select(MDR_select), .InPort_select(InPort_select),
        .HI_select(HI_select), .LO_select(LO_select), .ZHI_select(ZHI_select),
        .ZLO_select(ZLO_select), .C_select(C_select),
        .Bus_Mux_out(Bus_Mux_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #50 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Initialize inputs
        clr = 1'b0;
        R0_mux = 32'h00000001;
        R1_mux = 32'h00000002;
        R2_mux = 32'h00000003;
        R3_mux = 32'h00000004;
        R4_mux = 32'h00000005;
        R5_mux = 32'h00000006;
        R6_mux = 32'h00000007;
        R7_mux = 32'h00000008;
        R8_mux = 32'h00000009;
        R9_mux = 32'h0000000A;
        R10_mux = 32'h0000000B;
        R11_mux = 32'h0000000C;
        R12_mux = 32'h0000000D;
        R13_mux = 32'h0000000E;
        R14_mux = 32'h0000000F;
        R15_mux = 32'h00000010;

        PC_mux = 32'h11111111;
        MDR_mux = 32'h22222222;
        InPort_mux = 32'h33333333;
        HI_mux = 32'h44444444;
        LO_mux = 32'h55555555;
        ZHI_mux = 32'h66666666;
        ZLO_mux = 32'h77777777;
        C_mux = 32'h88888888;

        // Initialize select signals
        R0_select = 1'b0;
        R1_select = 1'b0;
        R2_select = 1'b0;
        R3_select = 1'b0;
        R4_select = 1'b0;
        R5_select = 1'b0;
        R6_select = 1'b0;
        R7_select = 1'b0;
        R8_select = 1'b0;
        R9_select = 1'b0;
        R10_select = 1'b0;
        R11_select = 1'b0;
        R12_select = 1'b0;
        R13_select = 1'b0;
        R14_select = 1'b0;
        R15_select = 1'b0;
        PC_select = 1'b0;
        MDR_select = 1'b0;
        InPort_select = 1'b0;
        HI_select = 1'b0;
        LO_select = 1'b0;
        ZHI_select = 1'b0;
        ZLO_select = 1'b0;
        C_select = 1'b0;

        // Apply test cases
        #100 R0_select = 1'b1; // Select R0
		  #100 R0_select = 1'b0;
		  
		  #125 R5_select = 1'b1;
    

        // Finish simulation
        #1000 $finish;
		  		  
    end
	 
	
endmodule
