`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2021 10:53:15 AM
// Design Name: 
// Module Name: toplevel
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



module toplevel#(parameter DW = 32)(input Clk, Rst);


reg [31:0] one = 32'h1;
reg true = 1'b1;
reg false = 1'b0;
wire [DW-1:0]   PCNext, 
                PCF, 
                PCPlus1F, PCPlus1D, 
                InstrF, InstrD, 
                SignImmD, SignImmE,
                PCBranchD,
                M2Out, M3Out, 
                
                WriteDataE, WriteDataM, 
                ALUOutM, ALUOutE, ALUOutW,
                R1DOut, R2DOut,  
                ResultW,
                SrcAE, SrcBE,
                DMReadOut,
                ReadDataW, 
                RFRD1Out, RFRD2Out;
                
wire [4:0] WriteRegE, WriteRegM, WriteRegW, RsE, RtE, RdE,  RsD, RtD, RtF, shamtD, shamtE;               
                
wire    ForwardAD, ForwardBD, 
        StallF, StallD, 
        PCSrcD, 
        BranchD,
        FlushE,
        EqualD,
        RegDstD, RegDstE,
        ALUSrcD, ALUSrcE,
        MemWriteD, MemWriteE, MemWriteM,
        MemToRegD, MemToRegE, MemToRegM,MemToRegW,
        RegWriteD, RegWriteE, RegWriteM,RegWriteW;
        
        
        
wire [1:0] ForwardAE, ForwardBE, tempAE;                   
wire [2:0] ALUControlD, ALUControlE;

assign tempAE = ForwardAE;
assign shamtD = InstrD[10:6];
assign RsD = InstrD[25:21];
assign RtD = InstrD[20:16];
assign RtF = InstrF[20:16];
assign PCSrcD = EqualD && BranchD;


ControlUnit         CUDUT(.Opcode(InstrD[31:26]), .Funct(InstrD[5:0]),
                             .RFWE(RegWriteD), .DMWE(MemWriteD), 
                          .ALUMUXInSel(ALUSrcD), .MtoRFSel(MemToRegD), .RFDSelIN(RegDstD),
                           .Branch(BranchD),  .ALUControlD(ALUControlD));

ProgramCounter      PCDUT(.Clk(Clk), .PCReset(Rst), .PCWrite(!(StallF)), 
                    .PCNext(PCNext), .PCResult(PCF));
                        
InstructionMemory   IMDUT(.Addr(PCF), .Instr(InstrF));

Adder               Adder1DUT(.AddIn1(PCF), .AddIn2(one), .AddOut(PCPlus1F));

Adder               Adder2DUT(.AddIn1(SignImmD), .AddIn2(PCPlus1D), .AddOut(PCBranchD));                    


RegisterPLP            RegInstrFDUT(.Clk(Clk), .Rst(PCSrcD), .En(!(StallD)), 
                    .Din(InstrF), .Dout(InstrD));
                    
RegisterPLP            RegPCPlus1FDUT(.Clk(Clk), .Rst(PCSrcD), .En(!(StallD)),
                    .Din(PCPlus1F), .Dout(PCPlus1D));

RegisterPLP            R1_UUT(.Clk(Clk), .Rst(FlushE), .En(true), 
                    .Din(RFRD1Out), .Dout(R1DOut));
RegisterPLP            R2_UUT(.Clk(Clk), .Rst(FlushE), .En(true), 
                    .Din(RFRD2Out), .Dout(R2DOut));
RegisterPLP            #(5)R3_UUT(.Clk(Clk), .Rst(FlushE), .En(true), 
                    .Din(InstrD[25:21]), .Dout(RsE));
RegisterPLP            #(5)R14_UUT(.Clk(Clk), .Rst(FlushE), .En(true), 
                    .Din(shamtD), .Dout(shamtE));                    
RegisterPLP            #(5)R4_UUT(.Clk(Clk), .Rst(FlushE), .En(true), 
                    .Din(InstrD[20:16]), .Dout(RtE));  
RegisterPLP            #(5)R5_UUT(.Clk(Clk), .Rst(FlushE), .En(true), 
                    .Din(InstrD[15:11]), .Dout(RdE)); 
                    
RegisterPLP            R6_UUT(.Clk(Clk), .Rst(FlushE), .En(true), 
                    .Din(SignImmD), .Dout(SignImmE));
                    
RegisterPLP            R7_UUT(.Clk(Clk), .En(true), 
                    .Din(ALUOutE), .Dout(ALUOutM));
                    
RegisterPLP            R8_UUT(.Clk(Clk), .En(true), 
                    .Din(WriteDataE), .Dout(WriteDataM));
                    
RegisterPLP            R10_UUT(.Clk(Clk), .En(true), 
                    .Din(DMReadOut), .Dout(ReadDataW));                      

RegisterPLP            R11_UUT(.Clk(Clk), .En(true), 
                    .Din(ALUOutM), .Dout(ALUOutW)); 
                                     
RegisterPLP            #(5)R9_UUT(.Clk(Clk), .En(true), 
                    .Din(WriteRegE), .Dout(WriteRegM)); 
                    
RegisterPLP            #(5)R12_UUT(.Clk(Clk), .En(true), 
                    .Din(WriteRegM), .Dout(WriteRegW));                    

RegisterPLP            #(3)R13_UUT(.Clk(Clk), .En(true), .Rst(FlushE), 
                    .Din(ALUControlD), .Dout(ALUControlE));                  

RegGroup6           #(1)ControlRegW(.Clk(Clk), .En(true), .Din1(RegWriteM), .Din2(MemToRegM),
                                    .Dout1(RegWriteW), .Dout2(MemToRegW));

RegGroup6           #(1)ControlRegE(.Clk(Clk), .Rst(FlushE), .En(true), 
                                .Din1(RegWriteD), .Din2(MemToRegD), .Din3(MemWriteD), .Din4(ALUSrcD), 
                                .Din5(RegDstD),
                                .Dout1(RegWriteE), .Dout2(MemToRegE), .Dout3(MemWriteE), .Dout4(ALUSrcE), 
                                .Dout5(RegDstE)) ;

RegGroup6           #(1)ControlRegM(.Clk(Clk), .En(true), .Din1(RegWriteE), .Din2(MemToRegE), .Din3(MemWriteE),
                                    .Dout1(RegWriteM), .Dout2(MemToRegM), .Dout3(MemWriteM));

Equivalator         EQUDUT(.In1(M3Out), .In2(M2Out), .Equal(EqualD));                    
                                                                                
Mux2to1             M1DUT(.In1(PCPlus1F), .In2(PCBranchD), .Sel(PCSrcD), .MuxOut(PCNext));

Mux2to1             M2DUT(.In1(RFRD1Out), .In2(ALUOutM), .Sel(ForwardAD), .MuxOut(M2Out));

Mux2to1             M3DUT(.In1(RFRD2Out), .In2(ALUOutM), .Sel(ForwardBD), .MuxOut(M3Out));

Mux2to1             #(5)M4DUT(.In1(RtE), .In2(RdE), .Sel(RegDstE), .MuxOut(WriteRegE));

Mux2to1             M7DUT(.In1(WriteDataE), .In2(SignImmE), .Sel(ALUSrcE), .MuxOut(SrcBE));

Mux2to1             M8DUT(.In1(ALUOutW), .In2(ReadDataW), .Sel(MemToRegW), .MuxOut(ResultW));

Mux3to1             M5DUT(.In1(R1DOut), .In2(ResultW), .In3(ALUOutM), .MuxOut(SrcAE), .Sel(ForwardAE));

Mux3to1             M6DUT(.In1(R2DOut), .In2(ResultW), .In3(ALUOutM), .MuxOut(WriteDataE), .Sel(ForwardBE));

ALU                 ALUDUT(.ALUIn1(SrcAE), .ALUIn2(SrcBE), .ALUSel(ALUControlE), .Shamt(shamtE), .ALUOut(ALUOutE));

SImm                SImmDUT(.IN(InstrD[15:0]), .OUT(SignImmD));

RegisterFile        RFDUT(.Clk(!(Clk)), .RFWE(RegWriteW), .RFRA1(InstrD[25:21]), .RFRA2(RtD), 
                    .RFWA(WriteRegW), .RFWD(ResultW), .RFRD1(RFRD1Out), .RFRD2(RFRD2Out));

DataMemory          DMDUT(.Clk(Clk), .DMWE(MemWriteM), .DMA(ALUOutM), .DMWD(WriteDataM), .DMRD(DMReadOut));                    

HazardUnit          HUDUT (.RsD(RsD), .Clk(Clk),  .RsE(RsE), .RtE(RtE), .RtD(RtD), .WriteRegE(WriteRegE),
                        .WriteRegM(WriteRegM), .WriteRegW(WriteRegW), .BranchD(BranchD),
                        .MemToRegE(MemToRegE), .StallF(StallF), .StallD(StallD), .ForwardAD(ForwardAD), 
                        .ForwardBD(ForwardBD), .ForwardAE(ForwardAE),  .ForwardBE(ForwardBE),
                        .FlushE(FlushE), .RegWriteE(RegWriteE), 
                        .MemToRegM(MemToRegM), .RegWriteM(RegWriteM), .RegWriteW(RegWriteW));                   
                    
endmodule
