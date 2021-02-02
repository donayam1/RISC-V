`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/30/2021 10:15:59 PM
// Design Name: 
// Module Name: Cache
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


module Cache #(parameter Width=32,MemWidth=8,Size=256,Addbits=8)(
    output reg [Width-1:0] data,
    input [Width-1:0] wdata,
    input [Addbits-1:0] address,
    input rw,
    input clock
);

    reg [MemWidth-1:0] mem [Size-1:0];    
    always @(posedge clock)
    begin        
        if(rw)
            begin
                mem[address] = wdata[31:24];
                mem[address+1] = wdata[23:16];
                mem[address+2] = wdata[15:8];
                mem[address+3] = wdata[7:0];
            end
        else
            begin 
                data <= {mem[address],mem[address+1],mem[address+2],mem[address+3]};
            end
    end
    
endmodule 
