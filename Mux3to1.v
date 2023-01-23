`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2021 11:39:00 AM
// Design Name: 
// Module Name: Mux3to1
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


module Mux3to1#(parameter DW = 32)
                (input [DW-1:0] In1, In2, In3,
                 input [1:0] Sel,
                 output [DW-1:0] MuxOut);
 reg [DW-1:0] temp;
 
 assign MuxOut = temp;
 
 always @(*) begin
    case(Sel) 
    2'b00:       temp = In1; 
    2'b01:       temp = In2;
    2'b10:       temp = In3;   
    default:     temp = In1;
    endcase
 end
                 
endmodule
