`timescale 1ns/1ns
module BranchComparator(input [31:0] ReadData1, ReadData2, output CompareResult);
  assign CompareResult = ( ReadData1 == ReadData2 ) ? 1 : 0; // NOTICE: for bne we should use not(output) !!!
endmodule
