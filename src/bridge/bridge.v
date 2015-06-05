`timescale 1ns / 1ps

module bridge(
		input GPS_I0,
		input GPS_I1,
		input GPS_Q0,
		input GPS_Q1,
		input MAX2769_CLK,
		input MCU_CLK,
		input RESET_N,
		input SELF_TEST,
		output MCU_SCK,
		output MCU_SS,
		output MCU_MOSI);

wire datardy;

wire gps_i0_sync;
wire gps_i1_sync;
wire gps_q0_sync;
wire gps_q1_sync;

//wire MAX2769_DIV4;

reg   gps_i0_sync_reg;
reg   gps_i1_sync_reg;
reg   gps_q0_sync_reg;
reg   gps_q1_sync_reg;

//assign RESET_P        = ~RESET_N;

// Instantiate bridge state machine here
bridge_sm bridge_sm_inst (
.GPS_I0(gps_i0_sync_reg),
.GPS_I1(gps_i1_sync_reg),
.GPS_Q0(gps_q0_sync_reg),
.GPS_Q1(gps_q1_sync_reg),
.MCU_CLK(MCU_CLK),
.RESET_N(RESET_N),
.SELF_TEST(SELF_TEST),
.DATAREADY(datardy),
.MCU_SCK(MCU_SCK),
.MCU_SS(MCU_SS),
.MCU_MOSI(MCU_MOSI)
);

/*
clkdiv4 clkdiv4_inst (
	.clk(MAX2769_CLK),
	.reset(RESET_P),
	.div4clk(MAX2769_DIV4)
);
*/
						

// Instantiate edge detection here
asynch_edge_detect asynch_edge_detect_inst(
		.SYNC_CLK_IN(MCU_CLK),
		.ASYNC_IN(MAX2769_CLK),
		.DETECT_OUT(datardy)
);

// Need to match the phase of data due to the can't 
//    use divided clock as an combinational input thing..
always@(posedge MCU_CLK) begin
   gps_i0_sync_reg <= gps_i0_sync;
   gps_i1_sync_reg <= gps_i1_sync;
   gps_q0_sync_reg <= gps_q0_sync;
   gps_q1_sync_reg <= gps_q1_sync;
   
end

synchronizer synch_inst_q1 (
	.asynch_input(GPS_Q1),
	.synch_clk(MCU_CLK),
	.synch_output(gps_q1_sync)
);

synchronizer synch_inst_i0 (
	.asynch_input(GPS_I0),
	.synch_clk(MCU_CLK),
	.synch_output(gps_i0_sync)
);
	
synchronizer synch_inst_i1 (
	.asynch_input(GPS_I1),
	.synch_clk(MCU_CLK),
	.synch_output(gps_i1_sync)
);

synchronizer synch_inst_q0 (
	.asynch_input(GPS_Q0),
	.synch_clk(MCU_CLK),
	.synch_output(gps_q0_sync)
);


endmodule
