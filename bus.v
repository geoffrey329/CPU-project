module bus (

input clk, clr,

//For Register File
input [31:0] R0_mux,
input [31:0] R1_mux,
input [31:0] R2_mux,
input [31:0] R3_mux,
input [31:0] R4_mux,
input [31:0] R5_mux,
input [31:0] R6_mux,
input [31:0] R7_mux,
input [31:0] R8_mux,
input [31:0] R9_mux,
input [31:0] R10_mux,
input [31:0] R11_mux,
input [31:0] R12_mux,
input [31:0] R13_mux,
input [31:0] R14_mux,
input [31:0] R15_mux,

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

//For Registers in Datapath
input [31:0] PC_mux,
input [31:0] MDR_mux,
input [31:0] InPort_mux,
input [31:0] HI_mux,
input [31:0] LO_mux,
input [31:0] ZHI_mux,
input [31:0] ZLO_mux,
input [31:0] C_mux,

input PC_select,
input MDR_select,
input InPort_select,
input HI_select,
input LO_select,
input ZHI_select,
input ZLO_select,
input C_select,

//Output to other devices
output wire [31:0] Bus_Mux_out

);

//Choosing what does on the bus
reg [31:0] temp;

always @ (*) begin

	temp = 32'b0;

	if (R0_select) temp = R0_mux;
	if (R1_select) temp = R1_mux;
	if (R2_select) temp = R2_mux;
	if (R3_select) temp = R3_mux;
	if (R4_select) temp = R4_mux;
	if (R5_select) temp = R5_mux;
	if (R6_select) temp = R6_mux;
	if (R7_select) temp = R7_mux;
	if (R8_select) temp = R8_mux;
	if (R9_select) temp = R9_mux;
	if (R10_select) temp = R10_mux;
	if (R11_select) temp = R11_mux;
	if (R12_select) temp = R12_mux;
	if (R13_select) temp = R13_mux;
	if (R14_select) temp = R14_mux;
	if (R15_select) temp = R15_mux;
	if (PC_select) temp = PC_mux;
	if (MDR_select) temp = MDR_mux;
	if (InPort_select) temp = InPort_mux;
	if (HI_select) temp = HI_mux;
	if (LO_select) temp = LO_mux;
	if (ZHI_select) temp = ZHI_mux;
	if (ZLO_select) temp = ZLO_mux;
	if (C_select) temp = C_mux;
end

assign Bus_Mux_out = temp;

endmodule
