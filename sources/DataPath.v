`timescale 1ns / 1ps

module DataPath(
    input wire clk,rst,
    // CU
	input wire[1:0] memtoreg,
	input wire pcsrc,
    input wire[3:0] alu_op,
	input wire alu_src_a,alu_src_b,
	input wire[1:0] regdst,
    input wire regwrite,
	input wire[1:0] ext,
    input wire unsign,
	input wire[1:0] jump,
	// IM
	input wire[31:0] instr,
	// DM
    input wire[31:0] readdata,
    output wire zf,
    output wire[31:0] pc,
    output wire[31:0] alu_out,
    output wire[31:0] writedata_ext
    );
    
    wire[4:0] writereg;
    wire[31:0] pcnext_1,pcnext_2,pcplus4,pcbranch;
    wire[31:0] signimm;
    wire[31:0] srca,srcb;
    wire[31:0] rd1;
    wire[31:0] writedata_bitext,writedata_hwext;
    wire[31:0] writedata;
    wire[31:0] readdata_bitext,readdata_hwext;
    wire[31:0] readdata_ext;
    wire[31:0] result;

    PC PC(
        .clk(clk),
        .rst(rst),
        .next_addr(pcnext_2),
        .addr(pc)
    );
    MUX_4#(32) pcMUX_j_3(
        .d0(pcnext_1),
        .d1({pcplus4[31:28],instr[25:0],2'b00}),    // j
        .d2(rd1),   // jr
        .signal(jump),
        .out(pcnext_2)
    );
    MUX_2#(32) pcMUX_b_2(
        .d0(pcplus4),
        .d1(pcbranch),    // beq|bne
        .signal(pcsrc),
        .out(pcnext_1)
    );
    Add pcAdd_2(
        .a(pcplus4),
        .b({signimm[29:0],2'b00}),
        .c(pcbranch)
    );
    Add pcAdd_1(
        .a(pc),
        .b(32'b100),
        .c(pcplus4)
    );
    SigExt16_32 SigExt_imm(
        .in(instr[15:0]),
        .out(signimm)
    );
    RegFile rf(
        .clk(clk),
        .w(regwrite),
        .ra1(instr[25:21]),
        .ra2(instr[20:16]),
        .rd1(rd1),
        .rd2(writedata),
        .wa3(writereg),
        .wd3(result)
    );
    MUX_4#(5) rfMUX_w_3(
        .d0(instr[20:16]),  // I-Type
        .d1(instr[15:11]),    // R-Type
        .d2(5'b11111),  // JAL 31
        .signal(regdst),
        .out(writereg)
    );
    MUX_2#(32) srcMUX_a_2(
        .d0(rd1),
        .d1({{27{1'b0}}, instr[10:6]}),    // sll
        .signal(alu_src_a),
        .out(srca)
    );
    MUX_2#(32) srcMUX_b_2(
        .d0(writedata),  // R-Type
        .d1(signimm),    // immediate
        .signal(alu_src_b),
        .out(srcb)
    );
    ALU alu(
        .alu_op(alu_op),
        .unsign(unsign),
        .a(srca),
        .b(srcb),
        .alu_out(alu_out),
        .zf(zf)
    );
    StoreExt_8 bitExt_store(
        .writedata(writedata),
        .byte(alu_out[1:0]),
        .memory(readdata),
        .out(writedata_bitext)
    );
    StoreExt_16 hwExt_store(
        .writedata(writedata),
        .byte(alu_out[1]),
        .memory(readdata),
        .out(writedata_hwext)
    );
    MUX_4#(32) extMUX_store_3(
        .d0(writedata),
        .d1(writedata_bitext),
        .d2(writedata_hwext),
        .signal(ext),
        .out(writedata_ext)
    );
    LoadExt_8 bitExt_load(
        .readdata(readdata),
        .byte(alu_out[1:0]),
        .unsign(unsign),
        .out(readdata_bitext)
    );
    LoadExt_16 hwExt_load(
        .readdata(readdata),
        .byte(alu_out[1]),
        .unsign(unsign),
        .out(readdata_hwext)
    );
    MUX_4#(32) extMUX_load_3(
        .d0(readdata),
        .d1(readdata_bitext),
        .d2(readdata_hwext),
        .signal(ext),
        .out(readdata_ext)
    );
    MUX_4#(32) resMUX_4(
        .d0(alu_out),
        .d1(readdata_ext),
        .d2({instr[15:0],{16{1'b0}}}),
        .d3(pcplus4),
        .signal(memtoreg),
        .out(result)
    );

endmodule