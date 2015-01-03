`timescale 1ns / 1ps

module bridge(
		input RESET,
		input GPS_I0,
		input GPS_I1,
		input GPS_Q0,
		input GPS_Q1,
		input GPS_CLK_16_368,
		input MCU_CLK_25_000,
		output MCU_SCK,
		output MCU_SS,
		output MCU_MOSI);

wire datardy;

wire gps_i0_sync;
wire gps_i1_sync;
wire gps_q0_sync;
wire gps_q1_sync;

wire GPS_CLK_4_092;

assign MCU_SS   = ~datardy;
assign MCU_SCK  = gps_i0_sync & gps_i1_sync & gps_q0_sync & gps_q1_sync;
assign MCU_MOSI = 1'b1;

// Instantiate edge detection here
asynch_edge_detect asynch_edge_detect_inst(
		.SYNC_CLK_IN(MCU_CLK_25_000),
		.ASYNC_IN(GPS_CLK_4_092),
		.DETECT_OUT(datardy)
);

synchronizer synch_inst_i0 (
	.asynch_input(GPS_I0),
	.synch_clk(MCU_CLK_25_000),
	.synch_output(gps_i0_sync)
);
	
synchronizer synch_inst_i1 (
	.asynch_input(GPS_I1),
	.synch_clk(MCU_CLK_25_000),
	.synch_output(gps_i1_sync)
);

synchronizer synch_inst_q0 (
	.asynch_input(GPS_Q0),
	.synch_clk(MCU_CLK_25_000),
	.synch_output(gps_q0_sync)
);

synchronizer synch_inst_q1 (
	.asynch_input(GPS_Q1),
	.synch_clk(MCU_CLK_25_000),
	.synch_output(gps_q1_sync)
);

// CLK_DIV4: Simple clock Divide by 4  CoolRunner-II
//    Xilinx HDL Language Template, version 14.7
CLK_DIV4 CLK_DIV4_inst (
		.CLKDV(GPS_CLK_4_092),    // Divided clock output
		.CLKIN(GPS_CLK_16_368)     // Clock input
);
// End of CLK_DIV4_inst instantiation


// Instantiate bridge state machine here
bridge_sm bridge_sm_inst (
.GPS_I0(gps_i0_sync),
.GPS_I1(gps_i1_sync),
.GPS_Q0(gps_q0_sync),
.GPS_Q1(gps_q1_sync),
.MCU_CLK_25_000(GPS_CLK_25_000),
.RESET(RESET),
.DATAREADY(datardy),
.MCU_SCK(MCU_SCK),
.MCU_SS(MCU_SS),
.MCU_SS(MCU_MOSI)
);

endmodule
