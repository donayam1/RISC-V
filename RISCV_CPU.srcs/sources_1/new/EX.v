`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2021 05:41:56 PM
// Design Name: 
// Module Name: EX
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


module EX #(parameter Width=32)(
    output  [Width-1:0] res,
    output reg [Width-1:0] branchAdress,
    input signed [Width-1:0] op1,
    input signed [Width-1:0] op2,
    input signed [Width-1:0] immidiate,
    input [Width-1:0] pc,
    input [3:0] operation,
    input operandRevers,
    input immidateSelect,
    input j,
    input clock
    );
        
//    wire select;
    reg aluOp1;
    reg aluOp2;
    reg [Width-1:0] jampBase;
    wire [Width-1:0] ba;
    
    always @(*)
    begin
        if(j)
            jampBase = op1;
        else 
            jampBase = pc;            
    end
    
    
    assign ba = j==1?(jampBase + immidiate) & 32'hFFFFFFFE:(jampBase + immidiate);
    
        
    always @(posedge clock)
    begin 
           branchAdress <= ba;
    end
    
        
    /*
        This is used for branch pridiction 
    */
    always @(*)
    begin
        if(operandRevers)        
            begin
                aluOp1 = op2;
                aluOp2 = op1;
            end
        else
            begin
                aluOp1 = op1;
                aluOp2 = op2;
            end
            
        if(immidateSelect)
            aluOp2 = immidiate;              
     end
    
    
    
     ALU alu(res,aluOp1,aluOp2,operation,clock);
    
    
endmodule
