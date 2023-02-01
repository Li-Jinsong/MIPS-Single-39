`timescale 1ns / 1ps

module SigExt16_32( 
    input [15:0] in,
    output [31:0] out
    ); 

    assign out={{16{in[15]}},in};
    
endmodule
