`timescale 1ns / 1ps


module bridge_sm(
    input GPS_I0,
    input GPS_I1,
    input GPS_Q0,
    input GPS_Q1,
    input MCU_CLK_25_000,
	input RESET,
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

	wire reset_counter;
	reg ctr_restart;
	reg bitcount_en;
    reg [7:0] bitcounter;

	assign reset_counter = ctr_restart | RESET;
	
    always @(posedge MCU_CLK_25_000)
      if (reset_counter)
         bitcounter <= 0xFF;
      else if (bitcount_en)
         bitcounter <= bitcounter - 1;
   (* FSM_ENCODING="SEQUENTIAL", SAFE_IMPLEMENTATION="YES", SAFE_RECOVERY_STATE="reset_st" *) reg [3:0] state = reset_st;

   always@(posedge MCU_CLK_25_000)
      if (RESET) begin
         state    <= reset_st;
         MCU_SCK  <= 1'b1 ;
         MCU_SS   <= 1'b1 ;
         MCU_MOSI <= 1'b1 ;
      end
      else
         (* PARALLEL_CASE, FULL_CASE *) case (state)
            reset_st : begin
				ctr_restart <= 1'b1;
                MCU_SCK     <= 1'b1 ;
                MCU_SS      <= 1'b1 ;
                MCU_MOSI    <= 1'b1 ;
                bitcount_en <= 1'b0;
                state       <= start_st;
            end
			start_st : begin
				if (DATAREADY) begin
					MCU_SS  <= 1'b0;       // assert SS here
					MCU_CLK <= 1'b1;       // Data will be clocked out of bridge on negative edge of MCU_CLK, into MCU on positive edge
					state   <= i0_st;
				end
				else begin
					state   <= start_st;
				end
				bitcount_en <= 1'b0;
				ctr_restart <= 1'b0;
			end
            i0_st : begin
               bitcount_en  <= 1'b1;
               MCU_CLK      <= 1'b1;
               state        <= i0_clk_st;
            end
            i0_clk_st: begin
               bitcount_en  <= 1'b0;
			   MCU_MOSI     <= GPS_I0;
               MCU_CLK      <= 1'b0;
               state        <= i1_st;
            end
            i1_st : begin
               bitcount_en  <= 1'b1;
               MCU_CLK      <= 1'b1;
               state        <= i0_clk_st;
            end
            i1_clk_st : begin
               bitcount_en  <= 1'b0;
			   MCU_MOSI     <= GPS_I1;
               MCU_CLK      <= 1'b0;
               state        <= q0_st;
            end
            q0_st: begin
               bitcount_en  <= 1'b1;
               MCU_CLK      <= 1'b1;
               state        <= q0_clk_st;
            end
            q0_clk_st : begin
               bitcount_en  <= 1'b0;
			   MCU_MOSI     <= GPS_Q0;
               MCU_CLK      <= 1'b0;
               state        <= q1_st;
            end
            q1_st : begin
               bitcount_en  <= 1'b1;
               MCU_CLK      <= 1'b1;
               state        <= q1_clk_st;
            end
			q1_clk_st : begin
				bitcount_en <= 1'b0;
				MCU_MOSI    <= GPS_Q1;
				MCU_CLK     <= 1'b0;
				if(bitcounter == 0)  begin
					state   <= ss_release_st;
			    end 
				else begin
					state   <= wait_dataready_st;
			    end
			end
            wait_dataready_st : begin
			   if (DATAREADY) begin
                  MCU_SS    <= 1'b0;       // assert SS here
                  state     <= i0_st;
		       end
			   else begin
                  MCU_SS    <= 1'b1;       // assert SS here
                  state     <= wait_dataready_st;
		       end
               MCU_CLK     <= 1'b1;       
               bitcount_en <= 1'b0;
            end
            ss_release_st : begin
			   bitcount_en <= 1'b0;
			   ctr_restart <= 1'b1;
               MCU_CLK     <= 1'b1; 
               MCU_SS      <= 1'b1;       // de-assert SS here
               state       <= wait_dataready_st;
            end
            <state13> : begin
               state <= reset_st;
            end
            <state14> : begin
               state <= reset_st;
            end
            <state15> : begin
               state <= reset_st;
            end
            <state16> : begin
               state <= reset_st;
            end
            default : begin  // Fault Recovery
               state <= reset_st;
            end   
         endcase
							
endmodule
