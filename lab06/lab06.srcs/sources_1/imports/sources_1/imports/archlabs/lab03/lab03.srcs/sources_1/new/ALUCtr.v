`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/19 08:51:47
// Design Name: 
// Module Name: ALUCtr
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


module ALUCtr(
    input nop,
    input [5:0] funct,
    input [1:0] aluOp,
    output [3:0] aluCtrOut,
    output jr,
    output shamt
    );

    reg [3:0] ALUCtrOut;
    reg Jr;
    reg Shamt;

    always @(aluOp or funct) begin
        casex ({aluOp, funct})
            8'b00xxxxxx:    ALUCtrOut = 4'b0010;
            8'b01xxxxxx:    ALUCtrOut = 4'b0110;
            8'b10100000:    ALUCtrOut = 4'b0010;
            8'b10100010:    ALUCtrOut = 4'b0110;
            8'b10100100:    ALUCtrOut = 4'b0000;
            8'b10100101:    ALUCtrOut = 4'b0001;
            8'b10101010:    ALUCtrOut = 4'b0111;
            8'b10001000:    ALUCtrOut = 4'b0010;
            8'b10000000:    ALUCtrOut = 4'b1000;           // sll
            8'b10000010:    ALUCtrOut = 4'b1001;           // srl
            8'b11001000:    ALUCtrOut = 4'b0010;
            8'b11001100:    ALUCtrOut = 4'b0000;
            8'b11001101:    ALUCtrOut = 4'b0001;
            default:        ALUCtrOut = 4'b1111;
        endcase
        if(nop==1) ALUCtrOut = 4'b1111;
        if({aluOp, funct} == 8'b10001000) Jr = 1;
        else Jr = 0;
        if(nop == 0 && {aluOp, funct} >= 8'b10000000 && {aluOp, funct} <= 8'b10000011) Shamt = 1;
        else Shamt = 0;
    end
    
    assign aluCtrOut = ALUCtrOut;
    assign jr = Jr;
    assign shamt = Shamt;
endmodule
