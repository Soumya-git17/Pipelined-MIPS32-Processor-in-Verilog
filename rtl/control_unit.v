`include "parameters.v"

module control_unit(
    input [5:0] opcode,
    input [5:0] funct,
    output reg reg_dst,     // 1 = rd (R), 0 = rt (I)
    output reg reg_write,   // write to regfile
    output reg mem_write,   // write to data_mem
    output reg mem_to_reg,  // 1 = memory , 0 = alu
    output reg alu_src,     // 1 = immediate, 0 = register
    output reg branch,       // branch instruction
    output reg [3:0] alu_op  // ALU operation code
);

always @(*) begin
    reg_dst = 1'b0;
    reg_write = 1'b0;
    mem_write = 1'b0;
    mem_to_reg = 1'b0;
    alu_src = 1'b0;
    branch = 1'b0;
    alu_op = 4'b0;
    case (opcode)
        // R Type
        `OP_RTYPE : begin
            reg_dst = 1'b1;
            reg_write = 1'b1;
            mem_write = 1'b0;
            mem_to_reg = 1'b0;
            alu_src = 1'b0;
            branch = 1'b0;
            case(funct)
                `FUNCT_ADD  : alu_op = `ALU_ADD;
                `FUNCT_ADDU : alu_op = `ALU_ADD;
                `FUNCT_SUB  : alu_op = `ALU_SUB;
                `FUNCT_SUBU : alu_op = `ALU_SUB;
                `FUNCT_AND  : alu_op = `ALU_AND;
                `FUNCT_OR   : alu_op = `ALU_OR;
                `FUNCT_XOR  : alu_op = `ALU_XOR;
                `FUNCT_NOR  : alu_op = `ALU_NOR;
                `FUNCT_SLT  : alu_op = `ALU_SLT;
                `FUNCT_SLTU : alu_op = `ALU_SLTU;
                `FUNCT_SLL  : alu_op = `ALU_SLL;
                `FUNCT_SRL  : alu_op = `ALU_SRL;
                `FUNCT_SRA  : alu_op = `ALU_SRA;
                `FUNCT_JR   : begin reg_write = 1'b0; alu_op = 4'b0000; end
                default : alu_op = 4'b0000;
            endcase
        end
        // I Type
        `OP_ADDI : begin
            reg_dst = 1'b0;
            reg_write = 1'b1;
            mem_write = 1'b0;
            mem_to_reg = 1'b0;
            alu_src = 1'b1;
            branch = 1'b0;
            alu_op = `ALU_ADD;
        end
        `OP_ADDIU : begin
            reg_dst = 1'b0;
            reg_write = 1'b1;
            mem_write = 1'b0;
            mem_to_reg = 1'b0;
            alu_src = 1'b1;
            branch = 1'b0;
            alu_op = `ALU_ADD;
        end
        `OP_ANDI : begin
            reg_dst = 1'b0;
            reg_write = 1'b1;
            mem_write = 1'b0;
            mem_to_reg = 1'b0;
            alu_src = 1'b1;
            branch = 1'b0;
            alu_op = `ALU_AND;
        end
        `OP_ORI : begin
            reg_dst = 1'b0;
            reg_write = 1'b1;
            mem_write = 1'b0;
            mem_to_reg = 1'b0;
            alu_src = 1'b1;
            branch = 1'b0;
            alu_op = `ALU_OR;
        end
        `OP_XORI : begin
            reg_dst = 1'b0;
            reg_write = 1'b1;
            mem_write = 1'b0;
            mem_to_reg = 1'b0;
            alu_src = 1'b1;
            branch = 1'b0;
            alu_op = `ALU_XOR;
        end 
        `OP_LUI : begin
            reg_dst = 1'b0;
            reg_write = 1'b1;
            mem_write = 1'b0;
            mem_to_reg = 1'b0;
            alu_src = 1'b1;
            branch = 1'b0;
            alu_op = `ALU_LUI;
        end
        `OP_LW : begin
            reg_dst = 1'b0;
            reg_write = 1'b1;
            mem_write = 1'b0;
            mem_to_reg = 1'b1;
            alu_src = 1'b1;
            branch = 1'b0;
            alu_op = `ALU_ADD;
        end
        `OP_SW : begin
            reg_dst = 1'b0;
            reg_write = 1'b0;
            mem_write = 1'b1;
            mem_to_reg = 1'b0;
            alu_src = 1'b1;
            branch = 1'b0;
            alu_op = `ALU_ADD;
        end
        `OP_BEQ : begin
            reg_dst = 1'b0;
            reg_write = 1'b0;
            mem_write = 1'b0;
            mem_to_reg = 1'b0;
            alu_src = 1'b0;
            branch = 1'b1;
            alu_op = `ALU_SUB;
        end
        `OP_BNE : begin
            reg_dst = 1'b0;
            reg_write = 1'b0;
            mem_write = 1'b0;
            mem_to_reg = 1'b0;
            alu_src = 1'b0;
            branch = 1'b1;
            alu_op = `ALU_SUB;
        end
        `OP_BLEZ : begin
            reg_dst = 1'b0;
            reg_write = 1'b0;
            mem_write = 1'b0;
            mem_to_reg = 1'b0;
            alu_src = 1'b0;
            branch = 1'b1;
            alu_op = `ALU_ADD;
        end
        `OP_BGTZ : begin
            reg_dst = 1'b0;
            reg_write = 1'b0;
            mem_write = 1'b0;
            mem_to_reg = 1'b0;
            alu_src = 1'b0;
            branch = 1'b1;
            alu_op = `ALU_ADD;
        end
        `OP_J : begin
            reg_dst = 1'b0;
            reg_write = 1'b0;
            mem_write = 1'b0;
            mem_to_reg = 1'b0;
            alu_src = 1'b0;
            branch = 1'b0;
            alu_op = 4'b0000;    
        end 
        default: begin
            reg_dst = 1'b0;
            reg_write = 1'b0;
            mem_write = 1'b0;
            mem_to_reg = 1'b0;
            alu_src = 1'b0;
            branch = 1'b0;
            alu_op = 4'b0; 
        end
    endcase
end

endmodule