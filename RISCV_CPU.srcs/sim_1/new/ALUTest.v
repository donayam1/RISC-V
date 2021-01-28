`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/28/2021 09:56:56 PM
// Design Name: 
// Module Name: ALUTest
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


module ALUTB #(parameter Width=32)(
    );
    
    wire  signed [Width-1:0] res;    
    wire  signed [Width-1:0] op1;
    wire  signed [Width-1:0] op2;
    wire  [3:0] operation;
    wire  clock;
    
    ALU alu(res,op1,op2,operation,clock);
    ALUTG alutg(res,op1,op2,operation,clock);
    
endmodule

module ALUTG #(parameter Width=32)(
    input   signed [Width-1:0] res,
    
    output reg signed [Width-1:0] op1,
    output reg signed [Width-1:0] op2,
    output reg [3:0] operation,
    output reg clock
    );
    
    initial
    begin
        #0 clock=0;op1=0;op2=0;operation=0;
        #1 clock=1;operation=4'b0000;op1=1;op2=-1; //add 
        #1 clock=0;
            if(res !=0)
                $display("Error addition is not working");
                
        #1 clock=1;operation=4'b1000;op1=10;op2=1; //sub
        #1 clock=0;
            if(res !=9)
                $display("Error subtraction is not working");
                   
        #1 clock=1;
        #1 clock=0;                        
        #1 $finish;
    end
    
endmodule