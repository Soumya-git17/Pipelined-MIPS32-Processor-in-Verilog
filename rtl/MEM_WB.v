module MEM_WB (
    input clk, rst,
    input [31:0] alu_result_MEM, mem_read_data_MEM,
    input reg_write_MEM, mem_to_reg_MEM,
    input [4:0] write_reg_MEM,
    output reg [31:0] alu_result_WB, mem_read_data_WB,
    output reg reg_write_WB, mem_to_reg_WB,
    output reg [4:0] write_reg_WB
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        alu_result_WB <= 32'b0;
        mem_read_data_WB <= 32'b0;
        reg_write_WB <= 1'b0;
        mem_to_reg_WB <= 1'b0;
        write_reg_WB <= 5'b0;
    end
    else begin
        alu_result_WB <= alu_result_MEM;
        mem_read_data_WB <= mem_read_data_MEM;
        reg_write_WB <= reg_write_MEM;
        mem_to_reg_WB <= mem_to_reg_MEM;
        write_reg_WB <= write_reg_MEM;
    end
end

endmodule