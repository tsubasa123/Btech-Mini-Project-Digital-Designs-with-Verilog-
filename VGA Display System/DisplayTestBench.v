`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:44:19 08/02/2016
// Design Name:   vga_top_module
// Module Name:   D:/vga_disply/vga_tb.v
// Project Name:  vga_disply
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vga_top_module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module vga_tb;

	// Inputs
	reg clk_main;
	reg rst;
	reg switch0;
	reg switch1;
	reg switch2;

	// Outputs
	wire red_o;
	wire green_o;
	wire blue_o;
	wire hsync_o;
	wire vsync_o;

	// Instantiate the Unit Under Test (UUT)
	vga_top_module uut (
		.clk_main(clk_main), 
		.rst(rst), 
		.switch0(switch0), 
		.switch1(switch1), 
		.switch2(switch2), 
		.red_o(red_o), 
		.green_o(green_o), 
		.blue_o(blue_o), 
		.hsync_o(hsync_o), 
		.vsync_o(vsync_o)
	);
	always #20 clk_main = ~clk_main;

	initial begin
		// Initialize Inputs
		clk_main = 0;
		rst = 1;
		switch0 = 0;
		switch1 = 0;
		switch2 = 0;
		
		repeat (2)@(posedge clk_main);
     rst = 0;
		switch0 = 0;
		switch1 = 0;
		switch2 = 0;
		
		repeat (100)@(posedge clk_main);
     rst = 0;
		switch0 = 1;
		switch1 = 0;
		switch2 = 0;
		repeat (100)@(posedge clk_main);
     rst = 0;
		switch0 = 0;
		switch1 = 1;
		switch2 = 0;
		repeat (100)@(posedge clk_main);
     rst = 0;
		switch0 = 0;
		switch1 = 0;
		switch2 = 1;

	end
      
endmodule

