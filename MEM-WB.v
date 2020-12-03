`timescale 1ns/1ns
module MEMtoWB(input clk, rst, input[1:0] WBIn, input[31:0] MemReadDataIn, ALUResultIn, input[4:0] RegDstIn,
    output[1:0] WBOut, output[31:0] MemReadDataOut, ALUResultOut, output[4:0] RegDstOut);
	reg[1:0] wbOut;
	reg [31:0] aluResultOut, memReadDataOut;
	reg [4:0] regDstOut;
	always@(posedge clk, posedge rst) begin
		{ wbOut, aluResultOut, memReadDataOut, regDstOut } = 71'b0;
		if( rst ) begin
			wbOut <= 2'b0;
			aluResultOut <= 32'b0;
			memReadDataOut <= 32'b0;
			regDstOut <= 5'b0;
		end
		else begin
			wbOut <= WBIn;
			aluResultOut <= ALUResultIn;
			memReadDataOut <= MemReadDataIn;
			regDstOut <= RegDstIn;
		end
	end
	assign WBOut = wbOut;
	assign ALUResultOut = aluResultOut;
	assign MemReadDataOut = memReadDataOut;
	assign RegDstOut = regDstOut;

endmodule
