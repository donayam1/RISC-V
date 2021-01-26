`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2021 02:26:51 PM
// Design Name: 
// Module Name: RegisterFile
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


module RegisterFile #(parameter Width=32,NoOfRegisters=32)(
    output reg [Width-1:0]rdata1,
    output reg [Width-1:0]rdata2,
    input [5:0] rs1,
    input [5:0] rs2,
    input [5:0] rd,
    input w,
    input [Width-1:0]wdata,
    input clock
    );
    
    reg [Width-1:0] registers [NoOfRegisters-1:0];
    initial 
        registers[0] = 0;
            
    always @(posedge clock)
    begin     
            if(w) begin
                if(rd == 0)
                    begin                        
                    end
                else  
                  registers[rd] <= wdata;   
            end
            else begin
                rdata1 <= registers[rs1];
                rdata2 <= registers[rs2];
            end
    end
    
endmodule
