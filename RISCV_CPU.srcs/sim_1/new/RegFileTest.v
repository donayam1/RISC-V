`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Addis Ababa University 
// Engineer: Donayam
// 
// Create Date: 01/25/2021 03:22:39 PM
// Design Name: 
// Module Name: RegFileTest
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

module RegFileTB #(parameter Width=32)();
    
    wire  [Width-1:0]rdata1;
    wire  [Width-1:0]rdata2;
    
    wire [5:0] rs1;
    wire [5:0] rs2;
    wire [5:0] rd;
    wire  w;
    wire [Width-1:0] wdata;
    wire  clock;
    
    RegisterFile rf(rdata1,rdata2,rs1,rs2,rd,w,wdata,clock);
    RegFileTG rftg(rdata1,rdata2,rs1,rs2,rd,w,wdata,clock);
    
endmodule

module RegFileTG #(parameter Width=32)(
    input  [Width-1:0]rdata1,
    input  [Width-1:0]rdata2,
    
    output reg[5:0] rs1,
    output reg[5:0] rs2,
    output reg[5:0] rd,
    output reg w,
    output reg[Width-1:0] wdata,
    output reg clock
    );
    
    initial 
    begin
        #0 clock=0;rs1=0;rs2=0;rd=0;w=0;wdata=0;
        #1 rd=0;wdata=100;w=1;clock=1;
        #1 clock=0;
        #1 w=0;rs1=0; clock=1;
        #1 clock=0;
        
        for (integer i=31;i>=0;i=i-1)
        begin 
            #1 w=1;rd=i; wdata=i+2;clock=1;
            #1 clock=0;
        end
        
        for (integer j=31;j>=0;j=j-1)
        begin 
            #1 w=0;rs1=j+1; rs2=j;clock=1;            
            #1 clock=0;
            if (j!=0)
               begin
                if(rdata1 != (j+2))                 
                 begin
                    $display("Error testing register file. Read data is -> %d. Should be -> %d",rdata1,j+2);
                 end
                end
             else begin
                if(rdata1 != 0) $display("Error testing register file. read data is -> %d. Should be -> %d",rdata1,j+2);
             end
        end
        
        #1 clock=1;       
        #1 $finish;
    end
endmodule
