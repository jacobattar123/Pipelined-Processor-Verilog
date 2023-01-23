`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2021 11:34:25 AM
// Design Name: 
// Module Name: SImm
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

module SImm(IN, OUT);
        input [15:0] IN;
        output reg [31:0] OUT;  
        
        
             
        always @(IN) begin
        OUT[15:0] = IN[15:0];
        if (IN[15]) OUT[31:16] <= 16'b 1111111111111111;
        else OUT[31:16] <= 16'b 0000000000000000; 
        end

endmodule
