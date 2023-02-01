`timescale 1ns / 1ps
 
module MUX_2 #(parameter WIDTH = 8)(
	input wire[WIDTH-1:0] d0,d1,
	input wire signal,
	output reg[WIDTH-1:0] out
    );
	
	always @(*) begin
	   case(signal)
	       1'b0: out = d0;
	       1'b1: out = d1;
       endcase
	end

endmodule
