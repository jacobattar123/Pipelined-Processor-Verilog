`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2021 11:38:30 AM
// Design Name: 
// Module Name: Mux2to1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Mux2to1#(parameter DW = 32)
                (input [DW-1:0] In1, In2, 
                 input Sel,
                 output [DW-1:0] MuxOut);
 reg [DW-1:0] temp;
 
 assign MuxOut = temp;
 
 always @(*) begin
    case(Sel) 
    1'b0:       temp = In1; 
    1'b1:       temp = In2;
    default:    temp = In1;
    endcase
 end
                 
endmodule
