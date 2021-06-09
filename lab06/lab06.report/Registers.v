module Registers(
    input [25:21] readReg1,
    input [20:16] readReg2,
    input [4:0] writeReg,
    input [31:0] writeData,
    input regWrite,
    output [31:0] readData1,
    output [31:0] readData2,
    input clk,
    input reset
    );

    reg [31:0] RegFile [31:0];
    
    // reg [31:0] ReadData1;
    // reg [31:0] ReadData2;
    // always @(readReg1 or readReg2) begin
    //     ReadData1 = RegFile[readReg1];
    //     ReadData2 = RegFile[readReg2];
    // end
    // assign readData1 = ReadData1;
    // assign readData2 = ReadData2;
    assign readData1 = RegFile[readReg1];
    assign readData2 = RegFile[readReg2];

    integer i;
    always @(negedge clk or reset) begin
        if(reset) begin
            for(i = 0; i < 32; i = i + 1)
                RegFile[i] = 0; 
        end
        else begin
            if(regWrite)
                RegFile[writeReg] = writeData;
        end
    end
endmodule 