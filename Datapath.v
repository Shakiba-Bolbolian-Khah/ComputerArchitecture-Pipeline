`timescale 1ns/1ns
module Datapath(input clk,rst,Flush, input [8:0] ControlSignals, input [1:0] PCSrc, output [5:0] Opcode,func, output compareResult);
  wire [31:0] PCIn,PCOut,Instr,newPC,ID_PC,ID_Instr,ReadData1,ReadData2,BranchAddr,EX_ReadData1,EX_ReadData2,EX_LdAddr,SrcA,SrcB,LDSrcB,ALUResult,BranchReadData1,BranchReadData2,MEM_ALU,MEM_WriteData,MEM_ReadData,WB_ALU,WB_WriteData,WB_ReadData;
  wire [8:0] IDtoEX_ctrl;
  wire PCWrite,HazardSel,IFtoIDWrite,BranchForwardA,BranchForwardB;
  wire [1:0] EX_WB,EX_M,ForwardA,ForwardB,MEM_WB,MEM_M,WB_WB;
  wire [4:0] EX_EX,EX_Rt,EX_Rd,EX_Rs,EX_DstReg,MEM_DstReg,WB_DstReg;
  wire [15:0] SE;
  assign SE =  ID_Instr[15] ? 16'h1111 : 16'b0;
  assign Opcode = ID_Instr[31:26];
  assign func = ID_Instr[5:0];
  PC pc(PCIn,clk,rst,PCWrite, PCOut);
  
  Adder32 pcAdder(32'h00000004,PCOut, newPC);
  
  Mux3to1 PCMux(PCSrc,newPC,{newPC[31:28],ID_Instr[25:0],2'b0},BranchAddr, PCIn);
  
  IFtoID IF_ID(clk,rst,Flush,IFtoIDWrite,newPC,Instr, ID_PC,ID_Instr);
  
  InstructionMemory instMem(PCOut, Instr);
  
  RegisterFile regFile(clk,rst,WB_WB[1],ID_Instr[25:21],ID_Instr[20:16],WB_DstReg,WB_WriteData, ReadData1,ReadData2);
  
  Adder32 branchAdder(ID_PC,{SE[13:0],ID_Instr[15:0],2'b0}, BranchAddr);
  
  HazardUnit hazardUnit(ID_Instr[25:21],ID_Instr[20:16],EX_Rt,EX_M[1], IFtoIDWrite,PCWrite,HazardSel);
  
  Mux9bit2to1 hazardMux(HazardSel,9'b0,ControlSignals, IDtoEX_ctrl);
  
  BranchComparator brComp(BranchReadData1,BranchReadData2, compareResult);
  
  BranchForwardingUnit brForwardingUnit(ID_Instr[25:21],ID_Instr[20:16],MEM_DstReg,MEM_WB[1], BranchForwardA,BranchForwardB);
  
  Mux2to1 brCompIn1(BranchForwardA,ReadData1,MEM_ALU, BranchReadData1);

  Mux2to1 brCompIn2(BranchForwardB,ReadData2,MEM_ALU, BranchReadData2);
  
  IDtoEX ID_EX(clk,rst,IDtoEX_ctrl[8:7],IDtoEX_ctrl[1:0],IDtoEX_ctrl[6:2],ReadData1,ReadData2,{SE,ID_Instr[15:0]},ID_Instr[20:16],ID_Instr[15:11],ID_Instr[25:21], EX_WB,EX_M,EX_EX,EX_ReadData1,EX_ReadData2,EX_LdAddr,EX_Rt,EX_Rd,EX_Rs);
  
  Mux3to1 ALUsrcA(ForwardA,EX_ReadData1,WB_WriteData,MEM_ALU, SrcA);
  
  Mux3to1 ALUsrcB(ForwardB,EX_ReadData2,WB_WriteData,MEM_ALU, SrcB);
  
  Mux2to1 ALUsrcBorLD(EX_EX[4],SrcB,EX_LdAddr, LDSrcB);
  
  ALU alu(EX_EX[3:1],SrcA,LDSrcB, ALUResult);
  
  Mux5bit2to1 regMux(EX_EX[0],EX_Rt,EX_Rd, EX_DstReg);
  
  ForwardingUnit forwardingUnit(EX_Rs,EX_Rt,MEM_DstReg,WB_DstReg,MEM_WB[1],WB_WB[1],ForwardA,ForwardB);
  
  EXtoMEM EX_MEM(clk,rst,EX_WB,EX_M,ALUResult,SrcB,EX_DstReg, MEM_WB,MEM_M,MEM_ALU,MEM_WriteData,MEM_DstReg);
  
  DataMemory dataMem(MEM_ALU,MEM_WriteData,MEM_M[1],MEM_M[0], MEM_ReadData);
  
  MEMtoWB MEMORY_WB(clk,rst,MEM_WB,MEM_ReadData,MEM_ALU,MEM_DstReg, WB_WB,WB_ReadData,WB_ALU,WB_DstReg);
  
  Mux2to1 MemToRegMux(WB_WB[0],WB_ALU,WB_ReadData, WB_WriteData);
endmodule