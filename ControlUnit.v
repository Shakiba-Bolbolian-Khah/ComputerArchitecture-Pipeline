`timescale 1ns/1ns
module ControlUnit(input [5:0] Opcode,func, input compareResult, output [8:0] ControlSignals, output [1:0] PCSrc, output Flush);
	reg [2:0] aluop;
	reg [1:0] pcsrc;
	reg alusrc,regDst,memRead,memWrite,regWrite,memToreg;
	reg flush;
  
	always@(Opcode,func,compareResult) begin
		aluop = 3'b000; //nop
		pcsrc = 2'b00;
		{alusrc,regDst,memRead,memWrite,regWrite,memToreg,flush} = 7'b0;
		case(Opcode)
		    6'b000000: begin //R-Type
				  case(func)
				    6'b100000: begin //add
				      aluop = 3'b001; //add
				      alusrc = 0;
				      regDst = 1;
				      memToreg = 0;
				      regWrite = 1;
				    end
				    6'b100010: begin //sub
				      aluop = 3'b010; //sub
				      alusrc = 0;
				      regDst = 1;
				      memToreg = 0;
				      regWrite = 1;
				    end
				    6'b100100: begin //and
				      aluop = 3'b011; //and
				      alusrc = 0;
				      regDst = 1;
				      memToreg = 0;
				      regWrite = 1;
				    end
				    6'b100101: begin //or
				      aluop = 3'b100; //or
				      alusrc = 0;
				      regDst = 1;
				      memToreg = 0;
				      regWrite = 1;
				    end
				    6'b101010: begin //slt
				      aluop = 3'b101; //slt
				      alusrc = 0;
				      regDst = 1;
				      memToreg = 0;
				      regWrite = 1;
				    end
				    default: begin
				      aluop = 3'b000; //nop
				    end
				  endcase
			  end
			  6'b000100: begin //beq
				  aluop = 3'b000; //nop
				  if (compareResult == 1) begin
				    flush = 1;
				    pcsrc = 2'b10;
				  end
				  else begin
				    flush = 0;
				    pcsrc = 2'b00;
				  end
			  end
			  6'b000101: begin //bne
				  aluop = 3'b000; //nop
				  if (compareResult == 0) begin
				    flush = 1;
				    pcsrc = 2'b10;
				  end
				  else begin
				    flush = 0;
				    pcsrc = 2'b00;
				  end
			  end
			  6'b000010: begin //jump
				  aluop = 3'b000; //nop
				  flush = 1;
				  pcsrc = 2'b01;
			  end
			  6'b100011: begin //lw
				  aluop = 3'b001; //add
				  alusrc = 1;
				  regDst = 0;
				  memRead = 1;
				  memToreg = 1;
				  regWrite = 1;
			  end
			  6'b101011: begin //sw
				  aluop = 3'b001; //add
				  alusrc = 1;
				  memWrite = 1;
			  end
			  default: begin
			    aluop = 3'b000; //nop
		      pcsrc = 2'b00;
		      {alusrc,regDst,memRead,memWrite,regWrite,memToreg,flush} = 7'b0;
		    end
		endcase
	end
	
	assign ControlSignals = {regWrite,memToreg,alusrc,aluop,regDst,memRead,memWrite};
	assign Flush = flush;
	assign PCSrc = pcsrc;
endmodule