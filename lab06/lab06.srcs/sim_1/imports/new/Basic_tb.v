`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/26 09:49:08
// Design Name: 
// Module Name: Basic_tb
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


module Basic_tb(

    );

    reg clk;
    reg reset;

    Top Proc(.clk(clk),.reset(reset));

    initial begin
        $readmemb("mem_inst_example.mem",Proc.instMemory.instructions);
        $readmemh("mem_data_example.mem",Proc.DataMemory.MemFile,10'h0);
        reset = 1;
        clk = 0;
    end

    always #10 clk = ~clk;

    initial begin
        #80 reset = 0;
    end

endmodule
