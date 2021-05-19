`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/19 08:59:20
// Design Name: 
// Module Name: ALUCtr_tb
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


module ALUCtr_tb(

    );

    reg [5:0] Funct;
    reg [1:0] ALUOp;
    wire [3:0] ALUCtrOut;

    ALUCtr u1(
        .funct(Funct),
        .aluOp(ALUOp),
        .aluCtrOut(ALUCtrOut)
    );

    initial begin
        Funct = 0;
        ALUOp = 0;
        #100;

        #100;
        Funct = 6'b000000;
        ALUOp = 2'b00;
        
        #100;
        Funct = 6'b000000;
        ALUOp = 2'b01;

        #100;
        Funct = 6'b000000;
        ALUOp = 2'b10;

        #100;
        Funct = 6'b000010;
        ALUOp = 2'b10;

        #100;
        Funct = 6'b000100;
        ALUOp = 2'b10;

        #100;
        Funct = 6'b000101;
        ALUOp = 2'b10;

        #100;
        Funct = 6'b001010;
        ALUOp = 2'b10;
        
    end

endmodule
