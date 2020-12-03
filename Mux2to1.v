`timescale 1ns/1ns
module Mux2to1(input Select, input [31:0]In1,In2, output [31:0]MuxOut);
  assign MuxOut = Select ? In2 : In1; //input 0 goes first
endmodule
