`timescale 1ns/1ns
module Mux3to1(input[1:0] Select, input [31:0]In1,In2,In3, output [31:0]MuxOut);
  assign MuxOut = (Select == 2'b00 )? In1 :
                  (Select == 2'b01 )? In2 :
                  (Select == 2'b10 )? In3 : 31'bz;
endmodule

