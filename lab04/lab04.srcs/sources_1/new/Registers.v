`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/19 09:51:33
// Design Name: 
// Module Name: Register
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


module Registers(
    input [25:21] readReg1,
    input [20:16] readReg2,
    input [4:0] writeReg,
    input [31:0] writeData,
    input regWrite,
    output [31:0] readData1,
    output [31:0] readData2,
    input clk
    );

    reg [31:0] RegFile [31:0];      // internal store
    reg [31:0] ReadData1 = {32{0}};
    reg [31:0] ReadData2 = {32{0}};

    always @(readReg1 or readReg2) begin
        ReadData1 = RegFile[readReg1];
        ReadData2 = RegFile[readReg2];
    end
    
    always @(negedge clk) begin
        if(regWrite)
            RegFile[writeReg] = writeData;
    end

    assign readData1 = ReadData1;
    assign readData2 = ReadData2;

endmodule
