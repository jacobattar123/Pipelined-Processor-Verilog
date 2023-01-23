`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2021 11:03:12 AM
// Design Name: 
// Module Name: ProgramCounter
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


module ProgramCounter#(parameter  DW = 32)
                                  (input Clk, PCReset, PCWrite,
                                  input [DW-1:0]PCNext,
                                  output reg [DW-1:0] PCResult);
                                  
       initial begin
            PCResult <= 5'b0;
       end
       
       always @(posedge Clk)
            begin
            if (PCReset == 1) PCResult <= 5'b0; 
            
            else begin
            //if PCWrite, then program will output the next instruction
                if (PCWrite == 1)
                PCResult <= PCNext;  
            end
            end
endmodule            
            