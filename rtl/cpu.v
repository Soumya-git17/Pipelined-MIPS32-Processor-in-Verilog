`include "parameters.v"
`include "alu.v"
`include "control_unit.v"
`include "data_mem.v"
`include "instr_decoder.v"
`include "instr_mem.v"
`include "pc.v"
`include "reg_file.v"
`include "sign_extend.v"
`include "IF_ID.v"
`include "ID_EX.v"
`include "EX_MEM.v"
`include "MEM_WB.v"
`include "forwarding_unit.v"
`include "stall_unit.v"


module cpu (
    input clk, rst
);

wire [31:0] pc_next, pc_out;
wire [31:0] instr_IF, instr_ID;
wire [5:0] opcode_ID, opcode_EX;
wire [4:0] rs_ID, rs_EX, rt_ID, rt_EX, rd_ID, rd_EX, shamt_ID, shamt_EX;
wire [5:0] funct_ID, funct_EX;
wire [15:0] imm_ID, imm_EX;
wire [31:0] imm_signed_EX;
wire [25:0] j_target;
wire [31:0] imm_zero_ext;
wire reg_write_ID, reg_write_EX, reg_write_MEM, reg_write_WB;
wire [31:0] write_data;
wire [31:0] a_ID, a_EX, b_ID, b_EX, b_MEM, alu_result_EX, alu_result_MEM, alu_result_WB;
wire [3:0] alu_op_ID, alu_op_EX;
wire zero;
wire mem_write_ID, mem_write_EX, mem_write_MEM;
wire [31:0] mem_read_data_MEM, mem_read_data_WB;
wire reg_dst_ID, reg_dst_EX, mem_to_reg_ID, mem_to_reg_EX, mem_to_reg_MEM, mem_to_reg_WB;
wire alu_src_ID, alu_src_EX, branch_ID, branch_EX;
wire [31:0] pc_plus4_IF, pc_plus4_ID, pc_plus4_EX, pc_branch_target, pc_jump_target, pc_branch_or_seq;
wire [4:0] write_reg_EX, write_reg_MEM, write_reg_WB;
wire branch_taken, jump, blez_taken, bgtz_taken, jr;
wire [31:0] src_b_EX, store_data_EX;
wire [1:0] forward_a, forward_b;
reg [31:0] alu_in1, alu_in2;
wire stall, flush_IFID, flush_IDEX;
wire [31:0] jr_src;
wire [31:0] a_ID_fwd;
wire [31:0] b_ID_fwd;


pc pc1 (clk, rst, pc_next, stall, pc_out);
instr_mem im1 (pc_out, instr_IF);
assign pc_plus4_IF = pc_out + 4;


IF_ID p1 (clk, rst, stall, flush_IFID, instr_IF, pc_plus4_IF, instr_ID, pc_plus4_ID);


instr_decoder id1 (instr_ID, opcode_ID, rs_ID, rt_ID, rd_ID, shamt_ID, funct_ID, imm_ID, j_target);
control_unit cu1 (opcode_ID, funct_ID, reg_dst_ID, reg_write_ID, mem_write_ID, mem_to_reg_ID, alu_src_ID, branch_ID, alu_op_ID);
reg_file rf1 (clk, rst, reg_write_WB, rs_ID, rt_ID, write_reg_WB, write_data, a_ID, b_ID);
stall_unit su1 (mem_to_reg_EX, rt_EX, rs_ID, rt_ID, stall);

assign a_ID_fwd = (reg_write_WB && write_reg_WB != 0 && write_reg_WB == rs_ID) ? write_data : a_ID;
assign b_ID_fwd = (reg_write_WB && write_reg_WB != 0 && write_reg_WB == rt_ID) ? write_data : b_ID;

ID_EX p2 (clk, rst, stall, flush_IDEX, rs_ID, rt_ID, rd_ID, a_ID_fwd, b_ID_fwd, imm_ID,
    reg_dst_ID, reg_write_ID, mem_write_ID, mem_to_reg_ID, alu_src_ID,
    branch_ID, alu_op_ID, pc_plus4_ID, opcode_ID, funct_ID, shamt_ID,
    rs_EX, rt_EX, rd_EX, a_EX, b_EX, imm_EX,
    reg_dst_EX, reg_write_EX, mem_write_EX, mem_to_reg_EX, alu_src_EX,
    branch_EX, alu_op_EX, pc_plus4_EX, opcode_EX, funct_EX, shamt_EX);


sign_extend se1 (imm_EX, imm_signed_EX);
assign imm_zero_ext = {16'b0, imm_EX};

forwarding_unit fd1 (rs_EX, rt_EX, write_reg_MEM, write_reg_WB, reg_write_MEM, reg_write_WB, forward_a, forward_b);

assign src_b_EX = alu_src_EX ? 
    ((opcode_EX == `OP_ANDI || opcode_EX == `OP_ORI || opcode_EX == `OP_XORI) ? imm_zero_ext : imm_signed_EX) 
    : b_EX;

