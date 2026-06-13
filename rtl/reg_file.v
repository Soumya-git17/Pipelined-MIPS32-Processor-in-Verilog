module reg_file (
    input clk, rst, reg_write,
    input [4:0] rd_addr1,   // rs from decoder
    input [4:0] rd_addr2,   // rt from decoder
    input [4:0] wr_addr,    
    input [31:0] wr_data,
    output [31:0] rd_data1,
    output [31:0] rd_data2
);

integer i;
reg [31:0] regfile [0:31];

initial begin
    for (i = 0; i < 32; i = i + 1)
        regfile[i] = 32'b0;
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        for (i = 0; i < 32; i = i + 1)
            regfile[i] = 32'b0;
    end else if (reg_write && (wr_addr != 5'b0)) regfile[wr_addr] <= wr_data;
end

assign rd_data1 = (rd_addr1 == 5'b0) ? 32'b0 : regfile [rd_addr1];
assign rd_data2 = (rd_addr2 == 5'b0) ? 32'b0 : regfile [rd_addr2];

endmodule