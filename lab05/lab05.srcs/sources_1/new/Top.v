`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Zilong Li
// 
// Create Date: 2021/05/26 08:25:11
// Design Name: 
// Module Name: Top
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


module Top(
        input clk,
        input reset
    );

    reg [31:0] PC;

    always @(posedge clk) begin
        if(reset)
            PC <= 0;
        else begin
            PC <= PC + 4;
        end
    end

    wire [31:0] INST;

    InstMemory instMemory(
        .readAddress(PC),
        .inst(INST)
    );

    wire REG_DST,
        JUMP,
        BRANCH,
        MEM_READ,
        MEM_TO_REG,
        MEM_WRITE;
    wire [1:0] ALU_OP;
    wire ALU_SRC,
        REG_WRITE;

    Ctr mainCtr(
        .opCode(INST[31:26]),
        .regDst(REG_DST),
        .jump(JUMP),
        .branch(BRANCH),
        .memRead(MEM_READ),
        .memToReg(MEM_TO_REG),
        .aluOp(ALU_OP),
        .memWrite(MEM_WRITE),
        .aluSrc(ALU_SRC),
        .regWrite(REG_WRITE)
    );

    wire [31:0] READ_DATA1;
    wire [31:0] READ_DATA2;
    wire [31:0] OPRAND;
    wire [3:0] ALU_CTR;
    wire ZERO;
    wire [31:0] ALU_RES;
    wire [31:0] READ_DATA;

    Registers registers(
        .clk(clk),
        .reset(reset),
        .readReg1(INST[25:21]),
        .readReg2(INST[20:16]),
        .writeReg(REG_DST ? INST[15:11] : INST[20:16]),
        .writeData(MEM_TO_REG ? READ_DATA : ALU_RES),
        .regWrite(REG_WRITE),
        .readData1(READ_DATA1),
        .readData2(READ_DATA2)
    );

    signext signExt(
        .inst(INST[15:0]),
        .data(OPRAND)
    );

    ALUCtr aluctr(
        .funct(INST[5:0]),
        .aluOp(ALU_OP),
        .aluCtrOut(ALU_CTR)
    );

    ALU alu(
        .input1(READ_DATA1),
        .input2(ALU_SRC ? OPRAND : READ_DATA2),
        .aluCtr(ALU_CTR),
        .zero(ZERO),
        .aluRes(ALU_RES)
    );

    dataMemory DataMemory(
        .Clk(clk),
        .address(ALU_RES),
        .writeData(READ_DATA2),
        .memWrite(MEM_WRITE),
        .memRead(MEM_READ),
        .readData(READ_DATA)
    );

    always @(negedge clk) begin
    PC <= JUMP ? 
                (PC[31:28] + INST[25:0] << 2) :     // 26 -> 28
                ((BRANCH & ZERO) ? (PC + OPRAND << 2) : PC);
    end

endmodule
