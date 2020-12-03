`timescale 1ns/1ns
module PC(input[31:0] PCIn, input clk, rst, PCWrite, output[31:0] PCOut);
	reg [31:0] outData;
	assign PCOut = outData;
	always@(posedge clk, posedge rst)begin
		if(rst) outData <= 32'b0;
		else
		begin
			if( PCWrite ) outData <= PCIn;
			else outData <= outData;
		end
	end
endmodule