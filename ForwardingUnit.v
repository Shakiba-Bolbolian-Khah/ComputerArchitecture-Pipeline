`timescale 1ns/1ns
module ForwardingUnit(input [4:0] ID_EX_Rs, ID_EX_Rt, EX_MEM_Rd, MEM_WB_Rd, input EX_MEM_RegWrite, MEM_WB_RegWrite, output [1:0] ForwardA, ForwardB);
 reg [1:0] forward_a;
 reg [1:0] forward_b;
	
	always @(ID_EX_Rs, ID_EX_Rt, EX_MEM_Rd, MEM_WB_Rd, EX_MEM_RegWrite, MEM_WB_RegWrite) begin
		forward_a = 2'b00;
		forward_b = 2'b00;
		if((EX_MEM_RegWrite == 1'b1) && (EX_MEM_Rd != 5'b00000) && (EX_MEM_Rd == ID_EX_Rs)) begin
			forward_a = 2'b10;
		end else if((MEM_WB_RegWrite == 1'b1) && (MEM_WB_Rd != 5'b00000) && (MEM_WB_Rd == ID_EX_Rs)) begin
			forward_a = 2'b01;
		end
		if((EX_MEM_RegWrite == 1'b1) && (EX_MEM_Rd != 5'b00000) && (EX_MEM_Rd == ID_EX_Rt)) begin
			forward_b = 2'b10;
		end else if((MEM_WB_RegWrite == 1'b1) && (MEM_WB_Rd != 5'b00000) && (MEM_WB_Rd == ID_EX_Rt)) begin
			forward_b = 2'b01;
		end
	end
	
	assign ForwardA = forward_a;
	assign ForwardB = forward_b;
endmodule