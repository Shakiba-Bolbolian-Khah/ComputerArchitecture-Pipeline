`timescale 1ns/1ns
module DataMemory(input[31:0] Address, input[31:0] WriteData, input MemRead, MemWrite, output[31:0] Data);
  reg[31:0] daTa;
  reg [31:0] memoryData[0:1023];
  initial begin
    memoryData[0] = 32'd9; // size-1 = 9
    memoryData[1000] = 32'd10;
    memoryData[1001] = 32'd12;
    memoryData[1002] = 32'd9;
    memoryData[1003] = 32'd15;
    memoryData[1004] = 32'd20;
    memoryData[1005] = 32'd14;
    memoryData[1006] = 32'd17;
    memoryData[1007] = 32'd99;
    memoryData[1008] = 32'd152;
    memoryData[1009] = 32'd30;
  end
  always@(posedge MemRead,posedge MemWrite)begin
    if(MemRead)
      daTa = memoryData[Address[9:0]];
    if(MemWrite)
      memoryData[Address[9:0]] = WriteData;
  end
  assign Data = daTa;
endmodule
