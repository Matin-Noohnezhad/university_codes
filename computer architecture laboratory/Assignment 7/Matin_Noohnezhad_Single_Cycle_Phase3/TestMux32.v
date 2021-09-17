`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:40:04 07/04/2018
// Design Name:   Mux_32
// Module Name:   D:/term 5/Computer Architecture Laboratory/week 12 - Single Cycle CPU_Phase3/Matin_Noohnezhad_Single_Cycle_Phase3/TestMux32.v
// Project Name:  Matin_Noohnezhad_Single_Cycle_Phase3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Mux_32
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestMux32;

	// Inputs
	reg [31:0] input1;
	reg [31:0] input2;
	reg op;

	// Outputs
	wire [31:0] out;

	// Instantiate the Unit Under Test (UUT)
	Mux_32 uut (
		.input1(input1), 
		.input2(input2), 
		.op(op), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		input1 = 0;
		input2 = 0;
		op = 0;

		// Wait 100 ns for global reset to finish
		#100;
		input1 = 32'b100;
		input2 = 32'b111;
		op =1;
        
		// Add stimulus here

	end
      
endmodule

