`timescale 1ns / 1ps

module PC(
    input clk,rst,
    input [31:0] next_addr,
    output reg[31:0] addr
    );

    always @(posedge clk,posedge rst) begin
        if(rst)
            addr <= 0;
        else
            addr <= next_addr;
    end

endmodule
