`timescale 1ns / 1ps

module LoadExt_16( 
    input wire[31:0] readdata,
    input wire byte,
    input wire unsign,
    output reg[31:0] out
    ); 
    
    always @(*) begin
        case(byte)
            1'b0: begin 
                if(unsign)
                    out={{(32-16){1'b0}},readdata[15:0]};
                else
                    out={{(32-16){readdata[15]}},readdata[15:0]};
            end
            1'b1: begin 
                if(unsign)
                    out={{(32-16){1'b0}},readdata[31:16]};
                else
                    out={{(32-16){readdata[31]}},readdata[31:16]};
            end
        endcase
    end

endmodule