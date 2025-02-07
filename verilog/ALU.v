module ALU #(parameter WIDTH)(
    input wire [WIDTH-1:0] registerA,
    input wire [WIDTH-1:0] registerB,
    input wire [12:0] ALU_instruc,
    output reg [WIDTH-1:0] result,
    output reg [WIDTH-1:0] result_hi,
    output wire carryOut
);
    parameter AND = 13'b0000000000001;
    parameter OR = 13'b0000000000010;
    parameter ADD = 13'b0000000000100;
    parameter SUB  = 13'b0000000001000;
    parameter MUL = 13'b0000000010000;
    parameter DIV = 13'b0000000100000;
    parameter SHIFTRIGHTLOGIC = 13'b0000001000000;
    parameter SHIFTRIGHTARITH = 13'b0000010000000;
    parameter SHIFTLEFTLOGIC = 13'b0000100000000;
    parameter ROTATERIGHT = 13'b0001000000000;
    parameter ROTATELEFT = 13'b0010000000000;
    parameter NEG = 13'b0100000000000;
    parameter NOT = 13'b1000000000000;

    wire [WIDTH-1:0] add_result;
    wire [WIDTH-1:0] and_result;
    wire [WIDTH-1:0] or_result;
    wire [WIDTH-1:0] shift_right_result;
    wire [WIDTH-1:0] shift_left_result;
    wire [2*WIDTH-1:0] mul_result;
        
    assign and_result = registerA & registerB;
    assign or_result = registerA | registerB;
    //change this
    CLA #(.WIDTH(WIDTH)) adder_module(
        .registerA(registerA),//0 for neg, a otherwise
        .registerB(ALU_instruc[2] ? registerB : ~registerB),//negate for neg for subtraction
        .carryIn(ALU_instruc[3]),//neg or subtract, using control signals
        .result(add_result),
        .carry_out(carryOut)
    );
    right_shift #(.WIDTH(WIDTH),.SHIFT(6)) r_shift(
	.in(registerA),
	.shift_amount(registerB),
	.mode(ALU_instruc[9:6]),
	.out(shift_right_result)
    );
    left_shift #(.WIDTH(WIDTH),.SHIFT(6)) l_shift(
	.in(registerA),
	.shift_amount(registerB),
	.mode(ALU_instruc[8]),
	.out(shift_left_result)
    );
    booth_multiplier #(.WIDTH(WIDTH)) mul(
	.multiplicand(registerA),
	.multiplier(registerB),
	.product(mul_result)
    );
    always @(*) begin
        case(ALU_instruc)
            ADD: result = add_result;
	    SUB: result = add_result;
            AND: result = and_result;
            OR : result = or_result;
	    ROTATERIGHT: result = shift_right_result;
	    SHIFTRIGHTLOGIC: result = shift_right_result;
            SHIFTRIGHTARITH: result = shift_right_result;
	    ROTATELEFT: result = shift_left_result;
	    SHIFTLEFTLOGIC: result = shift_left_result;
	    MUL: begin
			    result = mul_result[31:0];
			    result_hi = mul_result[63:32]; 
			    end
            default: begin
		     result = 32'b0;
		     result_hi = 32'b0;
		     end
        endcase
    end
endmodule

/* ALU Operations (by select index)
input AND_select, 0000000000001
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
*/
