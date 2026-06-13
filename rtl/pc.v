module pc(
    input clk, rst,
    input [31:0] pc_next,
    input stall,
    output reg [31:0] pc_out
);


always @(posedge clk or posedge rst) begin
    if (rst) pc_out <= 32'd0;
    else if (stall) pc_out <= pc_out;
    else pc_out <= pc_next;
end

endmodule