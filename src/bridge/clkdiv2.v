`timescale 1ns / 1ps

// Divide a clock by 2

module clkdiv2(
	input  clk,
	input  reset,
	output div2clk
);

wire  din;
wire  clkdiv;

// Each dff instance divides by 2
adff dff_inst0 ( // div2
	.clk(clk),
	.reset(reset),
	.D(din),
	.Q(clkdiv)
);


assign din     = ~clkdiv;
assign div2clk = clkdiv;

endmodule



