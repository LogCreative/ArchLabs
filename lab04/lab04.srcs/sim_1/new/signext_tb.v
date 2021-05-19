`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/19 11:05:44
// Design Name: 
// Module Name: signext_tb
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


module signext_tb(

    );

    reg [15:0] inst;
    wire [31:0] data;

    signext u2(
        .inst(inst),
        .data(data)
    );

    initial begin
        inst = 0;
        
        #100 inst = 1;
        #100 inst = -1;
        #100 inst = 2;
        #100 inst = -2;
    end

endmodule
