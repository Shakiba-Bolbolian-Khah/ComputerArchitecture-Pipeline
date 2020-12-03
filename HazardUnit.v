`timescale 1ns/1ns
module HazardUnit(input [4:0] IF_ID_Rs, IF_ID_Rt, ID_EX_Rt, input ID_EX_MemRead, output IFtoIDWrite, PCWrite, ControlSel);
 reg  if_to_id_write, pc_write, control_sel;
	
	always @(IF_ID_Rs, IF_ID_Rt, ID_EX_Rt, ID_EX_MemRead) begin
		if_to_id_write = 1'b1;
		pc_write = 1'b1;
		control_sel = 1'b1;
		if((ID_EX_MemRead == 1'b1) && (ID_EX_Rt != 5'b00000) && ((ID_EX_Rt == IF_ID_Rs)||(ID_EX_Rt == IF_ID_Rt))) begin
			if_to_id_write = 1'b0;
		  pc_write = 1'b0;
		  control_sel = 1'b0;
		end
	end
	
	assign IFtoIDWrite = if_to_id_write;
	assign PCWrite = pc_write;
	assign ControlSel = control_sel;
endmodule