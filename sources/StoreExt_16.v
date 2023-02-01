`timescale 1ns / 1ps

module StoreExt_16( 
    input [31:0] writedata,
    input byte,
    input [31:0] memory,
    output reg[31:0] out
    ); 
   
    always @(*) begin
        case(byte)
            1'b0: out={memory[31:16],writedata[15:0]};
            1'b1: out={writedata[15:0],memory[15:0]};
        endcase
    end

endmodule

