`timescale 1ns / 1ps


module bridge_sm(
	input GPS_I0,
	input GPS_I1,
	input GPS_Q0,
	input GPS_Q1,
	input MCU_CLK_25_000,
	input RESET_N,
	input SELF_TEST,
	input DATAREADY,
	output MCU_SCK,
	output MCU_SS,
	output MCU_MOSI
  );

  reg [12:0] bitcounter;
  reg [2:0] ss_delay;

  reg sck_en;
  reg mosi;

  wire [3:0] selftest_in;
  assign selftest_in = bitcounter[2]
		? bitcounter[6:3]
		: bitcounter[10:7];

  wire [3:0] gps_in;
  assign gps_in = SELF_TEST
		? {selftest_in[0], selftest_in[1], selftest_in[2], selftest_in[3]}
		: {GPS_Q1, GPS_Q0, GPS_I1, GPS_I0};

  wire [1:0] mosi_sel;
  assign mosi_sel = bitcounter[1:0];

  assign MCU_CLK_25_Delay = ~MCU_CLK_25_000;	

  assign MCU_SS    = ss_delay[0];
  assign MCU_SCK   = MCU_CLK_25_Delay & sck_en;
  assign MCU_MOSI  = mosi;

  assign reset_n_in = RESET_N;

  always@(posedge MCU_CLK_25_000) begin
	if (reset_n_in == 0) begin
		sck_en <= 1'b0;
		ss_delay <= 0;
		bitcounter <= 0;
	end
	else begin
		if (mosi_sel != 0 || DATAREADY) begin
			sck_en <= 1'b1;
			mosi <= gps_in[mosi_sel];
			ss_delay <= 3'b100;
			bitcounter <= bitcounter + 1;
		end
		else begin
			sck_en <= 1'b0;
			mosi <= 0;
			if (bitcounter == 0) begin
				ss_delay <= ss_delay >> 1;
			end
		end
	end
end
endmodule
