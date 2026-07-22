`timescale 1ns/1ps
`include "cpu.v"

module cpu_tb;

reg clk;
reg rst;
integer i;
real CPI;

cpu dut(clk, rst);

initial clk = 0;
always #5 clk = ~clk;

initial begin
    $dumpfile("cpu_tb.vcd");
    $dumpvars(0, cpu_tb);

    rst = 1;
    #10;
    rst = 0;
end

always @(posedge clk) begin
    if (dut.pc_out == 32'd132) begin
        repeat(4) @(posedge clk);
        $display(" Program Finished");
        $display("\nFinal Register Values");
        for(i=0;i<32;i=i+1)
            $display("R%-2d = %0d", i, dut.rf1.regfile[i]);

        if(dut.instr_count != 0) CPI = dut.cycle_count * 1.0 / dut.instr_count;
        else CPI = 0.0;

        $display("\nPerformance:");
        $display("-------");
        $display("Total Cycles      = %0d", dut.cycle_count);
        $display("Instructions      = %0d", dut.instr_count);
        $display("CPI               = %0f", CPI);
        $display("-------");
        $display("Pipeline Stalls   = %0d", dut.stall_count);
        $display("-------");
        $display("ForwardA events   = %0d", dut.forwardA_count);
        $display("ForwardB events   = %0d", dut.forwardB_count);
        $display("Total Forwarding  = %0d", dut.forwardA_count + dut.forwardB_count);        
        $display("-------");
        $display("Branch count      = %0d", dut.branch_count);
        $finish;
    end
end

endmodule
