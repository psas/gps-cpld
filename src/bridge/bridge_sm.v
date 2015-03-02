`timescale 1ns / 1ps


module bridge_sm(
	input GPS_I0,
	input GPS_I1,
	input GPS_Q0,
	input GPS_Q1,
	input MCU_CLK_25_000,
	input RESET_N,
	input DATAREADY,
	output MCU_SCK,
	output MCU_SS,
	output MCU_MOSI
  );

  parameter reset_st          = 4'b0000;
  parameter start_st          = 4'b0001;
  parameter i0_st             = 4'b0010;
  parameter i0_clk_st         = 4'b0011;
  parameter i1_st             = 4'b0100;
  parameter i1_clk_st         = 4'b0101;
  parameter q0_st             = 4'b0110;
  parameter q0_clk_st         = 4'b0111;
  parameter q1_st             = 4'b1000;
  parameter q1_clk_st         = 4'b1001;
  parameter wait_dataready_st = 4'b1010;
  parameter ss_release_st     = 4'b1011;
  parameter state13           = 4'b1100;
  parameter state14           = 4'b1101;
  parameter state15           = 4'b1110;
  parameter state16           = 4'b1111;

  parameter i0_sel            = 2'b00;
  parameter i1_sel            = 2'b01;
  parameter q0_sel            = 2'b10;
  parameter q1_sel            = 2'b11;

  wire reset_counter;

  reg ctr_restart;
  reg bitcount_en;
  reg [12:0] bitcounter;

  reg [3:0] state = reset_st;

  reg [1:0] mosi_sel = i0_sel;
  wire  sck;
  reg   sck_en;
  wire   MCU_CLK_25_Delay;
  reg ss;
  reg mosi; 

  assign gps_i0_in = GPS_I0;
  assign gps_i1_in = GPS_I1;
  assign gps_q0_in = GPS_Q0;
  assign gps_q1_in = GPS_Q1;

  assign sck       = MCU_CLK_25_Delay & sck_en;

  assign MCU_SS    = ss;
  assign MCU_SCK   = sck;
  assign MCU_MOSI  = mosi;

  assign reset_n_in = RESET_N;

  // Explicitly multiplex the output
  always @(mosi_sel, gps_i0_in, gps_i1_in, gps_q0_in, gps_q1_in) begin
	case (mosi_sel)
	  i0_sel: begin mosi = gps_i0_in; end
	  i1_sel: begin mosi = gps_i1_in; end
	  q0_sel: begin mosi = gps_q0_in; end
	  q1_sel: begin mosi = gps_q1_in; end
	endcase 
  end

  assign reset_counter = ctr_restart | ~reset_n_in;

  assign MCU_CLK_25_Delay = ~MCU_CLK_25_000;	

  always @(posedge MCU_CLK_25_000) begin
	if (reset_counter)
	  bitcounter <= 13'b1111111111111;
	else if (bitcount_en)
	  bitcounter <= bitcounter - 1;
  end

  (* FSM_ENCODING="SEQUENTIAL", SAFE_IMPLEMENTATION="YES" *) 

  always@(posedge MCU_CLK_25_000) begin
	if (reset_n_in == 0) begin
	  state    <= reset_st;
	  sck_en   <= 1'b0 ;
	  ss       <= 1'b1 ;
	  mosi_sel <= i0_sel ;
	end
	else
	 (* PARALLEL_CASE, FULL_CASE *)
	case (state)
	  reset_st : begin
		ctr_restart <= 1'b1;
		sck_en      <= 1'b0 ;
		ss          <= 1'b1 ;
		mosi_sel    <= i0_sel ;
		bitcount_en <= 1'b0;
		state       <= start_st;
	  end
	  start_st : begin
		if (DATAREADY) begin
		  ss           <= 1'b0;
		  sck_en       <= 1'b1;
		  bitcount_en  <= 1'b1;
		  mosi_sel     <= i0_sel ;
		  state        <= i0_st;
		end
		else begin
		  ss           <= 1'b1;
		  sck_en       <= 1'b0;
		  bitcount_en  <= 1'b0;
		  state        <= start_st;
		end
		bitcount_en <= 1'b0;
		ctr_restart <= 1'b0;
	  end

	  i0_st : begin
		ctr_restart  <= 1'b0;
	    bitcount_en  <= 1'b1;
		mosi_sel     <= i1_sel ;
		state        <= i1_st;
	  end

	  i1_st : begin
		mosi_sel     <= q0_sel ;
		state        <= q0_st;
	  end

	  q0_st: begin
		mosi_sel     <= q1_sel;
		state        <= q1_st;
	  end

	  q1_st : begin
		sck_en       <= 1'b0;
		bitcount_en  <= 1'b0;
		mosi_sel     <= i0_sel ;
		state        <= wait_dataready_st;
	  end

	  wait_dataready_st : begin
		if(bitcounter == 0)  begin
		  bitcount_en  <= 1'b0;
		  ctr_restart  <= 1'b1;
		  ss           <= 1'b1;  // 25 > 16...will keep high for at least one cycle
		end 

		if (DATAREADY) begin
		  ss           <= 1'b0;
		  bitcount_en  <= 1'b1;
		  sck_en       <= 1'b1;
		  state     <= i0_st;
		end
		else begin
		  bitcount_en  <= 1'b0;
		  state     <= wait_dataready_st;
		end
	  end

	  default : begin  // Fault Recovery
	  state <= reset_st;
	end   
  endcase
end
endmodule
