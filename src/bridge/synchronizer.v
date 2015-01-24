`timescale 1ns / 1ps

// synchronize a signal to local clock domain

module synchronizer(
    input asynch_input,
    input synch_clk,
    output synch_output
    );

reg synch_a;
reg synch_b;

assign synch_output = synch_b;

always @(negedge synch_clk) begin
	synch_b <= synch_a;
end

always @(posedge synch_clk) begin
   synch_a <= asynch_input;
end


endmodule
