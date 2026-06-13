module data_mem(
    input clk, rst, mem_write,
    input [31:0] addr,
    input [31:0] write_data,
    output [31:0] read_data
);

integer i;
reg [31:0] mem [0:1023];

initial begin
    for (i = 0 ; i < 1024 ; i = i + 1) mem[i] = 32'b0;
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        for (i = 0 ; i < 1024 ; i = i + 1) mem[i] = 32'b0;
    end else if (mem_write) mem[addr[11:2]] <= write_data;
end

assign read_data = mem[addr[11:2]];

endmodule