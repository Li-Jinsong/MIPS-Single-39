`timescale 1ns / 1ps
 
module MUX_4 #(parameter WIDTH = 8)(
	input wire[WIDTH-1:0] d0,d1,d2,d3,
	input wire[1:0] signal,
	output reg[WIDTH-1:0] out
    );

	always @(*) begin
	   case(signal)
	       2'b00: out = d0;
	       2'b01: out = d1;
	       2'b10: out = d2;
           2'b11: out = d3;
       endcase
	end

endmodule
