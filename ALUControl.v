`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2021 02:24:12 PM
// Design Name: 
// Module Name: ALUControl
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


module ALUControl(input [1:0] ALUOp, input [5:0] Funct, output reg [2:0] ALU_Control);

wire [8:0] ALUControlIn = {ALUOp,Funct};

always @(ALUControlIn) begin
    
    casex (ALUControlIn)
     8'b00xxxxxx : ALU_Control = 3'b000; //add
     8'b01xxxxxx : ALU_Control = 3'b010; //sub
     8'b1x100010 : ALU_Control = 3'b010; //sub
     8'b1x100000 : ALU_Control = 3'b000; //add
     8'b1x000000 : ALU_Control = 3'b101; //sll
     8'b1x000100 : ALU_Control = 3'b110; //sllv
     8'b1x000111 : ALU_Control = 3'b111; //slrav
     
     default: ALU_Control=3'b000;
     endcase  
end

endmodule