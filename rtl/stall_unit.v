module stall_unit (
    input mem_to_reg_EX,
    input [4:0] rt_EX, rs_ID, rt_ID,
    output stall
);

assign stall = mem_to_reg_EX && ((rt_EX == rs_ID) || (rt_EX == rt_ID));

endmodule