`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2021 04:34:15 PM
// Design Name: 
// Module Name: IFTB
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


module IFTB #(parameter Width=32,Addbits=8)(
    );
    
    wire  [Width-1:0] pc;
    wire [Width-1:0] instruction;
    
    wire [Width-1:0] branchAddress;      
    wire branch;    
    
    wire [Addbits-1:0] waddress;
    wire [Width-1:0] wdata;
    wire w;
    wire en;
    wire clock;
    
    IFTG ifg(pc,instruction,branchAddress,branch,waddress,wdata,w,en,clock);
    IF instf(pc,instruction,branchAddress,branch,waddress,wdata,w,en,clock);
    
endmodule

module IFTG #(parameter Width=32,Addbits=8)(
    input  [Width-1:0] pc,
    input [Width-1:0] instruction,
    
    output reg[Width-1:0] branchAddress,       
    output reg branch,    
    
    output reg [Addbits-1:0] waddress,
    output reg [Width-1:0] wdata,
    output reg w,
    output reg en,
    output reg clock
    );
    
    initial
    begin
        #0 clock=0;en=0;w=0;wdata=0;waddress=0;branch=0;branchAddress=0;
        #1 clock=1; en=0;
        #1 clock=0;
            if(pc != 0 || instruction != 32'h13)
                $display("Error program counter should not be incremented.");

        #1 clock=1; en=1;branch=0;
        #1 clock=0;
            if(pc != 4 || instruction != 32'h06400513)
                $display("Error program counter should not be incremented.");
                       
                       
        #1 clock=1;
        #1 clock=0;                
        #1 $finish ;
    end

endmodule



