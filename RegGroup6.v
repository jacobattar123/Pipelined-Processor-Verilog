`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2021 03:32:18 PM
// Design Name: 
// Module Name: RegGroup6
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


module RegGroup6#(parameter DW = 32)
          (input Clk, Rst, En,
          input [DW-1:0] Din1, Din2, Din3, Din4, Din5,
          input [2:0] Din6,
          output reg [DW-1:0]Dout1, Dout2, Dout3, Dout4, Dout5, 
          output reg [2:0] Dout6);
          
always @( posedge Clk) 
    begin
    if (Rst) begin
        Dout1 <= DW-1'bx;
        Dout2 <= DW-1'bx;
        Dout3 <= DW-1'bx;
        Dout4 <= DW-1'bx;
        Dout5 <= DW-1'bx;
        Dout6 <= 3'b000;
         end
    else 
        begin
        if (En) 
        Dout1 <= Din1;
        Dout2 <= Din2;
        Dout3 <= Din3;
        Dout4 <= Din4;
        Dout5 <= Din5;
        Dout6 <= Din6;
           
        end       
    end       
       
endmodule
