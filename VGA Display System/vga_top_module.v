`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:37:44 08/02/2016 
// Design Name: 
// Module Name:    vga_top_module 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module vga_top_module(input clk_main,
		input rst, 
		input switch0,switch1,switch2,
		output  red_o, green_o, blue_o,
		output hsync_o,vsync_o
    );
wire [10:0] hcount;
wire [9:0] vcount;
//clk_gen clk_generator(.clk(clk_main),
//							 .rst(rst),
//							 .clk1(clk)
//							  );
rgb1 vga_interface(.clk(clk_main),
						 .rst(rst),
						 .switch({switch2,switch1,switch0}),
						 .red(red_o),
						 .green(green_o),
						 .blue(blue_o),
						 .hsync(hsync_o),
						 .vsync(vsync_o),
						 .hcount1(hcount),
						 .vcount1(vcount)
						 );
 

endmodule
