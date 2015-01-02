`timescale 1ns / 1ps

module edged_tb;

	// Inputs
	reg sync_clk;
	reg async_clk;
	
	// Outputs
	wire sig_out;
	
	asynch_edge_detect uut (
		.SYNC_CLK_IN(sync_clk), 
		.ASYNC_IN(async_clk), 
		.DETECT_OUT(sig_out) 
	);
	
	initial begin
		// Initialize Inputs
		sync_clk  = 0;
		async_clk = 0;
	end    
	
	always begin
	   #64 async_clk = ~async_clk;
	end
	always begin
		#25 sync_clk  = ~sync_clk;
	end

endmodule

