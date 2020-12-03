`timescale 1ns/1ns
module BranchForwardingUnit(input [4:0] IF_ID_Rs, IF_ID_Rt, EX_MEM_Rd, input EX_MEM_RegWrite, output BranchForwardA, BranchForwardB);
 reg br_forward_a;
 reg br_forward_b;
	
	always @(IF_ID_Rs, IF_ID_Rt, EX_MEM_Rd, EX_MEM_RegWrite) begin
		br_forward_a = 0;
		br_forward_b = 0;
		if((EX_MEM_RegWrite == 1'b1) && (EX_MEM_Rd != 5'b00000) && (EX_MEM_Rd == IF_ID_Rs)) begin
			br_forward_a = 1;
		end
		if((EX_MEM_RegWrite == 1'b1) && (EX_MEM_Rd != 5'b00000) && (EX_MEM_Rd == IF_ID_Rt)) begin
			br_forward_b = 1;
		end
	end
	
	assign BranchForwardA = br_forward_a;
	assign BranchForwardB = br_forward_b;
endmodule