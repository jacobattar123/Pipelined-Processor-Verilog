`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2021 01:06:35 PM
// Design Name: 
// Module Name: tb_toplevel
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


module tb_toplevel();

wire [31:0] RF [31:0]   = RegisterFile.RF;
wire [31:0] DM [2**9-1:0]  = DataMemory.DM;
reg  [15:0] cnt;

//wire [31:0] PCF         = toplevel.PCF;
//wire [31:0] PCNext      = toplevel.PCNext;
//wire [31:0] PCPlus1F    = toplevel.PCPlus1F;
//wire [31:0] one         = toplevel.one;
wire [31:0] InstrF      = toplevel.InstrF;
wire [31:0] InstrD      = toplevel.InstrD;
wire [2:0]  ALUContr    = toplevel.ALUControlE;
wire [31:0] ALUOutE     = toplevel.ALUOutE;
wire [31:0] ALUResult   = ALU. ALUResult;
wire [31:0] ALUOutM     = toplevel.ALUOutM;
wire [31:0] ALUOutW     = toplevel.ALUOutW;
wire        ALUSrcE     = toplevel.ALUSrcE;

wire [31:0] ALUin1      = ALU.ALUIn1;
wire [31:0] ALUin2      = ALU.ALUIn2;
wire [31:0] SrcAE       = toplevel.SrcAE;
wire [31:0] SrcBE       = toplevel.SrcBE;

wire        MemWriteE   = toplevel.MemWriteE;
wire        MemToRegW   = toplevel.MemToRegW;
wire        MemWriteM   = toplevel.MemWriteM;
wire        MemWriteD   = toplevel.MemWriteD;
wire        MemWriteE   = toplevel.MemWriteE;
wire [31:0] WriteDataM  = toplevel.WriteDataM;
wire [31:0] WriteDataE  = toplevel.WriteDataE;
wire [31:0] DMWD        = DataMemory.DMWD;
wire [31:0] DMWA        = DataMemory.DMA;
wire [31:0] DMReadOut   = toplevel.DMReadOut;
wire [31:0] ReadDataW   = toplevel.ReadDataW;
wire [31:0] ResultW     = toplevel.ResultW;

wire [31:0] R1DOut       = toplevel.R1DOut;




wire [31:0] RFWD        = RegisterFile.RFWD;
wire        RegWriteW   = toplevel.RegWriteW;
wire        RegWriteM   = toplevel.RegWriteM;
wire        RegWriteE   = toplevel.RegWriteE;
wire        RegWriteD   = toplevel.RegWriteD;
wire [4:0]  WriteRegE   = toplevel.WriteRegE;
wire [4:0]  WriteRegM   = toplevel.WriteRegM;
wire [4:0]  WriteRegW   = toplevel.WriteRegW;
wire [4:0]  RFWA        = RegisterFile.RFWA;
wire [4:0]  RFRA1       = RegisterFile.RFRA1;
wire [4:0]  RFRA2       = RegisterFile.RFRA2;

wire [31:0] RFRD1       = RegisterFile.RFRD1;
wire [31:0] RFRD2       = RegisterFile.RFRD2;
wire [31:0] RFRD1Out      = toplevel.RFRD1Out;
wire [31:0] RFRD2Out      = toplevel.RFRD2Out;

wire [1:0]  ForwardAE   = toplevel.ForwardAE;
wire [1:0]  tempAE   = toplevel.tempAE;
wire [1:0]  ForwardBE   = toplevel.ForwardBE;
wire lwstall            = HazardUnit.lwstall;
wire branchstall            = HazardUnit.branchstall;




wire StallF             = toplevel.StallF;
wire StallD             = toplevel.StallD;
wire FlushE             = toplevel.FlushE;
reg Clk;


initial begin

cnt = 0;

end



always begin
#5
Clk = 1;
cnt = cnt + 1;
#5 
Clk = 0;

end

toplevel dut(.Clk(Clk));


endmodule
