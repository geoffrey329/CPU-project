module datapath(

input clk, clr,

//Register Select Signals Read, Inputs to the Register File
input R0_select,
input R1_select,
input R2_select,
input R3_select,
input R4_select,
input R5_select,
input R6_select,
input R7_select,
input R8_select,
input R9_select,
input R10_select,
input R11_select,
input R12_select,
input R13_select,
input R14_select,
input R15_select,
input PC_select,
input MDR_select,
input InPort_select,
input HI_select,
input LO_select,
input ZHI_select,
input ZLO_select,
input C_select,

// Register Select Signals Write, RF --> Register File done with one hot encoding
input PC_select_write,
input MDR_select_write,
input MAR_select_write,
input InPort_select_write,
input OutPort_select_write,
input HI_select_write,
input LO_select_write,
input ZHI_select_write,
input ZLO_select_write,
input C_select_write,
input RY_select_write,

input RF_enable,
input [3:0] RF_write,


//ALU Select Signals
input AND_select,
input OR_select,
input ADD_select,
input SUB_select,
input MUL_select,
input DIV_select,
input SHR_select,
input SHRA_select,
input SHL_select,
input ROR_select,
input ROL_select,
input NEG_select,
input NOT_select,

//Data from and to Memory/Input Output
input wire [31:0] MDR_data,
input [31:0] IO_data_in,
output wire [31:0] IO_data_out,
output wire [31:0] MAR_data

);

//Data for the ALU
wire [31:0] bus_RY, RY_ALU_A, bus_ALU_B, ALU_C_ZHI, ALU_C_ZLO, ALU_carry;

//Output Wires from Register File going to the Bus Module
wire [31:0] R0_bus, R1_bus, R2_bus, R3_bus, R4_bus, R5_bus, R6_bus, R7_bus;
wire [31:0] R8_bus, R9_bus, R10_bus, R11_bus, R12_bus, R13_bus, R14_bus, R15_bus;

//Output Wires from other Registers going to the Bus Module
wire [31:0] PC_bus, MDR_bus, HI_bus, LO_bus, ZHI_bus, ZLO_bus, C_bus;
wire [31:0] InPort_bus;
wire [31:0] bus_out;


//Devices

//Writing to Register File and passing all Outputs to be Multiplexed to one in Bus
register_file register_file(

clk, clr, RF_enable, RF_write, bus_out, R0_bus, R1_bus, R2_bus, R3_bus, R4_bus, R5_bus,
R6_bus, R7_bus, R8_bus, R9_bus, R10_bus, R11_bus, R12_bus, R13_bus, R14_bus, R15_bus

);

//Writing to Registers and passing all Outputs to be Multiplexed to one in Bus
register PC(clk, clr, PC_select_write, bus_out, PC_bus);
register MDR(clk, clr, MDR_select_write, bus_out, MDR_bus);//Change to 
register MAR(clk, clr, MAR_select_write, bus_out, MAR_data);
register InPort(clk, clr, InPort_select_write, IO_data_in, InPort_bus);
register OutPort(clk, clr, OutPort_select_write, bus_out, OutPort_bus);
register HI(clk, clr, HI_select_write, bus_out, HI_bus);
register LO(clk, clr, LO_select_write, bus_out, LO_bus);
register ZHI(clk, clr, ZHI_select_write, ALU_C_ZHI, ZHI_bus);
register ZLO(clk, clr, ZLO_select_write, ALU_C_ZLO, ZLO_bus);
register C(clk, clr, C_select_write, bus_out, C_bus);
register RY(clk, clr, RY_select_write, bus_out, RY_ALU_A);

//All Input Data will be Multiplexed and Output will be put on bus_out
bus bus(

clk, clr, 

R0_bus, R1_bus, R2_bus, R3_bus, R4_bus, R5_bus, R6_bus, R7_bus,
R8_bus, R9_bus, R10_bus, R11_bus, R12_bus, R13_bus, R14_bus, R15_bus, 

R0_select, R1_select, R2_select, R3_select, R4_select, R5_select, R6_select, R7_select,
R8_select, R9_select, R10_select, R11_select, R12_select, R13_select, R14_select, R15_select,

PC_bus, MDR_bus, InPort_bus, HI_bus, LO_bus, ZHI_bus, ZLO_bus, C_bus,

PC_select, MDR_select, InPort_select, HI_select, LO_select, ZHI_select, ZLO_select, C_select,

bus_out

);

//Inputs come from Register Y and bus_out
ALU #(.WIDTH(32))alu_datapath (
    .registerA(RY_ALU_A),
    .registerB(bus_out),
    .ALU_instruc({
        NOT_select, NEG_select, ROL_select, ROR_select, SHL_select, SHRA_select, SHR_select, DIV_select, 
		  MUL_select, SUB_select, ADD_select, OR_select, AND_select
    
    }),
    .result(ALU_C_ZLO),
    .result_hi(ALU_C_ZHI),
    .carryOut(ALU_carry) // Corrected to match the ALU module definition
);

endmodule

