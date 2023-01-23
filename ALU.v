`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2021 11:31:25 AM
// Design Name: 
// Module Name: ALU
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


module ALU(input [31:0] ALUIn1, ALUIn2,
            input [2:0] ALUSel,
            input [4:0] Shamt, 
            output Zero, 
            output wire [31:0] ALUOut);
            
reg z;           
reg [31:0] ALUResult;
assign ALUOut = ALUResult;            
assign Zero = z;  
always @ * begin

    case(ALUSel)
         3'b000: ALUResult <= ALUIn1 + ALUIn2;   
         3'b010: ALUResult <= ALUIn1 - ALUIn2;
         3'b011: ALUResult <= ALUIn1 & ALUIn2;
         3'b100: ALUResult <= ALUIn1 | ALUIn2; 
         3'b101: ALUResult <= ALUIn2 << Shamt; 
         3'b110: ALUResult <= ALUIn2 << ALUIn1; //sllv rt shifted by rs
         3'b111: ALUResult <= ALUIn2 >>> ALUIn1;
         default: ALUResult <= 32'bx;
endcase
    if (ALUResult == 0) z = 1;
     else z = 0;
end  
     
   
            
endmodule
