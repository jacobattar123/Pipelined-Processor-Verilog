`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2021 06:05:06 PM
// Design Name: 
// Module Name: DataMemory
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


module DataMemory#(parameter AW = 9,
                           DW = 32)
                          (input Clk, DMWE,
                           input [31:0] DMA, 
                           input [DW-1:0] DMWD,
                           output [DW-1:0] DMRD);
           reg [AW-1:0] addrq;                
           reg [DW-1:0] DM [2**AW-1:0];
           
           always @(posedge Clk) begin
           if (DMWE) DM[DMA] <= DMWD;        
     
           end
           
           assign DMRD = DM[DMA];
           
 initial begin
    $readmemb("dm_data.mem", DM);
    end           
           
endmodule
