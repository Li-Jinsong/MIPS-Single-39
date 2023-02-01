`timescale 1ns / 1ps

module LoadExt_8( 
    input wire[31:0] readdata,
    input wire[1:0] byte,
    input wire unsign,
    output reg[31:0] out
    ); 

    always @(*) begin
        case(byte)
            2'b00: begin 
                if(unsign)
                    out={{(32-8){1'b0}},readdata[7:0]};
                else
                    out={{(32-8){readdata[7]}},readdata[7:0]};
            end
            2'b01: begin 
                if(unsign)
                    out={{(32-8){1'b0}},readdata[15:8]};
                else
                    out={{(32-8){readdata[15]}},readdata[15:8]};
            end
            2'b10: begin 
                if(unsign)
                    out={{(32-8){1'b0}},readdata[23:16]};
                else
                    out={{(32-8){readdata[23]}},readdata[23:16]};
            end
            2'b11: begin 
                if(unsign)
                    out={{(31-8){1'b0}},readdata[31:24]};
                else
                    out={{(31-8){readdata[31]}},readdata[31:24]};
            end
        endcase
    end

endmodule