`timescale 1ns / 10ps

module datapath_TB();

// Testbench signals
reg clk;
reg clr;

// Register Select Signals Read
reg R0_select;
reg R1_select;
reg R2_select;
reg PC_select;
reg MDR_select;
reg InPort_select;
reg HI_select;
reg LO_select;
reg ZHI_select;
reg ZLO_select;
reg C_select;

// Register Select Signals Write
reg PC_select_write;
reg MDR_select_write;
reg MAR_select_write;
reg InPort_select_write;
reg OutPort_select_write;
reg HI_select_write;
reg LO_select_write;
reg ZHI_select_write;
reg ZLO_select_write;
reg C_select_write;

reg RF_enable;
reg [3:0] RF_write;

reg RY_select_write;

// ALU Select Signals
reg AND_select;
reg OR_select;
reg ADD_select;
reg SUB_select;
reg MUL_select;
reg DIV_select;
reg SHR_select;
reg SHRA_select;
reg SHL_select;
reg ROR_select;
reg ROL_select;
reg NEG_select;
reg NOT_select;

// Data from and to Memory/Input Output
reg [31:0] MDR_data;
reg [31:0] IO_data_in;
wire [31:0] IO_data_out;
wire [31:0] MAR_data;

// Instantiate the datapath module
datapath uut (
    .clk(clk), 
    .clr(clr), 
    .R0_select(R0_select), 
    .R1_select(R1_select), 
    .R2_select(R2_select),
    .PC_select(PC_select), 
    .MDR_select(MDR_select), 
    .InPort_select(InPort_select), 
    .HI_select(HI_select), 
    .LO_select(LO_select), 
    .ZHI_select(ZHI_select), 
    .ZLO_select(ZLO_select), 
    .C_select(C_select), 
    .PC_select_write(PC_select_write), 
    .MDR_select_write(MDR_select_write), 
    .MAR_select_write(MAR_select_write), 
    .InPort_select_write(InPort_select_write), 
    .OutPort_select_write(OutPort_select_write), 
    .HI_select_write(HI_select_write), 
    .LO_select_write(LO_select_write), 
    .ZHI_select_write(ZHI_select_write), 
    .ZLO_select_write(ZLO_select_write), 
    .C_select_write(C_select_write), 
	 .RY_select_write(RY_select_write), 
    .RF_enable(RF_enable), 
    .RF_write(RF_write), 
    .AND_select(AND_select), 
    .OR_select(OR_select), 
    .ADD_select(ADD_select), 
    .SUB_select(SUB_select), 
    .MUL_select(MUL_select), 
    .DIV_select(DIV_select), 
    .SHR_select(SHR_select), 
    .SHRA_select(SHRA_select), 
    .SHL_select(SHL_select), 
    .ROR_select(ROR_select), 
    .ROL_select(ROL_select), 
    .NEG_select(NEG_select), 
    .NOT_select(NOT_select), 
    .MDR_data(MDR_data), 
    .IO_data_in(IO_data_in), 
    .IO_data_out(IO_data_out), 
    .MAR_data(MAR_data)
);

// Clock generation
initial begin
    clk = 0;
    forever #10 clk = ~clk; // 100 MHz clock
end

// Test stimulus
initial begin
    // Initialize inputs
    clr = 1;
    R0_select = 0;
    R1_select = 0;
    R2_select = 0;
    PC_select = 0;
    MDR_select = 0;
    InPort_select = 0;
    HI_select = 0;
    LO_select = 0;
    ZHI_select = 0;
    ZLO_select = 0;
    C_select = 0;
    
    PC_select_write = 0;
    MDR_select_write = 0;
    MAR_select_write = 0;
    InPort_select_write = 0;
    OutPort_select_write = 0;
    HI_select_write = 0;
    LO_select_write = 0;
    ZHI_select_write = 0;
    ZLO_select_write = 0;
    C_select_write = 0;

    RF_enable = 0;
    RF_write = 0;

    RY_select_write = 0;

    AND_select = 0;
    OR_select = 0;
    ADD_select = 0;
    SUB_select = 0;
    MUL_select = 0;
    DIV_select = 0;
    SHR_select = 0;
    SHRA_select = 0;
    SHL_select = 0;
    ROR_select = 0;
    ROL_select = 0;
    NEG_select = 0;
    NOT_select = 0;

    IO_data_in = 32'h00000000;

    // Apply reset
    #5 clr = 0;
	 
    // Load data into the IO data and capture in inport register
    #20 InPort_select_write = 1; IO_data_in = 32'h00000005; 
	 #20 InPort_select_write = 0; 
	 
	 // Load data from inport onto bus and place into R0
	#20 InPort_select = 1;
	#20 RF_write = 4'b0001; RF_enable = 1;
	#20 RF_enable = 0; RF_write = 4'b0000;
	#20 InPort_select = 0;
	
	 // Load data into the IO data, place on bus and then capture in inport register
   #20 InPort_select_write = 1; IO_data_in = 32'h00000003; 
	#20 InPort_select_write = 0; 
	
	 // Load data from inport onto bus and place into R0
	#20 InPort_select = 1;
	#20 RF_write = 4'b0010; RF_enable = 1;
	#20 RF_enable = 0; RF_write = 4'b0000;
	#20 InPort_select = 0;
		
	//Putting R1 into RY for operation
	#20 R1_select = 1;
	#20 RY_select_write = 1; 
	#20 R1_select= 0; RY_select_write = 0;
	 
	//Putting R2 on the bus for operation
	#20 R2_select = 1;
	
	    // AND operation
   #20 AND_select = 1;
   #20 ZHI_select_write = 1; ZLO_select_write = 1;
   #20 ZHI_select_write = 0; ZLO_select_write = 0; AND_select = 0;
    

end
endmodule
