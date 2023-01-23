`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2021 11:17:33 AM
// Design Name: 
// Module Name: RegisterFile
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


module RegisterFile#(parameter AW = 5, DW = 32) (
    input Clk, RFWE,
    input [AW-1:0] RFRA1, RFRA2, RFWA,
    input [DW-1:0] RFWD,
    output wire [DW-1:0] RFRD1, RFRD2
);
    // Declare an array of registers with width DW and depth 2^AW
    reg [DW-1:0] RF [2**5-1:0];

    // Always block that runs on the rising edge of the clock
    always @(posedge Clk) begin
        // If the register file write enable (RFWE) is high, write the data (RFWD) to the register at the address specified by RFWA
        if (RFWE) RF [RFWA] <= RFWD;
    end

    // Assign the values of the registers at addresses RFRA1 and RFRA2 to the outputs RFRD1 and RFRD2, respectively
    assign RFRD1 = RF[RFRA1];
    assign RFRD2 = RF[RFRA2];

    // Initial block that reads the contents of the file "rf_data.mem" into the register file array
    initial begin
        $readmemb("rf_data.mem", RF);
    end
endmodule