always @(*) begin
    case(forward_a)
        2'b00: alu_in1 = a_EX;
        2'b01: alu_in1 = write_data;
        2'b10: alu_in1 = alu_result_MEM;
        default: alu_in1 = 32'b0;
    endcase
end

always @(*) begin
    if (alu_src_EX) alu_in2 = src_b_EX;
    else begin
        case(forward_b)
            2'b00: alu_in2 = src_b_EX;
            2'b01: alu_in2 = write_data;
            2'b10: alu_in2 = alu_result_MEM;
            default: alu_in2 = 32'b0;
        endcase
    end
end

alu alu1 (alu_in1, alu_in2, shamt_EX, alu_op_EX, alu_result_EX, zero);
assign write_reg_EX = reg_dst_EX ? rd_EX : rt_EX;
assign store_data_EX = (forward_b == 2'b10) ? alu_result_MEM :
                        (forward_b == 2'b01) ? write_data : b_EX;

EX_MEM p3 (clk, rst, alu_result_EX, store_data_EX, reg_write_EX, mem_write_EX, mem_to_reg_EX, 
    write_reg_EX, alu_result_MEM, b_MEM, reg_write_MEM, mem_write_MEM, mem_to_reg_MEM, write_reg_MEM
);


data_mem dm1 (clk, rst, mem_write_MEM, alu_result_MEM, b_MEM, mem_read_data_MEM);


MEM_WB p4 (clk, rst, alu_result_MEM, mem_read_data_MEM, reg_write_MEM, mem_to_reg_MEM, write_reg_MEM,
    alu_result_WB, mem_read_data_WB, reg_write_WB, mem_to_reg_WB, write_reg_WB);


assign write_data = mem_to_reg_WB ? mem_read_data_WB : alu_result_WB;


assign pc_branch_target = pc_plus4_EX + (imm_signed_EX << 2);
assign pc_jump_target = {pc_plus4_ID[31:28], j_target, 2'b00};
assign blez_taken = alu_in1[31] | zero;
assign bgtz_taken = ~alu_in1[31] & ~zero;

assign branch_taken = branch_EX & (
    (opcode_EX == `OP_BEQ  && zero) || 
    (opcode_EX == `OP_BNE  && ~zero) ||
    (opcode_EX == `OP_BLEZ && blez_taken) ||
    (opcode_EX == `OP_BGTZ && bgtz_taken)
);


assign jump = (opcode_ID == `OP_J);
assign jr = (opcode_ID == `OP_RTYPE && funct_ID == `FUNCT_JR);

assign pc_branch_or_seq = branch_taken ? pc_branch_target : pc_plus4_IF;
assign jr_src = (reg_write_EX && write_reg_EX == rs_ID) ? alu_result_EX :
                (reg_write_MEM && write_reg_MEM == rs_ID) ? alu_result_MEM :
                a_ID;
assign pc_next = jr ? jr_src :
                jump ? pc_jump_target :
                pc_branch_or_seq;

assign flush_IFID = branch_taken | jump | jr;
assign flush_IDEX = branch_taken;

// cpi
reg [31:0] cycle_count;
reg [31:0] instr_count;
always @(posedge clk or posedge rst) begin
    if(rst) begin
        cycle_count <= 0;
        instr_count <= 0;
    end
    else begin
        cycle_count <= cycle_count + 1;
        if(reg_write_WB || mem_write_MEM || branch_EX || jump || jr)
            instr_count <= instr_count + 1;
    end
end

// stall counter
reg [31:0] stall_count;

always @(posedge clk or posedge rst) begin
    if(rst) stall_count <= 0;
    else if(stall) stall_count <= stall_count + 1;
end

// branch count
reg [31:0] branch_count;
reg [31:0] branch_taken_count;

always @(posedge clk or posedge rst) begin
    if(rst) begin
        branch_count <= 0;
        branch_taken_count <= 0;
    end
    else begin
        if(branch_EX) branch_count <= branch_count + 1;
        if(branch_taken) branch_taken_count <= branch_taken_count + 1;
    end
end

// forward count
reg [31:0] forwardA_count;
reg [31:0] forwardB_count;

always @(posedge clk or posedge rst) begin
    if(rst) begin
        forwardA_count <= 0;
        forwardB_count <= 0;
    end
    else begin
        if(forward_a != 2'b00) forwardA_count <= forwardA_count + 1;
        if(forward_b != 2'b00) forwardB_count <= forwardB_count + 1;
    end
end

endmodule
