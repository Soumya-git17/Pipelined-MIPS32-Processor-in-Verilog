`timescale 1ns/1ps
`include "cpu.v"

module cpu_tb;

reg clk;
reg rst;

cpu dut(clk, rst);

initial clk = 0;
always #5 clk = ~clk;

initial begin
    $dumpfile("cpu_tb.vcd");
    $dumpvars(0, cpu_tb);

    rst = 1;
    #10;
    rst = 0;

    #700;

    $display("\n Final Register Values ");

    $display("R1  = %0d", dut.rf1.regfile[1]);
    $display("R2  = %0d", dut.rf1.regfile[2]);
    $display("R3  = %0d", dut.rf1.regfile[3]);
    $display("R4  = %0d", dut.rf1.regfile[4]);
    $display("R5  = %0d", dut.rf1.regfile[5]);
    $display("R6  = %0d", dut.rf1.regfile[6]);
    $display("R7  = %0d", dut.rf1.regfile[7]);
    $display("R8  = %0d", dut.rf1.regfile[8]);
    $display("R9  = %0d", dut.rf1.regfile[9]);
    $display("R10 = %0d", dut.rf1.regfile[10]);
    $display("R11 = %0d", dut.rf1.regfile[11]);
    $display("R12 = %0d", dut.rf1.regfile[12]);
    $display("R13 = %0d", dut.rf1.regfile[13]);
    $display("R14 = %0d", dut.rf1.regfile[14]);
    $display("R15 = %0d", dut.rf1.regfile[15]);
    $display("R16 = %0d", dut.rf1.regfile[16]);
    $display("R17 = %0d", dut.rf1.regfile[17]);
    $display("R18 = %0d", dut.rf1.regfile[18]);
    $display("R19 = %0d", dut.rf1.regfile[19]);
    $display("R20 = %0d", dut.rf1.regfile[20]);
    $display("R21 = %0d", dut.rf1.regfile[21]);
    $display("R22 = %0d", dut.rf1.regfile[22]);
    $display("R23 = %0d", dut.rf1.regfile[23]);
    $display("R24 = %0d", dut.rf1.regfile[24]);
    $display("R25 = %0d", dut.rf1.regfile[25]);
    $display("R26 = %0d", dut.rf1.regfile[26]);

    $finish;
end

endmodule