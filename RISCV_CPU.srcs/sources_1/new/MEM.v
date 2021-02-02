`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/30/2021 09:29:19 PM
// Design Name: 
// Module Name: MEM
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


module MEM #(parameter Width=32,MemWidth=8,Size=256,Addbits=8)(
    output [Width-1:0] data,
    input [Width-1:0] wdata,
    input [Addbits-1:0] address,
    input rw,
    input clock
);

    Cache dc(data,wdata,address,rw,clock);
    
endmodule
