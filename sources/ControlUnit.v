`timescale 1ns / 1ps

module ControlUnit(
    input wire[5:0] op,func,
    input wire zero,
	output reg[1:0] memtoreg,
    output reg memwrite,
	output reg branch,
	output wire pcsrc,
    output reg[3:0] alu_op,
    output reg alu_src_a,alu_src_b,
	output reg[1:0] regdst,
    output reg regwrite,
	output reg[1:0] ext,
    output reg unsign,
	output reg[1:0] jump
    );

    parameter R_TYPE_op     =       6'b000000;
	// Arithmetic and Logical Instructions
    parameter ADD_func      =       6'b100000;
    parameter ADDI_op       =       6'b001000;
    parameter ADDIU_op      =       6'b001001;
    parameter ADDU_func     =       6'b100001;
    parameter AND_func      =       6'b100100;
    parameter ANDI_op       =       6'b001100;
    parameter DIV_func      =       6'b011010;
    parameter DIVU_func     =       6'b011011;
    parameter LUI_op        =       6'b001111;
    parameter MULT_func     =       6'b011000;
    parameter MULTU_func    =       6'b011001;
    parameter NOR_func      =       6'b100111;
    parameter OR_func       =       6'b100101;
    parameter ORI_op        =       6'b001101;
    parameter SLL_func      =       6'b000000;
    parameter SLLV_func     =       6'b000100;
    parameter SRA_func      =       6'b000011;
    parameter SRAV_func     =       6'b000111;
    parameter SRL_func      =       6'b000010;
    parameter SRLV_func     =       6'b000110;
    parameter SUB_func      =       6'b100010;
    parameter SUBU_func     =       6'b100011;
    parameter XOR_func      =       6'b100110;
    parameter XORI_op       =       6'b001110;
    // Comparison Instructions
    parameter SLTI_op       =       6'b001010;
    parameter SLTIU_op      =       6'b001011;
    // Branch Instructions
    parameter BEQ_op        =       6'b000100;
    parameter BNE_op        =       6'b000101;
    // Jump Instructions
    parameter J_op          =       6'b000010;
    parameter JAL_op        =       6'b000011;
    parameter JR_func       =       6'b001000;
    // Load Instructions
    parameter LB_op         =       6'b100000;
    parameter LBU_op        =       6'b100100;
    parameter LH_op         =       6'b100001;
    parameter LHU_op        =       6'b100101;
    parameter LW_op         =       6'b100011;
    // Store Instructions
    parameter SB_op         =       6'b101000;
    parameter SH_op         =       6'b101001;
    parameter SW_op         =       6'b101011;
    
    always @(*) begin
		case (op)
			R_TYPE_op:  begin
                memtoreg = 2'b00;
                memwrite = 1'b0;
                branch = 1'b0;
                alu_src_b = 1'b0;
                regdst = 2'b01;
                regwrite = 1'b1;
                ext <= 2'b00;
                jump = 2'b00;
                case(func)
                    ADD_func:   begin
                        alu_src_a <= 1'b0;
                        unsign <= 1'b0;
                        alu_op <= 4'b0101;
                    end
                    ADDU_func:  begin   // TODO +unsign
                        alu_src_a <= 1'b0;
                        unsign <= 1'b1;
                        alu_op <= 4'b0101;
                    end
                    AND_func:   begin
                        alu_src_a <= 1'b0;
                        unsign <= 1'b0;
                        alu_op <= 4'b0111;
                    end
                    DIV_func:   begin   // TODO + hi,lo
                        alu_src_a <= 1'b0;
                        regwrite <= 1'b0;
                        unsign <= 1'b0;
                        alu_op <= 4'b0100;
                    end
                    DIVU_func:  begin
                        alu_src_a <= 1'b0;
                        regwrite <= 1'b0;
                        unsign <= 1'b1;
                        alu_op <= 4'b0100;
                    end
                    MULT_func:  begin
                        alu_src_a <= 1'b0;
                        regwrite <= 1'b0;
                        unsign <= 1'b0;
                        alu_op <= 4'b0011;
                    end
                    MULTU_func: begin
                        alu_src_a <= 1'b0;
                        regwrite <= 1'b0;
                        unsign <= 1'b1;
                        alu_op <= 4'b0011;
                    end
                    NOR_func:   begin
                        alu_src_a <= 1'b0;
                        unsign <= 1'b0;
                        alu_op <= 4'b1010;
                    end
                    OR_func:     begin
                        alu_src_a <= 1'b0;
                        unsign <= 1'b0;
                        alu_op <= 4'b1000;
                    end
                    SLL_func:    begin  // TODO + alu_src_a，把 inst[10:6]作为a
                        alu_src_a <= 1'b1;
                        unsign <= 1'b0;
                        alu_op <= 4'b0000;
                    end
                    SLLV_func:   begin
                        alu_src_a <= 1'b0;
                        unsign <= 1'b0;
                        alu_op <= 4'b0000;
                    end
                    SRA_func:    begin
                        alu_src_a <= 1'b0;
                        unsign <= 1'b0;
                        alu_op <= 4'b0001;
                    end
                    SRL_func:    begin // TODO + alu_src_a，把 inst[10:6]作为a
                        alu_src_a <= 1'b1;
                        unsign <= 1'b0;
                        alu_op <= 4'b0010;
                    end
                    SRLV_func:   begin
                        alu_src_a <= 1'b0;
                        unsign <= 1'b0;
                        alu_op <= 4'b0010;
                    end
                    SUB_func:    begin
                        alu_src_a <= 1'b0;
                        unsign <= 1'b0;
                        alu_op <= 4'b0110;
                    end
                    SUBU_func:   begin
                        alu_src_a <= 1'b0;
                        unsign <= 1'b1;
                        alu_op <= 4'b0110;
                    end
                    XOR_func:    begin
                        alu_src_a <= 1'b0;
                        unsign <= 1'b0;
                        alu_op <= 4'b1001;
                    end
                    JR_func:     begin  // TODO 加长 jump (j + jr) 还要加一条从 RD1 -> PC 
                        jump <= 2'b10;
                        regwrite <= 1'b0;
                        alu_src_a <= 1'b0;
                        unsign <= 1'b0;
                        alu_op <= 4'bxxxx;
                    end
                endcase
            end
            ADDI_op:    begin
                memtoreg <= 2'b00;
                memwrite <= 1'b0;
                branch <= 1'b0;
                alu_src_a <= 1'b0;
                alu_src_b <= 1'b1;
                regdst <= 2'b00;
                regwrite <= 1'b1;
                ext <= 2'b00;
                unsign <= 1'b0;
                jump <= 2'b00;
                alu_op <= 4'b0101;
            end
            ADDIU_op:   begin
                memtoreg <= 2'b00;
                memwrite <= 1'b0;
                branch <= 1'b0;
                alu_src_a <= 1'b0;
                alu_src_b <= 1'b1;
                regdst <= 2'b00;
                regwrite <= 1'b1;
                ext <= 2'b00;
                unsign <= 1'b1;
                jump <= 2'b00;
                alu_op <= 4'b0101;
            end
            ANDI_op:    begin
                memtoreg <= 2'b00;
                memwrite <= 1'b0;
                branch <= 1'b0;
                alu_src_a <= 1'b0;
                alu_src_b <= 1'b1;
                regdst <= 2'b00;
                regwrite <= 1'b1;
                ext <= 2'b00;
                unsign <= 1'b0;
                jump <= 2'b00;
                alu_op <= 4'b0111;
            end
            LUI_op:     begin
                memtoreg <= 2'b10;
                memwrite <= 1'b0;
                branch <= 1'b0;
                alu_src_a <= 1'b0;
                alu_src_b <= 1'b0;
                regdst <= 2'b00;
                regwrite <= 1'b1;
                ext <= 2'b00;
                unsign <= 1'b0;
                jump <= 2'b00;
                alu_op <= 4'bxxxx;
            end
            ORI_op:     begin
                memtoreg <= 2'b00;
                memwrite <= 1'b0;
                branch <= 1'b0;
                alu_src_a <= 1'b0;
                alu_src_b <= 1'b1;
                regdst <= 2'b00;
                regwrite <= 1'b1;
                ext <= 2'b00;
                unsign <= 1'b0;
                jump <= 2'b00;
                alu_op <= 4'b1000;
            end
            XORI_op:    begin
                memtoreg <= 2'b00;
                memwrite <= 1'b0;
                branch <= 1'b0;
                alu_src_a <= 1'b0;
                alu_src_b <= 1'b1;
                regdst <= 2'b00;
                regwrite <= 1'b1;
                ext <= 2'b00;
                unsign <= 1'b0;
                jump <= 2'b00;
                alu_op <= 4'b1001;
            end
            SLTI_op:    begin
                memtoreg <= 2'b00;
                memwrite <= 1'b0;
                branch <= 1'b0;
                alu_src_a <= 1'b0;
                alu_src_b <= 1'b1;
                regdst <= 2'b00;
                regwrite <= 1'b1;
                ext <= 2'b00;
                unsign <= 1'b0;
                jump <= 2'b00;
                alu_op <= 4'b1011;
            end
            SLTIU_op:   begin
                memtoreg <= 2'b00;
                memwrite <= 1'b0;
                branch <= 1'b0;
                alu_src_a <= 1'b0;
                alu_src_b <= 1'b1;
                regdst <= 2'b00;
                regwrite <= 1'b1;
                ext <= 2'b00;
                unsign <= 1'b1;
                jump <= 2'b00;
                alu_op <= 4'b1011;
            end
            BEQ_op:     begin
                memtoreg <= 2'b00;
                memwrite <= 1'b0;
                branch <= 1'b1;
                alu_src_a <= 1'b0;
                alu_src_b <= 1'b0;
                regdst <= 2'b00;
                regwrite <= 1'b0;
                ext <= 2'b00;
                unsign <= 1'b0;
                jump <= 2'b00;
                alu_op <= 4'b0110;
            end
            BNE_op:     begin
                memtoreg <= 2'b00;
                memwrite <= 1'b0;
                branch <= 1'b1;
                alu_src_a <= 1'b0;
                alu_src_b <= 1'b0;
                regdst <= 2'b00;
                regwrite <= 1'b0;
                ext <= 2'b00;
                unsign <= 1'b0;
                jump <= 2'b00;
                alu_op <= 4'b0110;
            end
            J_op:       begin
                memtoreg <= 2'b00;
                memwrite <= 1'b0;
                branch <= 1'b0;
                alu_src_a <= 1'b0;
                alu_src_b <= 1'b0;
                regdst <= 2'b00;
                regwrite <= 1'b0;
                ext <= 2'b00;
                unsign <= 1'b0;
                jump <= 2'b01;
                alu_op <= 4'bxxxx;
            end
            JAL_op:     begin
                memtoreg <= 2'b11;
                memwrite <= 1'b0;
                branch <= 1'b0;
                alu_src_a <= 1'b0;
                alu_src_b <= 1'b0;
                regdst <= 2'b10;    // TODO GPR[31], 31
                regwrite <= 1'b1;
                ext <= 2'b00;
                unsign <= 1'b0;
                jump <= 2'b01;
                alu_op <= 4'bxxxx;
            end
            LB_op:      begin   // TODO 加ext, LoadExt
                memtoreg <= 2'b01;
                memwrite <= 1'b0;
                branch <= 1'b0;
                alu_src_a <= 1'b0;
                alu_src_b <= 1'b1;
                regdst <= 2'b00;
                regwrite <= 1'b1;
                ext <= 2'b01;
                unsign <= 1'b0;
                jump <= 2'b00;
                alu_op <= 4'b0101;
            end
            LBU_op:     begin   // TODO 改LoadExt
                memtoreg <= 2'b01;
                memwrite <= 1'b0;
                branch <= 1'b0;
                alu_src_a <= 1'b0;
                alu_src_b <= 1'b1;
                regdst <= 2'b00;
                regwrite <= 1'b1;
                ext <= 2'b01;
                unsign <= 1'b1;
                jump <= 2'b00;
                alu_op <= 4'b0101;
            end
            LH_op:      begin
                memtoreg <= 2'b01;
                memwrite <= 1'b0;
                branch <= 1'b0;
                alu_src_a <= 1'b0;
                alu_src_b <= 1'b1;
                regdst <= 2'b00;
                regwrite <= 1'b1;
                ext <= 2'b10;
                unsign <= 1'b0;
                jump <= 2'b00;
                alu_op <= 4'b0101;
            end
            LHU_op:     begin
                memtoreg <= 2'b01;
                memwrite <= 1'b0;
                branch <= 1'b0;
                alu_src_a <= 1'b0;
                alu_src_b <= 1'b1;
                regdst <= 2'b00;
                regwrite <= 1'b1;
                ext <= 2'b10;
                unsign <= 1'b1;
                jump <= 2'b00;
                alu_op <= 4'b0101;
            end
            LW_op:     begin
                memtoreg <= 2'b01;
                memwrite <= 1'b0;
                branch <= 1'b0;
                alu_src_a <= 1'b0;
                alu_src_b <= 1'b1;
                regdst <= 2'b00;
                regwrite <= 1'b1;
                ext <= 2'b00;
                unsign <= 1'b0;
                jump <= 2'b00;
                alu_op <= 4'b0101;
            end
            SB_op:      begin   //TODO + StoreExt
                memtoreg <= 2'b00;
                memwrite <= 1'b1;
                branch <= 1'b0;
                alu_src_a <= 1'b0;
                alu_src_b <= 1'b1;
                regdst <= 2'b00;
                regwrite <= 1'b0;
                ext <= 2'b01;
                unsign <= 1'b0;
                jump <= 2'b00;
                alu_op <= 4'b0101;
            end
            SH_op:      begin
                memtoreg <= 2'b00;
                memwrite <= 1'b1;
                branch <= 1'b0;
                alu_src_a <= 1'b0;
                alu_src_b <= 1'b1;
                regdst <= 2'b00;
                regwrite <= 1'b0;
                ext <= 2'b10;
                unsign <= 1'b0;
                jump <= 2'b00;
                alu_op <= 4'b0101;
            end
            SW_op:      begin
                memtoreg <= 2'b00;
                memwrite <= 1'b1;
                branch <= 1'b0;
                alu_src_a <= 1'b0;
                alu_src_b <= 1'b1;
                regdst <= 2'b00;
                regwrite <= 1'b0;
                ext <= 2'b00;
                unsign <= 1'b0;
                jump <= 2'b00;
                alu_op <= 4'b0101;
            end
			default:  begin
                memtoreg <= 2'bxx;
                memwrite <= 1'bx;
                branch <= 1'bx;
                alu_src_a <= 1'bx;
                alu_src_b <= 1'bx;
                regdst <= 2'bxx;
                regwrite <= 1'bx;
                ext <= 2'bxx;
                unsign <= 1'bx;
                jump <= 2'bxx;
                alu_op <= 4'bxxxx;
            end
		endcase
	end

	assign pcsrc = (op == BNE_op)? (branch & (~zero)): (branch & zero);

endmodule
