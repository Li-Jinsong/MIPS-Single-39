`timescale 1ns / 1ps

module MIPS(
    input wire clk,
    input wire rst,

    output wire[31:0] pc,
    output wire[31:0] instr,
    output wire zf,
    output wire[1:0] memtoreg,
    output wire memwrite,
    output wire branch,
    output wire pcsrc,
    output wire[3:0] alu_op,
    output wire alu_src_a,alu_src_b,
    output wire[31:0] alu_out,
    output wire[1:0] regdst,
    output wire regwrite,
    output wire[1:0] ext,
    output wire unsign,
    output wire[1:0] jump,
    output wire[31:0] readdata,
    output wire[31:0] writedata_ext
    );
    
    ControlUnit cu(
        .op(instr[31:26]),
        .func(instr[5:0]),
        .zero(zf),
        .memtoreg(memtoreg),
        .memwrite(memwrite),
        .branch(branch),
        .pcsrc(pcsrc),
        .alu_op(alu_op),
        .alu_src_a(alu_src_a),
        .alu_src_b(alu_src_b),
        .regdst(regdst),
        .regwrite(regwrite),
        .ext(ext),
        .unsign(unsign),
        .jump(jump)
    );
    
    DataPath dp(
        .clk(clk),
        .rst(rst),
        // CU
        .memtoreg(memtoreg),
        .pcsrc(pcsrc),
        .alu_op(alu_op),
        .alu_src_a(alu_src_a),
        .alu_src_b(alu_src_b),
        .regdst(regdst),
        .regwrite(regwrite),
        .ext(ext),
        .unsign(unsign),
        .jump(jump),
        // IM
        .instr(instr),
        // DM
        .readdata(readdata),
        // Output
        .zf(zf),
        .pc(pc),
        .alu_out(alu_out),
        .writedata_ext(writedata_ext)
    );
    
    IMem im(    // 32-bit*128
        .addr(pc[8:2]),
        .instr(instr)
    );
    
    DMem dm(    // 32-bit*256
        .clk(clk),
        .addr(alu_out),
        .memwrite(memwrite),
        .writedata(writedata_ext),
        .readdata(readdata)
    );

endmodule
