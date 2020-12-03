`timescale 1ns/1ns
module ALU(input [2:0]ALUOp, input [31:0]In1,In2, output [31:0]ALUResult);
 	reg [31:0] aluResult;
 	always@(ALUOp,In1,In2) begin
    aluResult = 32 'b0;
    case(ALUOp)
        3'b000: begin //nop
          aluResult = 32'b0; 
        end
			  3'b001: begin //add
				  aluResult = In1 + In2;
			  end
			  3'b010: begin //sub
				  aluResult = In1 - In2;
			  end
			  3'b011: begin //and
				  aluResult = In1 & In2;
			  end
			  3'b100: begin //or
				  aluResult = In1 | In2;
			  end
			  3'b101: begin //slt
				  aluResult = ( In1 < In2 )? 32'h00000001 : 32'b0;
			  end
			  default: begin
			    aluResult = 32'b0;
			  end
		endcase
	end
	assign ALUResult = aluResult;
endmodule