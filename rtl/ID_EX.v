module ID_EX (
    input clk, rst, stall, flush,
    input [4:0] rs_ID, rt_ID, rd_ID,
    input [31:0] a_ID, b_ID,
    input [15:0] imm_ID,
    input reg_dst_ID, reg_write_ID, mem_write_ID, mem_to_reg_ID, alu_src_ID, branch_ID,
    input [3:0] alu_op_ID,
    input [31:0] pc_plus4_ID,
    input [5:0] opcode_ID,
    input [5:0] funct_ID,
    input [4:0] shamt_ID,
    output reg [4:0] rs_EX, rt_EX, rd_EX,
    output reg [31:0] a_EX, b_EX,
    output reg [15:0] imm_EX,
    output reg reg_dst_EX, reg_write_EX, mem_write_EX, mem_to_reg_EX, alu_src_EX, branch_EX,
    output reg [3:0] alu_op_EX,
    output reg [31:0] pc_plus4_EX,
    output reg [5:0] opcode_EX,
    output reg [5:0] funct_EX,
    output reg [4:0] shamt_EX
);

always @(posedge clk or posedge rst) begin
    if (rst || flush || stall) begin
        rs_EX <= 5'b0;
        rt_EX <= 5'b0;
        rd_EX <= 5'b0;
        a_EX <= 32'b0;
        b_EX <= 32'b0;
        imm_EX <= 16'b0;
        reg_dst_EX <= 1'b0;
        reg_write_EX <= 1'b0;
        mem_write_EX <= 1'b0;
        mem_to_reg_EX <= 1'b0;
        alu_src_EX <= 1'b0;
        branch_EX <= 1'b0;
        alu_op_EX <= 4'b0;
        pc_plus4_EX <= 32'b0;
        opcode_EX <= 6'b0;
        funct_EX <= 6'b0;
        shamt_EX <= 5'b0;
    end
    else begin
        rs_EX <= rs_ID;
        rt_EX <= rt_ID;
        rd_EX <= rd_ID;
        a_EX <= a_ID;
        b_EX <= b_ID;
        imm_EX <= imm_ID;
        reg_dst_EX <= reg_dst_ID;
        reg_write_EX <= reg_write_ID;
        mem_write_EX <= mem_write_ID;
        mem_to_reg_EX <= mem_to_reg_ID;
        alu_src_EX <= alu_src_ID;
        branch_EX <= branch_ID;
        alu_op_EX <= alu_op_ID;
        pc_plus4_EX <= pc_plus4_ID;
        opcode_EX <= opcode_ID;
        funct_EX <= funct_ID;
        shamt_EX <= shamt_ID;
    end
end

endmodule