`timescale 1ns/1ns
module RegisterFile(input clk,rst,RegWrite, input[4:0] ReadReg1,ReadReg2,WriteReg, input[31:0] WriteData, output [31:0]ReadData1,ReadData2);
  reg [31:0] Register[0:31];
	always@(negedge clk, negedge rst) begin
    if(rst) begin
      Register[0] <= 32'b0;
      Register[1] <= 32'b0;
      Register[2] <= 32'b0;
      Register[3] <= 32'b0;
      Register[4] <= 32'b0;
      Register[5] <= 32'b0;
      Register[6] <= 32'b0;
      Register[7] <= 32'b0;
      Register[8] <= 32'b0;
      Register[9] <= 32'b0;
      Register[10] <= 32'b0;
      Register[11] <= 32'b0;
      Register[12] <= 32'b0;
      Register[13] <= 32'b0;
      Register[14] <= 32'b0;
      Register[15] <= 32'b0;
      Register[16] <= 32'b0;
      Register[17] <= 32'b0;
      Register[18] <= 32'b0;
      Register[19] <= 32'b0;
      Register[20] <= 32'b0;
      Register[21] <= 32'b0;
      Register[22] <= 32'b0;
      Register[23] <= 32'b0;
      Register[24] <= 32'b0;
      Register[25] <= 32'b0;
      Register[26] <= 32'b0;
      Register[27] <= 32'b0;
      Register[28] <= 32'b0;
      Register[29] <= 32'b0;
      Register[30] <= 32'b0;
      Register[31] <= 32'b0;
    end
    if(RegWrite == 1) begin
      Register[WriteReg] <= WriteData;
    end
  end
  assign ReadData1 = Register[ReadReg1];
  assign ReadData2 = Register[ReadReg2];
endmodule