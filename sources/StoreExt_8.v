`timescale 1ns / 1ps

module StoreExt_8( 
    input [31:0] writedata,
    input [1:0] byte,
    input [31:0] memory,
    output reg[31:0] out
    ); 
    
    always @(*) begin
        case(byte)
            2'b00: out={memory[31:8],writedata[7:0]};
            2'b01: out={memory[31:16],writedata[7:0],memory[7:0]};
            2'b10: out={memory[31:24],writedata[7:0],memory[15:0]};
            2'b11: out={writedata[7:0],memory[23:0]};
        endcase
    end

endmodule

