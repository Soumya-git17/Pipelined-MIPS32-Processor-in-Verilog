module instr_mem(
    input [31:0] addr,
    output reg [31:0] instr
);

reg [31:0] rom [0:255];

initial begin
    $readmemh("program3.mem", rom);    
end

always @(*) begin
    instr <= rom[addr[31:2]];
end

endmodule