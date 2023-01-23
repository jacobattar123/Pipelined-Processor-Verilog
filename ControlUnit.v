`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2021 08:38:45 PM
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(            
                input [5:0] Opcode, Funct, 
                output reg RFWE, DMWE, ALUMUXInSel, MtoRFSel, RFDSelIN, Branch, Jump,
                output reg [2:0] ALUControlD);
                
                reg Rst;
                reg [3:0] TestFlag;
                
                
    initial 

    begin   
    TestFlag = 4'b0000;
    Rst = 1;
    #10 Rst = 0;
    end




                
 always @(*)  
    begin             
        if (Rst == 1'b1) begin
        
        RFWE        = 1'b0;
        DMWE        = 1'b0;
        ALUMUXInSel = 1'b0;
        MtoRFSel    = 1'b0;
        RFDSelIN    = 1'b0;
        
        Branch      = 1'b0;
        end
        
        else begin
        
            case (Opcode) 
            
            6'b000000: begin
                        if (Funct == 6'b100000) begin // add
                        RFWE = 1'b1;
                        ALUControlD = 3'b000;
                        RFDSelIN    = 1'b1; 
                        MtoRFSel    = 1'b0; 
                        DMWE        = 1'b0;
                        ALUMUXInSel = 1'b0;
                        TestFlag = 4'b0001;
                        Jump        =  1'b0;
                        Branch       = 1'b0;   
                        end
                        if (Funct == 6'b100010)begin //sub
                        RFWE = 1'b1;
                        ALUControlD = 3'b010;
                        RFDSelIN    = 1'b1; 
                        MtoRFSel    = 1'b0; 
                        DMWE        = 1'b0;
                        ALUMUXInSel = 1'b0;
                        TestFlag = 4'b0010; 
                        Jump        =  1'b0;
                        Branch       = 1'b0;
                        end
                        if (Funct == 6'b000000)begin //sll
                        RFWE = 1'b1;
                        ALUControlD = 3'b101;
                        RFDSelIN    = 1'b1; 
                        MtoRFSel    = 1'b0; 
                        DMWE        = 1'b0;
                        ALUMUXInSel = 1'b0;
                        TestFlag = 4'b0011;
                        Jump        =  1'b0;
                        Branch       = 1'b0;
                        end                        
                        
                        if (Funct == 6'b000100)begin //sllv
                        RFWE = 1'b1;
                        ALUControlD = 3'b110;
                        RFDSelIN    = 1'b1; 
                        MtoRFSel    = 1'b0; 
                        DMWE        = 1'b0;
                        ALUMUXInSel = 1'b0;
                        TestFlag = 4'b0100;
                        Jump        =  1'b0;
                        Branch       = 1'b0;
                        end
                        
                        if (Funct == 6'b000111)begin  //srav
                        RFWE = 1'b1;
                        ALUControlD = 3'b111;
                        RFDSelIN    = 1'b1; 
                        MtoRFSel    = 1'b0; 
                        DMWE        = 1'b0;
                        ALUMUXInSel = 1'b0;
                        TestFlag = 4'b0101;
                        Jump        =  1'b0;
                        Branch       = 1'b0;
                        end                         
                        end //end if funct 
                         
            6'b100011: begin //lw
            
                       RFWE        = 1'b1;
                       ALUControlD = 3'b000;
                       ALUMUXInSel = 1'b1;
                       DMWE        = 1'b0;
                       MtoRFSel    = 1'b1;
                       RFDSelIN    = 1'b0;
                       TestFlag = 4'b0110;
                       Jump        =  1'b0;
                       Branch       = 1'b0;
                       end   //end case lw
            
            6'b101011: begin //sw
            
                       RFWE        = 1'b0;
                       ALUControlD = 3'b000;
                       ALUMUXInSel = 1'b1;
                       DMWE        = 1'b1;
                       MtoRFSel    = 1'bx;
                       RFDSelIN    = 1'b0;
                       TestFlag = 4'b0111;
                       Jump        =  1'b0;
                       Branch       = 1'b0;
                       end   //end case sw
          
           6'b001000: begin //addi
            
                       RFWE        = 1'b1;
                       ALUControlD = 3'b000;
                       ALUMUXInSel = 1'b1;
                       DMWE        = 1'b0;
                       MtoRFSel    = 1'b0;
                       RFDSelIN    = 1'b0;
                       TestFlag = 4'b1000;
                       Jump        =  1'b0;
                       Branch       = 1'b0;
                       
                       end   //end case sw
            6'b000100: begin //branch
                       RFWE         = 1'b0; 
                       RFDSelIN     = 1'bx;
                       ALUMUXInSel  = 1'b0;
                       Branch       = 1'b1;
                       DMWE         = 1'b0;
                       MtoRFSel     = 1'bx;                         
                       ALUControlD = 3'b010; 
                       Jump        =  1'b0;
                       end
            6'b000010: begin //jump
                       RFWE         = 1'b0; 
                       RFDSelIN     = 1'bx;
                       ALUMUXInSel  = 1'bx;
                       Branch       = 1'bx;
                       DMWE         = 1'b0;
                       MtoRFSel     = 1'bx;                         
                       ALUControlD = 3'bxxx; 
                       Jump        =  1'b1;
                       end           	                                 
                        
             default: begin 
                      RFWE        = 1'b1;
                      DMWE        = 1'b1;
                      ALUMUXInSel = 1'b1;
                      MtoRFSel    = 1'b1;
                      RFDSelIN    = 1'b1;
                      ALUControlD = 3'b000;
                      TestFlag    = 3'b111;
                      Jump        =  1'b0;
                      Branch       = 1'b0;
                      end          
                 endcase       
                 end
                 end
                        
endmodule

