`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Zilong Li
// 
// Create Date: 2021/05/19 08:09:56
// Design Name: 
// Module Name: Ctr
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


module Ctr(
    input [5:0] opCode,
    output regDst,
    output aluSrc,
    output memToReg,
    output regWrite,
    output memRead,
    output memWrite,    
    output branch,
    output [1:0] aluOp,
    output jump,
    output zext,
    output imm,
    output jal
    );


    reg RegDst;
    reg ALUSrc;
    reg MemToReg;
    reg RegWrite;
    reg MemRead;
    reg MemWrite; 
    reg Branch;
    reg [1:0] ALUOp;
    reg Jump;
    reg Zext;
    reg Imm;
    reg Jal;

    always @(opCode) begin
        case (opCode)
            6'b000000:      // R type
            begin
                RegDst      = 1;
                ALUSrc      = 0;
                MemToReg    = 0;
                RegWrite    = 1;
                MemRead     = 0;
                MemWrite    = 0;
                Branch      = 0;
                ALUOp       = 2'b10;
                Jump        = 0;
                Zext        = 0;
                Imm         = 0;
                Jal         = 0;
            end
            6'b001000:      // addi
            begin
                RegDst      = 0;     // target is 20:16
                ALUSrc      = 1;     // Read Immediate
                MemToReg    = 0;     // from register
                RegWrite    = 1;     
                MemRead     = 0;
                MemWrite    = 0;
                Branch      = 0;
                ALUOp       = 2'b11; 
                Jump        = 0;
                Zext        = 0;
                Imm         = 1;
                Jal         = 0;
            end
            6'b001100:      // andi
            begin
                RegDst      = 0;     // target is 20:16
                ALUSrc      = 1;     // Read Immediate
                MemToReg    = 0;     // from register
                RegWrite    = 1;     
                MemRead     = 0;
                MemWrite    = 0;
                Branch      = 0;
                ALUOp       = 2'b11;
                Jump        = 0;
                Zext        = 1;        // Zero Extended
                Imm         = 1;
                Jal         = 0;
            end
            6'b001101:      // ori
            begin
                RegDst      = 0;     // target is 20:16
                ALUSrc      = 1;     // Read Immediate
                MemToReg    = 0;     // from register
                RegWrite    = 1;     
                MemRead     = 0;
                MemWrite    = 0;
                Branch      = 0;
                ALUOp       = 2'b11;
                Jump        = 0;
                Zext        = 1;        // Zero Extended
                Imm         = 1;   
                Jal         = 0;     
            end
            6'b100011:      // lw
            begin
                RegDst      = 0;
                ALUSrc      = 1;
                MemToReg    = 1;
                RegWrite    = 1;
                MemRead     = 1;
                MemWrite    = 0;
                Branch      = 0;
                ALUOp       = 2'b00;
                Jump        = 0;
                Zext        = 0;
                Imm         = 0;
                Jal         = 0;
            end
            6'b101011:      // sw
            begin
                RegDst      = 0;
                ALUSrc      = 1;
                MemToReg    = 0;
                RegWrite    = 0;
                MemRead     = 0;
                MemWrite    = 1;
                Branch      = 0;
                ALUOp       = 2'b00;
                Jump        = 0;
                Zext        = 0;
                Imm         = 0;
                Jal         = 0;
            end
            6'b000100:      // beq
            begin
                RegDst      = 0;
                ALUSrc      = 0;
                MemToReg    = 0;
                RegWrite    = 0;
                MemRead     = 0;
                MemWrite    = 0;
                Branch      = 1;
                ALUOp       = 2'b01;
                Jump        = 0;
                Zext        = 0;
                Imm         = 0;
                Jal         = 0;
            end
            6'b000010:      // j
            begin
                RegDst      = 0;
                ALUSrc      = 0;
                MemToReg    = 0;
                RegWrite    = 0;
                MemRead     = 0;
                MemWrite    = 0;
                Branch      = 0;
                ALUOp       = 2'b00;
                Jump        = 1;
                Zext        = 0;
                Imm         = 0;
                Jal         = 0;
            end 
            6'b000011:      // jal
            begin
                RegDst      = 0;
                ALUSrc      = 0;
                MemToReg    = 0;
                RegWrite    = 1;    // write to reg
                MemRead     = 0;
                MemWrite    = 0;
                Branch      = 0;
                ALUOp       = 2'b00;
                Jump        = 1;
                Zext        = 0;
                Imm         = 0;
                Jal         = 1;
            end
            default: 
            begin
                RegDst      = 0;
                ALUSrc      = 0;
                MemToReg    = 0;
                RegWrite    = 0;
                MemRead     = 0;
                MemWrite    = 0;
                Branch      = 0;
                ALUOp       = 2'b00;
                Jump        = 0;
                Zext        = 0;
                Imm         = 0;
                Jal         = 0;
            end
        endcase
    end

    assign regDst = RegDst;
    assign aluSrc = ALUSrc;
    assign memToReg = MemToReg;
    assign regWrite = RegWrite;
    assign memRead = MemRead;
    assign memWrite = MemWrite; 
    assign branch = Branch;
    assign aluOp = ALUOp;
    assign jump = Jump;
    assign zext = Zext;
    assign imm = Imm;
    assign jal = Jal;

endmodule
