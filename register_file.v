module register_file (
  input clk, clr,
  input wr_enable,
  input [3:0] wr_address,
  input [31:0] bus_data_in,
  
  output wire [31:0] R0_out,
  output wire [31:0] R1_out,
  output wire [31:0] R2_out,
  output wire [31:0] R3_out,
  output wire [31:0] R4_out,
  output wire [31:0] R5_out,
  output wire [31:0] R6_out,
  output wire [31:0] R7_out,
  output wire [31:0] R8_out,
  output wire [31:0] R9_out,
  output wire [31:0] R10_out,
  output wire [31:0] R11_out,
  output wire [31:0] R12_out,
  output wire [31:0] R13_out,
  output wire [31:0] R14_out,
  output wire [31:0] R15_out
);
 
wire [15:0] wr_en;
assign wr_en = (wr_enable && (wr_address < 16)) ? (16'b1 << wr_address) : 16'b0;
 
register R0 (clk, clr, wr_en[0],  bus_data_in, R0_out);
register R1 (clk, clr, wr_en[1],  bus_data_in, R1_out);
register R2 (clk, clr, wr_en[2],  bus_data_in, R2_out);
register R3 (clk, clr, wr_en[3],  bus_data_in, R3_out);
register R4 (clk, clr, wr_en[4],  bus_data_in, R4_out);
register R5 (clk, clr, wr_en[5],  bus_data_in, R5_out);
register R6 (clk, clr, wr_en[6],  bus_data_in, R6_out);
register R7 (clk, clr, wr_en[7],  bus_data_in, R7_out);
register R8 (clk, clr, wr_en[8],  bus_data_in, R8_out);
register R9 (clk, clr, wr_en[9],  bus_data_in, R9_out);
register R10(clk, clr, wr_en[10], bus_data_in, R10_out);
register R11(clk, clr, wr_en[11], bus_data_in, R11_out);
register R12(clk, clr, wr_en[12], bus_data_in, R12_out);
register R13(clk, clr, wr_en[13], bus_data_in, R13_out);
register R14(clk, clr, wr_en[14], bus_data_in, R14_out);
register R15(clk, clr, wr_en[15], bus_data_in, R15_out);
 
endmodule
