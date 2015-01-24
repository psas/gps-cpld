`timescale 1ns / 1ps

// Divide a clock by 4

module clkdiv4(
	input  clk,
	input  reset,
	output div4clk
);

wire [1:0] din;
wire [1:0] clkdiv;

// Each dff instance divides by 2
adff dff_inst0 ( // div2
	.clk(clk),
	.reset(reset),
	.D(din[0]),
	.Q(clkdiv[0])
);

adff dff_inst1 ( // div2 div2 = div4
	.clk(clkdiv[0]),
	.reset(reset),
	.D(din[1]),
	.Q(clkdiv[1])
);

assign din     = ~clkdiv;
assign div4clk = clkdiv[1];

endmodule



