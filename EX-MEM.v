`timescale 1ns/1ns
module EXtoMEM(input clk, rst, input[1:0] WBIn, input[1:0] MIn, input[31:0] ALUResultIn, WriteDataIn, input[4:0] RegDstIn,
    output[1:0] WBOut, output[1:0] MOut, output[31:0] ALUResultOut, WriteDataOut, output[4:0] RegDstOut);
	reg[1:0] wbOut;
	reg[1:0] mOut;
	reg [31:0] aluResultOut, writeDataOut;
	reg [4:0] regDstOut;
	always@(posedge clk, posedge rst) begin
		{ wbOut, mOut, aluResultOut, writeDataOut, regDstOut } = 73'b0;
		if( rst ) begin
			wbOut <= 2'b0;
			mOut <= 2'b0;
			aluResultOut <= 32'b0;
			writeDataOut <= 32'b0;
			regDstOut <= 5'b0;
		end
		else begin
			wbOut <= WBIn;
			mOut <= MIn;
			aluResultOut <= ALUResultIn;
			writeDataOut <= WriteDataIn;
			regDstOut <= RegDstIn;
		end
	end
	assign WBOut = wbOut;
	assign MOut = mOut;
	assign ALUResultOut = aluResultOut;
	assign WriteDataOut = writeDataOut;
	assign RegDstOut = regDstOut;

endmodule