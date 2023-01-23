`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2022 09:56:23 AM
// Design Name: 
// Module Name: Register
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


module Register#(parameter DW = 5)
          (input Clk, Rst, En,
          input [DW-1:0] Din,
          output reg [DW-1:0]Dout);

always @( posedge Clk) 
    begin
        if (Rst) Dout <= 0;
        else begin
            if (!En) Dout <= Dout;
            else Dout <= Din;
        end       
                     
    end       
          
endmodule
