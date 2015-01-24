`timescale 1ns / 1ps

module asynch_edge_detect(
	input SYNC_CLK_IN,
	input ASYNC_IN,
	output DETECT_OUT
);

wire detect;
wire signal_in;

reg  signal_in_prev;

assign   detect       = signal_in & ~signal_in_prev;
assign   DETECT_OUT   = detect;

always @(posedge SYNC_CLK_IN) begin
	signal_in_prev <= signal_in;
end

synchronizer synch_inst (
	.asynch_input(ASYNC_IN),
	.synch_clk(SYNC_CLK_IN),
	.synch_output(signal_in)
);
	

// FDCE: Single Data Rate D Flip-Flop with Asynchronous Clear and
//       Clock Enable (posedge clk).
//       All families.
// Xilinx HDL Language Template, version 14.7

/*FDCE #(
.INIT(1'b0) // Initial value of register (1'b0 or 1'b1)
   ) FDCE_inst_a (
		   .Q(async_clk_prev),      // Data output
		   .C(SYNC_CLK_IN),      // Clock input
		   .CE(1'b1),    // Clock enable input
		   .CLR(1'b0),  // Asynchronous clear input
		   .D(ASYNC_IN)       // Data input
   );

   FDCE #(
		   .INIT(1'b0) // Initial value of register (1'b0 or 1'b1)
   ) FDCE_inst_b (
		   .Q(DETECT_OUT),      // Data output
		   .C(neg_sync_clk),    // Clock input
		   .CE(1'b1),    // Clock enable input
		   .CLR(1'b0),  // Asynchronous clear input
		   .D(detect)       // Data input
   );
   */
  // End of FDCE_inst instantiation


  endmodule
