module forwarding_unit (
    input [4:0] ID_EX_rs,
    input [4:0] ID_EX_rt,
    input [4:0] EX_MEM_rd,
    input [4:0] MEM_WB_rd,
    input EX_MEM_reg_write,
    input MEM_WB_reg_write,
    output reg [1:0] forwardA,
    output reg [1:0] forwardB
);

always @(*) begin
    if ((EX_MEM_reg_write == 1'b1) && (EX_MEM_rd != 5'd0) && (EX_MEM_rd == ID_EX_rs)) forwardA = 2'b10;
    else if ((MEM_WB_reg_write == 1'b1) && (MEM_WB_rd != 5'd0) && (MEM_WB_rd == ID_EX_rs)) forwardA = 2'b01;
    else forwardA = 2'b00;

    if ((EX_MEM_reg_write == 1'b1) && (EX_MEM_rd != 5'd0) && (EX_MEM_rd == ID_EX_rt)) forwardB = 2'b10;
    else if ((MEM_WB_reg_write == 1'b1) && (MEM_WB_rd != 5'd0) && (MEM_WB_rd == ID_EX_rt)) forwardB = 2'b01;
    else forwardB = 2'b00;
end

endmodule