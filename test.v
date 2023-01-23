`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2021 11:21:59 AM
// Design Name: 
// Module Name: test
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


module test#(parameter DW = 32)(input Clk, Rst);

reg PCWrite = 1;
reg one = 32'h1;
reg true = 1'b1;
wire [DW-1:0]   PCNext, 
                PCF, 
                PCPlus1F, PCPlus1D, 
                InstrF, InstrD, 
                SignImmD, SignImmE,
                PCBranchD,
                M2Out, M3Out,
                ALUOutM, ALUOutE,
                R1DOut, R2DOut, RsE, RtE, RdE, 
                ResultW,
                SrcAE, SrcBE;
                
                
                
wire    ForwardAD, ForwardBD, 
        StallF, StallD, 
        PCSrcD, 
        BranchD,
        EqualD,
        RegDstD, RegDstE,
        ALUSrcD, ALUSrcE,
        MemWriteD, MemWriteE,
        MemToRegD, MemToRegE,
        RegWriteD, RegWriteE;
        
        
        
wire [1:0] ForwardAE, ForwardBE;                   
wire [2:0] ALUControlD, ALUControlE;



assign PCSrcD = EqualD && BranchD;




ProgramCounter      PCDUT(.Clk(Clk), .PCReset(Rst), .PCWrite(!(StallF)), 
                    .PCNext(PCNext), .PCResult(PCF));
                        
InstructionMemory   IMDUT(.Addr(PCF), .Instr(InstrF));

Adder               Adder1DUT(.AddIn1(PCF), .AddIn2(one), .AddOut(PCPlus1F));

Adder               Adder2DUT(.AddIn1(SignImmD), .AddIn2(PCPlus1D), .AddOut(PCBranchD));                    


Register            RegInstrFDUT(.Clk(Clk), .Rst(PCSrcD), .En(!(StallD)), 
                    .Din(InstrF), .Dout(InstrD));
                    
Register            RegPCPlus1FDUT(.Clk(Clk), .Rst(PCSrcD), .En(!(StallD)),
                    .Din(PCPlus1F), .Dout(PCPlus1D));
RegGroup6           #(1)ControlRegE(.Clk(Clk), .Rst(FlushE), .En(true), 
                                .Din1(RegWriteD), .Din2(MemToRegD), .Din3(MemWriteD), .Din4(ALUSrcD), 
                                .Din5(RegDstD), .Din6(ALUControlD),
                                .Dout1(RegWriteE), .Dout2(MemToRegE), .Dout3(MemWriteE), .Dout4(ALUSrcE), .Dout5(RegDstE), .Dout6(ALUControlE));
Register            R1D_UUT(.Clk(Clk), .Rst(FlushE), .En(true), 
                    .Din(RFRD1Out), .Dout(R1DOut));
Register            R2D_UUT(.Clk(Clk), .Rst(FlushE), .En(true), 
                    .Din(RFRD2Out), .Dout(R2DOut));
Register            #(5)R3D_UUT(.Clk(Clk), .Rst(FlushE), .En(true), 
                    .Din(InstrD[25:21]), .Dout(RsE));
Register            #(5)R4D_UUT(.Clk(Clk), .Rst(FlushE), .En(true), 
                    .Din(InstrD[20:16]), .Dout(RtE));  
Register            #(5)R5D_UUT(.Clk(Clk), .Rst(FlushE), .En(true), 
                    .Din(InstrD[15:11]), .Dout(RdE)); 
Register            R6D_UUT(.Clk(Clk), .Rst(FlushE), .En(true), 
                    .Din(SignImmD), .Dout(SignImmE));

Equivalator         EQUDUT(In1(M3Out), In2(M2Out), Equal(EqualD));                    
                                                                                
Mux2to1             M1DUT(.In1(PCPlus1F), .In2(PCBranchD), .Sel(PCSrcD), .MuxOut(PCNext));

Mux2to1             M2DUT(.In1(RFRD1Out), .In2(ALUOutM), .Sel(ForwardAD), .MuxOut(M2Out));

Mux2to1             M3DUT(.In1(RFRD2Out), .In2(ALUOutM), .Sel(ForwardBD), .MuxOut(M3Out));

Mux2to1             #(5)M4DUT(.In1(RtE), .In2(RdE), .Sel(RegDstE), .MuxOut(M4Out));

Mux2to1             M7DUT(.In1(M6Out), .In2(SignImmE), .Sel(ALUSrcE), .MuxOut(SrcBE));

Mux3to1             M5DUT(.In1(R1DOut), .In2(ResultW), .In3(ALUOutM), .MuxOut(SrcAE), .Sel(ForwardAE));

Mux3to1             M6DUT(.In1(R2DOut), .In2(ResultW), .In3(ALUOutM), .MuxOut(M6Out), .Sel(ForwardBE));

ALU                 ALUDUT(.ALUIn1(SrcAE), .ALUIn2(SrcBE), .ALUSel(ALUControlE), .ALUOut(ALUOutE));

SImm                SImmDUT(.IN(InstrD[15:0]), .OUT(SignImmD));

RegisterFile        RFDUT(.Clk(Clk), .RFWE(RegWriteW), .RFRA1(InstrD[25:21]), .RFRA2(InstrD[20:16]), 
                    .RFWA(RFWA_W), .RFWD(ResultW), .RFRD1(RFRD1Out), .RFRD2(RFRD2Out));

                    
                    
                    
endmodule
