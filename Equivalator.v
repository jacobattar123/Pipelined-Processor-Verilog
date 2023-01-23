`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2021 05:40:26 PM
// Design Name: 
// Module Name: Equivalator
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


module Equivalator#(DW = 32)(input [DW-1:0] In1, In2,
                             output reg Equal);
      
      reg [DW:0]temp;
                     
       always @* begin
       
       temp <= In1 - In2;
       
       if (temp == 0) Equal = 1;
       else Equal = 0;
     
       end
                             
                             
endmodule
