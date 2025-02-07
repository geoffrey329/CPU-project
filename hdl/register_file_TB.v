`timescale 1ns / 10ps

module register_file_TB;

    reg clk, clr, wr_enable;
    reg [3:0] wr_address;
    reg [31:0] bus_data_in;
    wire [31:0] R0_out, R1_out, R2_out, R3_out, R4_out, R5_out, R6_out, R7_out;
    wire [31:0] R8_out, R9_out, R10_out, R11_out, R12_out, R13_out, R14_out, R15_out;

    // Instantiate the register_file module
    register_file uut (
        .clk(clk), .clr(clr), .wr_enable(wr_enable), .wr_address(wr_address), .bus_data_in(bus_data_in),
        .R0_out(R0_out), .R1_out(R1_out), .R2_out(R2_out), .R3_out(R3_out), .R4_out(R4_out), .R5_out(R5_out),
        .R6_out(R6_out), .R7_out(R7_out), .R8_out(R8_out), .R9_out(R9_out), .R10_out(R10_out), .R11_out(R11_out),
        .R12_out(R12_out), .R13_out(R13_out), .R14_out(R14_out), .R15_out(R15_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #50 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Initialize inputs
        clr = 1'b1; // Assert clear
        wr_enable = 1'b0;
        wr_address = 4'b0000;
        bus_data_in = 32'h00000000;

        // Deassert clear after some time
        #100 clr = 1'b0;

        // Test case 1: Write to R0
        #100 wr_enable = 1'b1; wr_address = 4'b0000; bus_data_in = 32'd16;
        #100 wr_enable = 1'b0;

        // Test case 2: Write to R1
        #100 wr_enable = 1'b1; wr_address = 4'b0001; bus_data_in = 32'd18;
        #100 wr_enable = 1'b0;

        // Test case 3: Write to R2
        #100 wr_enable = 1'b1; wr_address = 4'b0000; bus_data_in = 32'd26;
        #100 wr_enable = 1'b0;

        // Test case 4: Write to R3
        #100 wr_enable = 1'b1; wr_address = 4'b0011; bus_data_in = 32'd69;
        #100 wr_enable = 1'b0;

        // Add more test cases as needed

        // Finish simulation
        #1000 $finish;
    end
endmodule
