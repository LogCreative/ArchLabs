`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/19 10:38:10
// Design Name: 
// Module Name: blockMemory
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


module dataMemory(
    input Clk,
    input [31:0] address,
    input [31:0] writeData,
    input memWrite,
    input memRead,
    output reg [31:0] readData
    );

    reg [31:0] MemFile[0:63];

    always @(memRead or address) begin
        if((address>>2)<31'h00000020)
            readData = MemFile[address>>2];
        else 
            readData = 31'h00000000;
    end

    always @(negedge Clk) begin
        if(memWrite && (address>>2)<31'h00000020)
            MemFile[address>>2] = writeData;
    end

endmodule
