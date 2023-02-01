`timescale 1ns / 1ps

module IMem(
    input wire[6:0] addr,
    output wire[31:0] instr
    );
    
    reg[31:0] mem [127:0];
    
    initial begin
        $readmemh("test_all.txt",mem);
    end
    
    assign instr = mem[addr];
    
endmodule