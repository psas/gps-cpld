`timescale 1ns / 1ps

// Asynchronous reset DFF...

module adff(
	input  D,
	input  clk,
	input  reset,
	output Q
);

reg Qreg;

assign Q = Qreg;

always @ (posedge(clk), posedge(reset))
begin
	if (reset == 1)
		Qreg <= 1'b0;
	else
		Qreg <= D;
end

endmodule

