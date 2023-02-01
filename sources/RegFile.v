`timescale 1ns / 1ps

module RegFile(
	input wire clk,w,
	input wire[4:0] ra1,ra2,wa3,
	input wire[31:0] wd3,
	output wire[31:0] rd1,rd2
    );

	reg[31:0] register[31:0];

	always @(posedge clk) begin
		if(w) begin
			 register[wa3] <= wd3;
		end
	end

	assign rd1 = (ra1 != 0) ? register[ra1] : 0;
	assign rd2 = (ra2 != 0) ? register[ra2] : 0;

endmodule
