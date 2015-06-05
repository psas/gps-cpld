`timescale 1ns / 1ps

module bridge_tb;

	// Inputs
	reg gps_i0;
	reg gps_i1;
	reg gps_q0;
	reg gps_q1;
	
	reg max2769_clk;
	reg mcu_clk;
	reg self_test;
	reg reset;
	
	// outputs
	wire mcu_sck;
	wire mcu_ss;
	wire mcu_mosi;
	
	initial begin
		// Initialize Inputs
		max2769_clk  = 0;
		mcu_clk  = 0;
		reset           = 0;
		self_test       = 1;
		gps_i0          = 0;
		gps_i1          = 0;
		gps_q0          = 0;
		gps_q1          = 0;
	end    

	bridge uut (
		.GPS_I0(gps_i0),
		.GPS_I1(gps_i1),
		.GPS_Q0(gps_q0),
		.GPS_Q1(gps_q1),
		.MAX2769_CLK(max2769_clk),
		.MCU_CLK(mcu_clk),
		.SELF_TEST(self_test),
		.RESET_N(reset),
		.MCU_SCK(mcu_sck),
		.MCU_SS(mcu_ss),
		.MCU_MOSI(mcu_mosi)
		);

	always begin
		#50   reset   = 1'b1;
	end

	always begin
		#30 max2769_clk = ~max2769_clk;
	end
	
	always begin
		#13 mcu_clk  = ~mcu_clk;
	end

	always begin
		#150  gps_q0  = ~gps_q0;
		#150  gps_q1  = ~gps_q1;
		#150  gps_i0  = ~gps_i0;
		#150  gps_i1  = ~gps_i1;
		#273  gps_q0  = ~gps_q0;
		#273  gps_q1  = ~gps_q1;
		#273  gps_i0  = ~gps_i0;
		#273  gps_i1  = ~gps_i1;
	end

	always begin
		#491570 self_test = ~self_test;
	end

endmodule

