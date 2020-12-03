`timescale 1ns/1ns
module IFtoID(input clk, rst, Flush, IFtoIDWrite, input[31:0] PCIn, instructionIn,output[31:0] PC, instruction);
  reg [31:0] pc, instr;
  always @(posedge clk, posedge rst) begin
    if (rst) begin
      pc <= 32'b0;
      instr <= 32'b0;
    end
    else begin
      if (Flush) begin
        instr <= 32'b0;
        pc <= 32'b0;
      end
      else begin
        if( IFtoIDWrite ) begin
          instr <= instructionIn;
          pc <= PCIn;
        end
        else begin
          instr <= instr;
          pc <= pc;
        end
      end
    end
  end
  assign PC = pc;
  assign instruction = instr;
endmodule