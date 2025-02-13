module MDR (
    input wire clk, clr, read,
    input wire [31:0] BusMuxOut,
    input wire [31:0] Mdatain,
    output wire [31:0] MDR_out;
);
 
    register  MDR_register (clk, clr, 1'b1, read ? Mdatain : BusMuxOut, MDR_out);
 
endmodule
