`timescale 1ns/1ns
module TB();
  reg clk = 0, rst = 0;
  MIPS Pipeline(clk,rst);
  initial begin
    repeat(500) #10 clk = ~clk;
  end
  initial begin
    rst = 1;
    #5
    rst = 0;
  end
endmodule