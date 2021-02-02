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
    output reg [Width-1:0]rData1, // read data from source 1
    output reg [Width-1:0]rData2, //read data from source 2
    input [5:0] rs1, //register source 1
    input [5:0] rs2, //register source 2
    input [5:0] rd, //register destination 
    input w, //register write control 
    input r, //register read contorl 
    input [Width-1:0]wData, //write data 
    input clock //clock input 
    );
    
    reg [Width-1:0] registers [NoOfRegisters-1:0];
    initial 
        registers[0] = 0;
    
    //Writes on the first half of clock
    always @(posedge clock)
    begin     
            if(w) begin
                if(rd == 0)
                    begin                        
                    end
                else  
                  registers[rd] <= wData;   
            end                        
    end
    
    //Reads on the second half of clock
    always @(negedge clock)
    begin
        if(r)
            begin
                rData1 <= registers[rs1];
                rData2 <= registers[rs2];
            end
    end
    
    
endmodule
