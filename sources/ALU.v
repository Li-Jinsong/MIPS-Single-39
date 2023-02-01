`timescale 1ns / 1ps

module ALU(
    input wire[3:0] alu_op,
    input wire unsign,
    input wire[31:0] a,b,
    output reg[31:0] alu_out,
    output reg zf // zero
    );

    reg[31:0] hi,lo;

    always @(*) begin
        case(alu_op)
            4'b0000: alu_out = b << a[4:0];                     // sll
			4'b0001: alu_out = $signed(b) >>> a[4:0];           // sra|srav
			4'b0010: alu_out = b >> a[4:0];                     // srl|srlv
			4'b0011: begin 
                        if(unsign)
                            {hi,lo} = a * b; // multu
                        else
                            {hi,lo} = $signed(a) * $signed(b); // mult
            end
			4'b0100: begin 
                        if(unsign)
                            {hi,lo} <= {a % b, a / b}; // divu
                        else
                            {hi,lo} <= {$signed(a) % $signed(b), $signed(a) / $signed(b)}; // div
            end                         
            4'b0101: begin 
                        if(unsign)
                            alu_out = a + b; // addu
                        else
                            alu_out = $signed(a) + $signed(b); // add
            end
            4'b0110: begin 
                        if(unsign)
                            alu_out = a - b; // subu
                        else
                            alu_out = $signed(a) - $signed(b); // sub
            end
            4'b0111: alu_out = a & b;                              // and
			4'b1000: alu_out = a | b;                              // or
			4'b1001: alu_out = a ^ b;                              // xor
			4'b1010: alu_out = ~(a | b);                           // nor
			4'b1011: begin
                        if(unsign)
			                alu_out = (a < b)? 1: 0;                      // sltu
                        else
                            alu_out = ($signed(a) < $signed(b))? 1: 0;    // slt
            end     
            default: alu_out = {32{1'bx}};
        endcase
        zf = alu_out == 0;
    end
    
endmodule
