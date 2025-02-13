`timescale 1ns/10ps
module datapath_tb;
	reg PCout, Zlowout, MDRout, R3out, R7out; // add any other signals to see in your simulation
	reg MARin, ZHIin, ZLOin, PCin, MDRin, IRin, Yin;
	reg IncPC, Read, AND, RF_enable;
	reg [3:0] RF_write;
	reg Clock;
	reg [31:0] Mdatain;
 
parameter Default = 4?b0000, Reg_load1a = 4?b0001, Reg_load1b = 4?b0010, Reg_load2a = 4?b0011,
	Reg_load2b = 4?b0100, Reg_load3a = 4?b0101, Reg_load3b = 4?b0110, T0 = 4?b0111,
	T1 = 4?b1000, T2 = 4?b1001, T3 = 4?b1010, T4 = 4?b1011, T5 = 4?b1100;
reg [3:0] Present_state = Default;
 
 
Datapath DUT(
.PC_select(PCout),
.ZLO_select(Zlowout),
.MDR_select(MDRout),
.R3_select(R3out),
.R7_select(R7out),
 
.MAR_select_write(MARin),
.ZHI_select_write(ZHIin),
.ZLO_select_write(ZLOin),
.MDR_select_write(MDRin)
.Y_select_write(Yin),
 
.Increment_PC(IncPC),//_____add
.Read(Read),//______________add
.AND_select(AND),
.RF_write(RF_write),
.RF_enable(RF_enable),
.clk(Clock),
.MDR_data(Mdatain)
);
 
 
initial
	begin
		Clock=0;
		forever #10 Clock =~Clock
end
 
 
always @(posedge Clock)
	begin
		case (Present_state)
			Default		:	Present State = RegLoad1a;
			Regload1a	:	Present State = RegLoad1b;
			Regload1b	:	Present State = RegLoad2a;
			Regload2a	:	Present State = RegLoad2b;
			Regload2b	:	Present State = RegLoad3a;
			Regload3a	:	Present State = RegLoad3b;
			Regload3b	:	Present State = T0;
			T0		:	Present State = T1;
			T1		:	Present State = T2;
			T2		:	Present State = T3;
			T3		:	Present State = T4;
			T4		:	Present State = T5;
		endcase
	end
 
always @(Present_state)
	begin
		case(Present_state)
			Default: begin
				PCout<=0; Zlowout<=0,MDRout<0;
				R3out<0; R7out<=0; MARin<=0; Zin<=;
				PCin<=0; MDRin<=0; IRin<=0; Yin<=0;
				IncPC<=0; Read<=0; AND<=0;
				RF_write<=4'b0000; RF_enable<1'b0 Mdatain<=32'h00000000
			end
 
			Reg_load1a: begin
				Mdatain <= 32?h00000022;
				Read = 0; MDRin = 0; // the first zero is there for completeness
				Read <= 1; MDRin <= 1; // Took out #10 for '1', as it may not be needed
				#15 Read <= 0; MDRin <= 0; // for your current implementation
			end
 
			Reg_load1b: begin
				MDRout <= 1; RF_write<=4'b0011; RF_enable<=1'b1; 
				#15 MDRout <= 0; RF_enable<1'b0; // initialize R3 with the value 0x22
			end
 
			Reg_load2a: begin
				Mdatain <= 32?h00000024;
				Read <= 1; MDRin <= 1;
				#15 Read <= 0; MDRin <= 0;
			end
 
			Reg_load2b: begin
				MDRout <= 1; RF_write<=4'b0111; RF_enable<=1'b1; 
				#15 MDRout <= 0; RF_enable<=1'b0; // initialize R7 with the value 0x24
			end
 
			Reg_load3a: begin
				Mdatain <= 32?h00000028;
				Read <= 1; MDRin <= 1;
				#15 Read <= 0; MDRin <= 0;
			end
 
			Reg_load3b: begin
				MDRout <= 1; RF_write<=4'b0100; RF_enable<=1'b1;
				#15 MDRout <= 0; RF_enable<=1'b0; // initialize R4 with the value 0x28
			end
 
			T0: begin // see if you need to de-assert these signals
				PCout <= 1; MARin <= 1; IncPC <= 1; Zin <= 1;
			end
 
			T1: begin
				Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
				Mdatain <= 32?h2A2B8000; // opcode for ?and R4, R3, R7?
			end
 
			T2: begin
				MDRout <= 1; IRin <= 1;
			end
 
			T3: begin
				R3out <= 1; Yin <= 1;
			end
 
			T4: begin
				R7out <= 1; AND <= 1; Zin <= 1;
			end
 
			T5: begin
				Zlowout <= 1; R4in <= 1;
			end
 
		endcase
	end
endmodule