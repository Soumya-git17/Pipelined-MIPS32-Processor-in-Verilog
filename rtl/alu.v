`include "parameters.v"

module alu(
    input [31:0] src_a, src_b,
    input [4:0] shamt,      // shift operations
    input [3:0] alu_op,
    output reg [31:0] result,
    output zero
);

assign zero = (result == 32'b0);

always @(*) begin
    case(alu_op)
        `ALU_ADD: result = src_a + src_b;
        `ALU_SUB: result = src_a - src_b;
        `ALU_AND: result = src_a & src_b;
        `ALU_OR : result = src_a | src_b;
        `ALU_XOR: result = src_a ^ src_b;
        `ALU_NOR: result = ~(src_a | src_b);
        `ALU_SLT: result = ($signed(src_a) < $signed(src_b)) ? 32'd1 : 32'd0;
        `ALU_SLTU:result = (src_a < src_b) ? 32'd1 : 32'd0;
        `ALU_SLL: result = src_b << shamt;
        `ALU_SRL: result = src_b >> shamt;
        `ALU_SRA: result = $signed(src_b) >>> shamt;
        `ALU_LUI: result = {src_b[15:0] , 16'b0};
        default: result = 32'b0;
    endcase
end

endmodule