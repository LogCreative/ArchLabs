`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/26 08:17:21
// Design Name: 
// Module Name: InstMemory
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


module InstMemory(
    input clk,
    input [31:0] readAddress,
    output [31:0] inst
    );

    reg [31:0] instructions [0:63];
    assign inst = instructions[readAddress / 4 < 1023 ? readAddress / 4 : 0];

endmodule
