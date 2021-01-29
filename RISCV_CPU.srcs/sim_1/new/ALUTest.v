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
                
        #1 clock=1;operation=4'b1000;op1=1;op2=-1; //sub
        #1 clock=0;
            if(res !=2)
                $display("Error subtraction is not working");

        #1 clock=1;operation=4'b0010;op1=4;op2=1; //slt
        #1 clock=0;
            if(res !=0)
                $display("Error slt is not working");
        #1 clock=1;operation=4'b0010;op1=4;op2=8; //slt
        #1 clock=0;
            if(res !=1)
                $display("Error slt is not working");

        #1 clock=1;operation=4'b0010;op1=-4;op2=2; //slt
        #1 clock=0;
            if(res !=1)
                $display("Error slt is not working");

        #1 clock=1;operation=4'b0011;op1=-4;op2=2; //sltu
        #1 clock=0;
            if(res !=0)
                $display("Error sltu is not working");
                
        #1 clock=1;operation=4'b0011;op1=7;op2=-1; //sltu
        #1 clock=0;
            if(res !=1)
                $display("Error sltu is not working");                

        #1 clock=1;operation=4'b0100;op1=32'h60;op2=32'h39; //xor
        #1 clock=0;
            if(res !=32'h59)
                $display("Error xor is not working");
        
        #1 clock=1;operation=4'b0110;op1=5;op2=5; //or
        #1 clock=0;
            if(res !=5)
                $display("Error or is not working");

        #1 clock=1;operation=4'b0111;op1=32'h50;op2=32'h70; //or
        #1 clock=0;
            if(res !=32'h50)
                $display("Error and is not working");
                                                     
        #1 clock=1;operation=4'b0001;op1=100;op2=5; //or
        #1 clock=0;
            if(res !=3200)
                $display("Error SLL is not working");

        #1 clock=1;operation=4'b0101;op1=3200;op2=5; //or
        #1 clock=0;
            if(res !=100)
                $display("Error SRL is not working");
        #1 clock=1;operation=4'b0101;op1=-3200;op2=5; //or
        #1 clock=0;
            if(res !=134217628)
                $display("Error SRL is not working");
                                
        #1 clock=1;operation=4'b1101;op1=3200;op2=5; //or
        #1 clock=0;
            if(res !=100)
                $display("Error SRA is not working");

        #1 clock=1;operation=4'b1101;op1=-3200;op2=5; //or
        #1 clock=0;
            if(res !=-100)
                $display("Error SRA is not working");
                                              
        #1 clock=1;
        #1 clock=0;                        
        #1 $finish;
    end
    
endmodule