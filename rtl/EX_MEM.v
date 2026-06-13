module EX_MEM (
    input clk, rst,
    input [31:0] alu_result_EX, b_EX,
    input reg_write_EX, mem_write_EX, mem_to_reg_EX,
    input [4:0] write_reg_EX,
    output reg [31:0] alu_result_MEM, b_MEM,
    output reg reg_write_MEM, mem_write_MEM, mem_to_reg_MEM,
    output reg [4:0] write_reg_MEM
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        alu_result_MEM <= 32'b0;
        b_MEM <= 32'b0;
        reg_write_MEM <= 1'b0;
        mem_write_MEM <= 1'b0;
        mem_to_reg_MEM <= 1'b0;
        write_reg_MEM <= 5'b0;
    end
    else begin
        alu_result_MEM <= alu_result_EX;
        b_MEM <= b_EX;
        reg_write_MEM <= reg_write_EX;
        mem_write_MEM <= mem_write_EX;
        mem_to_reg_MEM <= mem_to_reg_EX;
        write_reg_MEM <= write_reg_EX;
    end
end

endmodule