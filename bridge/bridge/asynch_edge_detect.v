`timescale 1ns / 1ps

module asynch_edge_detect(
	input SYNC_CLK_IN,
	input ASYNC_IN,
	output SYNC_OUT
);

reg  detect_reg;
wire detect;

reg  sync_a;
reg  sync_b;

reg  sync_b_prev;

assign   detect       = sync_b & ~sync_b_prev;
assign   SYNC_OUT     = detect_reg;

always @(posedge SYNC_CLK_IN) begin
	sync_a      <= ASYNC_IN;
	sync_b_prev <= sync_b;
	detect_reg  <= detect;
end

always @(negedge SYNC_CLK_IN) begin
	sync_b      <= sync_a;
end




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
		   .Q(SYNC_OUT),      // Data output
		   .C(neg_sync_clk),    // Clock input
		   .CE(1'b1),    // Clock enable input
		   .CLR(1'b0),  // Asynchronous clear input
		   .D(detect)       // Data input
   );
   */
  // End of FDCE_inst instantiation


  endmodule
