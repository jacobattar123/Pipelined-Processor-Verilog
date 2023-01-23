`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2021 11:26:16 AM
// Design Name: 
// Module Name: InstructionMemory
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


module InstructionMemory#(parameter DW = 32)
                        (input [DW-1:0] Addr, 
                         output reg [DW-1:0] Instr);

// Declare an array of registers to hold the instruction memory data
reg [DW:0] IM [2**DW-1:0];

// Initialize the instruction memory with data from the file "im_data.mem"
initial begin
    $readmemb("im_data.mem", IM);
    end 

// Always block to continuously assign the instruction at the specified address to the output
always @(*) 
    begin
    Instr <= IM[Addr]; 
    end

endmodule

