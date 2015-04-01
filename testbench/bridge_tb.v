`timescale 1ns / 1ps

module bridge_tb;

	// Inputs
	reg gps_i0;
	reg gps_i1;
	reg gps_q0;
	reg gps_q1;
	
	reg gps_clk_16_368;
	reg mcu_clk_25_000;
	reg reset;
	
	// outputs
	wire mcu_sck;
	wire mcu_ss;
	wire mcu_mosi;
	
	initial begin
		// Initialize Inputs
		gps_clk_16_368  = 0;
		mcu_clk_25_000  = 0;
		reset           = 0;
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
		.GPS_CLK_16_368(gps_clk_16_368),
		.MCU_CLK_25_000(mcu_clk_25_000),
		.RESET_N(reset),
		.MCU_SCK(mcu_sck),
		.MCU_SS(mcu_ss),
		.MCU_MOSI(mcu_mosi)
		);

	always begin
		#10   reset   = 1'b1;
    end

	always begin
		#30 gps_clk_16_368 = ~gps_clk_16_368;
	end
	
	always begin
		#20 mcu_clk_25_000  = ~mcu_clk_25_000;
	end

    /*always begin
	    #150  gps_q0  = ~gps_q0;
		#150  gps_q1  = ~gps_q1;
		#150  gps_i0  = ~gps_i0;
		#150  gps_i1  = ~gps_i1;
	    #273  gps_q0  = ~gps_q0;
		#273  gps_q1  = ~gps_q1;
		#273  gps_i0  = ~gps_i0;
		#273  gps_i1  = ~gps_i1;

	end*/

endmodule

