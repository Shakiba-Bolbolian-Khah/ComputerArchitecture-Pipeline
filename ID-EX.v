`timescale 1ns/1ns
module IDtoEX(input clk, rst, input[1:0] WBIn, input[1:0] MIn, input[4:0] EXIn, input[31:0] ReadData1In, ReadData2In, LdAddrIn, input[4:0] RtIn, RdIn, RsIn,
    output[1:0] WBOut, output[1:0] MOut, output[4:0] EXOut, output[31:0] ReadData1Out, ReadData2Out, LdAddrOut, output[4:0] RtOut, RdOut, RsOut);
	reg[1:0] wbOut;
	reg[1:0] mOut;
	reg[4:0] exOut;
	reg [31:0] readData1Out, readData2Out, ldAddrOut;
	reg [4:0] rtOut, rsOut, rdOut;
	always@(posedge clk, posedge rst) begin
		{ wbOut, mOut, exOut, readData1Out,readData2Out,ldAddrOut, rtOut, rsOut, rdOut} = 120'b0;
		if( rst ) begin
			wbOut <= 2'b0;
			mOut <= 2'b0;
			exOut <= 5'b0;
			readData1Out <= 32'b0;
			readData2Out <= 32'b0;
			ldAddrOut <= 32'b0;
			rtOut <= 5'b0;
			rsOut <= 5'b0;
			rdOut <= 5'b0;
		end
		else begin
			wbOut <= WBIn;
			mOut <= MIn;
			exOut <= EXIn;
			readData1Out <= ReadData1In;
			readData2Out <= ReadData2In;
			ldAddrOut <= LdAddrIn;
			rtOut <= RtIn;
			rsOut <= RsIn;
			rdOut <= RdIn;
		end
	end
	assign WBOut = wbOut;
	assign MOut = mOut;
	assign EXOut = exOut;
	assign ReadData1Out = readData1Out;
	assign ReadData2Out = readData2Out;
	assign LdAddrOut = ldAddrOut;
	assign RtOut = rtOut;
	assign RsOut = rsOut;
	assign RdOut = rdOut;

endmodule