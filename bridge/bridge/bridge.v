`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:05:29 12/28/2014 
// Design Name: 
// Module Name:    bridge 
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
module bridge(
	input GPS_I0,
	input GPS_I1,
	input GPS_Q0,
	input GPS_Q1,
	input GPS_CLK_16_368,
	input MCU_CLK_25_000,
	output MCU_SCK,
	output MCU_SS,
	output MCU_MOSI);

	wire GPS_CLK_4_092;
	
	reg [3:0] gps_data = 4'h0;
	
	// New data is available
	reg go_newdata     = 1'b0;
	
	// CLK_DIV4: Simple clock Divide by 4
	//             CoolRunner-II
	// Xilinx HDL Language Template, version 14.7
	
	CLK_DIV4 CLK_DIV4_inst (
		.CLKDV(GPS_CLK_4_092),    // Divided clock output
		.CLKIN(GPS_CLK_16_368)     // Clock input
	);
	// End of CLK_DIV4_inst instantiation
	
	// Instantiate bridge state machine here
	bridge_sm bridge_sm_inst (
		.GPS_I0(GPS_I0),
		.GPS_I1(GPS_I1),
		.GPS_Q0(GPS_Q0),
		.GPS_Q1(GPS_Q1),
		.MCU_CLK_25_000(GPS_CLK_25_000),
		.MCU_SCK(MCU_SCK),
		.MCU_SS(MCU_SS),
		.MCU_SS(MCU_MOSI)
	);
	
	// Instantiate edge detection here
	
	
endmodule
