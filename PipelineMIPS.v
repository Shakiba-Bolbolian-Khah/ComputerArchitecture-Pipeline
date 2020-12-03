`timescale 1ns/1ns
module MIPS(input clk, rst);
  wire Flush;
  wire [8:0] ControlSignals;
  wire [1:0] PCSrc;
  wire [5:0] Opcode,func;
  wire compareResult;  
  Datapath datapath(clk,rst,Flush,ControlSignals,PCSrc, Opcode,func,compareResult);
  ControlUnit controlUnit(Opcode,func,compareResult, ControlSignals,PCSrc,Flush);
endmodule