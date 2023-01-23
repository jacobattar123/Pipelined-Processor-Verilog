`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2021 07:42:32 PM
// Design Name: 
// Module Name: HazardUnit
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


module HazardUnit( input  [4:0] RsE, RtE, RsD, RtD,
                   input  [4:0] WriteRegE, WriteRegM, WriteRegW,
		           input  BranchD, Clk, MemToRegE, RegWriteE, MemToRegM, RegWriteM,        
                          RegWriteW,
                   output reg ForwardAD, ForwardBD,
  		           output wire StallF, StallD, 
                          FlushE, 
                   output reg [1:0] ForwardAE, ForwardBE);
                   
                   reg lwstall, branchstall;
                   
                   
                  
 always @(*) 
    begin
        
        if (((RsE) !=0) && (RsE == WriteRegM) && RegWriteM) 
        ForwardAE = 2;
        
        else if ((RsE != 0) && (RsE == WriteRegW) && RegWriteW) 
        ForwardAE = 1;
        
        else 
        ForwardAE = 0;

        
        if (((RtE) !=0) && (RtE == WriteRegM) && RegWriteM) 
        ForwardBE = 2'b10;
        
        else if ((RtE != 0) && (RtE == WriteRegW) && RegWriteW) 
        ForwardBE = 2'b01;
       
        else 
        ForwardBE = 2'b00;
        
        ForwardAD = ((RsD != 0) && (RsD == WriteRegM) && RegWriteM);
        
        ForwardBD = ((RtD != 0) && (RtD == WriteRegM) && RegWriteM);
        
        if((BranchD && RegWriteE && (WriteRegE == RsD || WriteRegE == RtD)) || 
            (BranchD && MemToRegM && ((WriteRegM == RsD) || (WriteRegM == RtD)))) branchstall = 1;
        else branchstall = 0;    
                
        if  (((RsD == RtE) || (RtD == RtE)) && MemToRegE) lwstall = 1 ;
        else lwstall = 0; 
        
                    
    end
  

assign StallD = (lwstall || branchstall);
assign StallF = (lwstall || branchstall);
assign FlushE = (lwstall || branchstall);
   
endmodule
