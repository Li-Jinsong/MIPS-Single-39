`timescale 1ns / 1ps

module Test();
	reg clk;
	reg rst;
    // PC   
    wire[31:0] pc;
    wire[31:0] instr;
    // ALU
    wire[3:0] alu_op;
    wire alu_src_a,alu_src_b;
    wire[31:0] alu_out;
    // Mem
    wire[31:0] readdata;
    wire[31:0] writedata_ext;
    // CU
    wire zf;
    wire[1:0] memtoreg;
    wire memwrite;
    wire branch;
    wire pcsrc;
    wire[1:0] regdst;
    wire regwrite;
    wire[1:0] ext;
    wire unsign;
    wire[1:0] jump;
    
    MIPS cpu(
        .clk(clk),
        .rst(rst),
        .pc(pc),
        .instr(instr),
        .zf(zf),
        .memtoreg(memtoreg),
        .memwrite(memwrite),
        .branch(branch),
        .pcsrc(pcsrc),
        .alu_op(alu_op),
        .alu_src_a(alu_src_a),
        .alu_src_b(alu_src_b),
        .alu_out(alu_out),
        .regdst(regdst),
        .regwrite(regwrite),
        .ext(ext),
        .unsign(unsign),
        .jump(jump),
        .readdata(readdata),
        .writedata_ext(writedata_ext)
    );
    
    initial begin 
        rst <= 1;
        #5;
        rst <= 0;
    end
    
    always begin
        clk <= 1;
        #5;
        clk <= 0;
        #5;
    end
    
    always @(negedge clk) begin
        if(memwrite) begin
            if(alu_out === 56 & writedata_ext === 32'h000f0000) begin
                $display("Simulation Succeeded");
                $stop;
            end
        end
    end

endmodule