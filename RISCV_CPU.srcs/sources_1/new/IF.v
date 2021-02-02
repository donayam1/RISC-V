`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/30/2021 07:46:37 PM
// Design Name: 
// Module Name: IF
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



module IF #(parameter Width=32,Addbits=8)(
    output reg [Width-1:0] pc,
    output [Width-1:0] instruction,
    input [Width-1:0] branchAddress,
    input branch,    
    input clock
    );
    
    reg [Width-1:0]ProgramCounter;
    wire address;
    
    assign address = ProgramCounter[Addbits-1:0];
    
    Cache ic(instruction,address,0,clock);
    
    
    always @(posedge clock)
    begin
        if(branch)
            ProgramCounter <= branchAddress;
         else 
            ProgramCounter <= ProgramCounter+4;
    end
    
    
endmodule
