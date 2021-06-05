`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Zilong Li
// 
// Create Date: 2021/06/05 12:37:39
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

    // TODO: reverse the assignment order

    // Instruction Fetch (IF)
    reg [31:0] PC;          // TODO: the choice of PC
    reg [31:0] IF_PC;

    wire [31:0] INST_IF;
    InstMemory instMemory(
        .readAddress(PC),
        .inst(INST_IF)
    );

    reg [31:0] IF_INST;
    always @(posedge clk) begin
        if(reset) begin
            PC <= 0;
            IF_PC <= 0;
            IF_INST <= 0;
        end
        else begin
            IF_PC <= PC + 4;
            IF_INST <= INST_IF;
        end
    end

    // Instruction Decoding (ID)
    reg [31:0] ID_PC;

    wire REG_DST_ID;
    wire JUMP_ID;
    wire BRANCH_ID;
    wire MEM_READ_ID;
    wire MEM_TO_REG_ID;
    wire MEM_WRITE_ID;
    wire ALU_OP_ID;
    wire ALU_SRC_ID;
    wire IMM_ID;
    wire JAL_ID;
    wire REG_WRITE_ID;

    wire ZEXT;

    Ctr mainCtr(
        .opCode(IF_INST[31:26]),
        .regDst(REG_DST_ID),
        .jump(JUMP_ID),
        .branch(BRANCH_ID),
        .memRead(MEM_READ_ID),
        .memToReg(MEM_TO_REG_ID),
        .memWrite(MEM_WRITE_ID),
        .aluOp(ALU_OP_ID),
        .aluSrc(ALU_SRC_ID),
        .imm(IMM_ID),
        .regWrite(REG_WRITE_ID),
        .jal(JAL_ID),
        .zext(ZEXT)
    );

    wire [31:0] READ_DATA1_ID;
    wire [31:0] READ_DATA2_ID;

    Registers registers(
        .clk(clk),
        .reset(reset),
        .readReg1(IF_INST[25:21]),
        .readReg2(IF_INST[20:16]),
        .writeReg(/**/),                // After write back
        .writeData(/**/),               // ...
        .regWrite(/**/),                // ...
        .readData1(READ_DATA1_ID),
        .readData2(READ_DATA2_ID)
    );

    wire [31:0] OPAND_ID;

    signext signExt(
        .inst(IF_INST[15:0]),
        .zext(ZEXT),
        .data(OPAND_ID)
    );

    reg ID_REG_DST;
    reg ID_JUMP;
    reg ID_BRANCH;
    reg ID_MEM_READ;
    reg ID_MEM_TO_REG;
    reg ID_MEM_WRITE;
    reg ID_ALU_OP;
    reg ID_ALU_SRC;
    reg ID_IMM;
    reg ID_JAL;
    reg ID_REG_WRITE;

    reg [31:0] ID_READ_DATA1;
    reg [31:0] ID_READ_DATA2;
    reg [31:0] ID_OPAND;
    reg [31:0] ID_INST;
    always @(posedge clk) begin
        if(reset) begin
            ID_PC <= 0;
            ID_READ_DATA1 <= 0;
            ID_READ_DATA2 <= 0;
            ID_OPAND <= 0;
            ID_INST <= 0;

            ID_REG_DST <= 0;
            ID_JUMP <= 0;
            ID_BRANCH <= 0;
            ID_MEM_READ <= 0;
            ID_MEM_TO_REG <= 0;
            ID_MEM_WRITE <= 0;
            ID_ALU_OP <= 0;
            ID_ALU_SRC <= 0;
            ID_IMM <= 0;
            ID_JAL <= 0;
            ID_REG_WRITE <= 0;
        end
        else begin
            ID_PC <= IF_PC;
            ID_READ_DATA1 <= READ_DATA1_ID;
            ID_READ_DATA2 <= READ_DATA2_ID;
            ID_OPAND <= OPAND_ID;
            ID_INST <= IF_INST;

            ID_REG_DST <= REG_DST_ID;
            ID_JUMP <= JUMP_ID;
            ID_BRANCH <= BRANCH_ID;
            ID_MEM_READ <= MEM_READ_ID;
            ID_MEM_TO_REG <= MEM_TO_REG_ID;
            ID_MEM_WRITE <= MEM_WRITE_ID;
            ID_ALU_OP <= ALU_OP_ID;
            ID_ALU_SRC <= ALU_SRC_ID;
            ID_IMM <= IMM_ID;
            ID_JAL <= JAL_ID;
            ID_REG_WRITE <= REG_WRIRE_ID;
        end
    end

    // Execution (EX)
    reg [31:0] EX_PC;
    reg [31:0] EX_BRANCH_PC;
    
    wire ZERO_EX;
    wire ALU_RES_EX;

    wire JR;
    wire ALU_CTR;
    wire SHAMT;

    ALUCtr aluctr(
        .funct(ID_IMM ? ID_INST[31:26] : ID_INST[5:0]),
        .aluOp(ID_ALU_OP),
        .aluCtrOut(ALU_CTR),
        .jr(JR),
        .shamt(SHAMT)
    );

    ALU alu(
        .input1(SHAMT ? ID_INST[10:6] : ID_READ_DATA1),
        .input2(ID_ALU_SRC ? ID_OPAND : ID_READ_DATA2),
        .aluCtr(ALU_CTR),
        .zero(ZERO_EX),
        .aluRes(ALU_RES_EX)
    );

    reg EX_ZERO;
    reg EX_ALU_RES;
    reg EX_WRITE_REG;

    reg EX_JUMP;
    reg EX_BRANCH;
    reg EX_MEM_READ;
    reg EX_MEM_TO_REG;
    reg EX_MEM_WRITE;
    reg EX_REG_WRITE;

    reg [31:0] EX_READ_DATA2;
    
    always @(posedge clk) begin
        if(reset) begin
            EX_PC <= 0;
            EX_BRANCH_PC <= 0;
            EX_ZERO <= 0;
            EX_ALU_RES <= 0;
            EX_WRITE_REG <= 0;

            EX_JUMP <= 0;
            EX_BRANCH <= 0;
            EX_MEM_READ <= 0;
            EX_MEM_TO_REG <= 0;
            EX_MEM_WRITE <= 0;
            EX_REG_WRITE <= 0;

            EX_READ_DATA2 <= 0;
        end
        else begin
            EX_PC <= ID_PC;
            EX_BRANCH_PC <= ID_PC + (ID_OPAND[25:0] << 2);
            EX_ZERO <= ZERO_EX;
            EX_ALU_RES <= ALU_RES_EX;
            EX_WRITE_REG <= ID_JAL ? 5'b11111 : (JR ? INST[25:21] : (ID_REG_DST ? ID_INST[15:11] : ID_INST[20:16]));

            EX_JUMP <=          ID_JUMP;
            EX_BRANCH <=        ID_BRANCH;
            EX_MEM_READ <=      ID_MEM_READ;
            EX_MEM_TO_REG <=    ID_MEM_TO_REG;
            EX_MEM_WRITE <=     ID_MEM_WRITE;
            EX_REG_WRITE <=     ID_REG_WRITE;

            EX_READ_DATA2 <=    ID_READ_DATA2;
        end
    end

    // Memory (MEM)

    wire PC_SRC; // TODO: connect PC
    assign PC_SRC = EX_BRANCH & EX_ZERO; 

    wire READ_DATA_MEM;

    dataMemory DataMemory(
        .Clk(clk),
        .address(EX_ALU_RES),
        .writeData(EX_READ_DATA2),
        .memWrite(EX_MEM_WRITE),
        .memRead(EX_MEM_READ),
        .readData(READ_DATA_MEM)
    );

    reg MEM_REG_WRITE;
    reg MEM_MEM_TO_REG;

    reg [31:0] MEM_READ_DATA;
    reg [31:0] MEM_ALU_RES;
    reg [31:0] MEM_WRITE_REG;

    always @(posedge clk ) begin
        if(reset) begin
            MEM_REG_WRITE <= 0;

            MEM_READ_DATA <= 0;
            MEM_ALU_RES <= 0;
            MEM_WRITE_REG <= 0;
        end
        else begin
            MEM_REG_WRITE <= EX_REG_WRITE;
            MEM_MEM_TO_REG <= EX_MEM_TO_REG;

            MEM_READ_DATA <= READ_DATA_MEM;
            MEM_ALU_RES <= EX_ALU_RES;
            MEM_WRITE_REG <= EX_WRITE_REG;
        end
    end

    // write back ...
    // MEM_MEM_TO_REG ? MEM_READ_DATA : MEM_ALU_RES

endmodule
