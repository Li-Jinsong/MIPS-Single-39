`timescale 1ns / 1ps

module DMem(
    input wire clk,
    input wire[31:0] addr,
    input wire memwrite,
    input wire[31:0] writedata,
    output wire [31:0] readdata
    );
    
    reg[31:0] mem [255:0];
    reg[31:0] n;
     
    initial begin
        for(n = 0; n <= 255; n = n + 1)
            mem[n] = 0;
    end

    always @(posedge clk) begin
        if(memwrite)
            mem[addr] <= writedata;
    end 
    
    assign readdata = mem[addr];
    
endmodule