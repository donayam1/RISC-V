`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Addis Ababa University 
// Engineer: Donayam
// 
// Create Date: 01/27/2021 05:52:09 PM
// Design Name: 
// Module Name: IDTest
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


module IDTB #(parameter Width=32)(

    );
    
    wire [Width-1:0] op1;
    wire [Width-1:0] op2;
    wire [Width-1:0] immediate;
    wire [Width-1:0] PC;
    wire [5:0] Rd;
    wire [6:0] opcode;
    
    
    wire [5:0] rd;
    wire [Width-1:0]pc;
        
    wire rw;
    wire [Width-1:0]wdata;
    
    wire [Width-1:0] Instruction;
    wire clock;
    
    
    ID id(op1,op2,immediate,PC,Rd,opcode,rd,pc,rw,wdata,Instruction,clock);
    IDTG idtg(op1,op2,immediate,PC,Rd,opcode,rd,pc,rw,wdata,Instruction,clock);
    
endmodule

module IDTG #(parameter Width=32)(
    input [Width-1:0] op1,
    input [Width-1:0] op2,
    input [Width-1:0] immediate,
    input [Width-1:0] PC,
    input [5:0] Rd,
    input [6:0] opcode,
    
    
    output reg[5:0] rd,
    output reg[Width-1:0]pc,
        
    output reg rw,
    output reg[Width-1:0]wdata,
    
    output reg[Width-1:0] Instruction,
    output reg clock
    );
    
    initial 
    begin
        
        #0 clock=0;Instruction=0;wdata=0;pc=0;rd=0;rw=0;        
        #1 clock=0;        
        
        for (integer i=0;i<=31;i=i+1)
        begin 
            #1 clock=1;rw=1;rd=i; wdata=i;
            #1 clock=0;
        end
        
        #1 clock=1;pc=4;Instruction=32'h00064537;rw=0;//lui x10,100         
        #1 clock=0;
            if(immediate != 32'h64000 || Rd != 10 || PC != 4 || opcode != 7'b0110111)
                begin
                    $display("Error decoding lui. Expected immediate %d, actual immediate %d. Expected Rd %d, Actual Rd %d",32'h64000,immediate,10,Rd);
                end
        #1 clock=1;pc=8;Instruction=32'h00064517;//auipc x10,100         
        #1 clock=0;
            if(immediate != 32'h64000 || Rd != 10 || PC != 8 || opcode != 7'b0010111)
                begin
                    $display("Error decoding auipc. Expected immediate %d, actual immediate %d. Expected Rd %d, Actual Rd %d",32'h64000,immediate,10,Rd);
                end      
        #1 clock=1;pc=12;Instruction=32'h0100056f;//jal x10,0x10         
        #1 clock=0;
            if(immediate != 32'h10 || Rd != 10 || PC != 12 || opcode != 7'b1101111)
                begin
                    $display("Error decoding jal. Expected immediate %d, actual immediate %d. Expected Rd %d, Actual Rd %d",32'h10,immediate,10,Rd);
                end        
                    
        #1 clock=1;pc=16;Instruction=32'h06458567;//jalr x10,x11,100         
        #1 clock=0;
            if(immediate != 100 || Rd != 10 || PC != 16 || opcode != 7'b1100111 || op1 != 11 || op2 != 4 )
                begin
                    $display("Error decoding jalr. Expected immediate %d, actual immediate %d. Expected Rd %d, Actual Rd %d",100,immediate,10,Rd);
                end 
        
        #1 clock=1;pc=20;Instruction=32'h0B50C63;//beq x10,x11,0x18         
        #1 clock=0;
            if(immediate != 12'h18 || Rd != 24 || PC != 20 || opcode != 7'b1100011  || op1 != 10) //op2=11
                begin
                    $display("Error decoding beq. Expected immediate %d, actual immediate %d. Expected Rd %d, Actual Rd %d",12'h18,immediate,10,Rd);
                end
                
        #1 clock=1;pc=24;Instruction=32'h0645A503;//lw x10,x11,0x64
        #1 clock=0;
            if(immediate != 32'h64 || PC != 24 || opcode != 7'b0000011   || op1 != 11 || op2 != 4 )
                begin
                    $display("Error decoding lw. Expected immediate %d, actual immediate %d. Expected Rd %d, Actual Rd %d",12'h64,immediate,10,Rd);
                end    
                         
        #1 clock=1;pc=28;Instruction=32'h06A5A223;//sw x10,x11,0x64
        #1 clock=0;
            if(immediate != 32'h64 || PC != 28 || opcode != 7'b0100011    || op1 != 11 || op2 != 10 )
                begin
                    $display("Error decoding sw. Expected immediate %d, actual immediate %d. Expected Rd %d, Actual Rd %d",12'h64,immediate,10,Rd);
                end   
                                
        #1 clock=1;pc=32;Instruction=32'h019000593;//addi x11,x0,400                               
        #1 clock=0;
             if(immediate != 32'h190 || PC != 32 || opcode != 7'b0010011 || Rd !=11   || op1 != 0 || op2 != 16 )
                begin
                    $display("Error decoding addi. Expected immediate %d, actual immediate %d. Expected Rd %d, Actual Rd %d",12'h64,immediate,11,Rd);
                end 
                
        #1 clock=1;pc=34;Instruction=32'hB50E33;//add x28,x10,x11                              
        #1 clock=0;
             if(immediate != 32'h0 || PC != 34 || opcode != 7'b0110011 || Rd !=28   || op1 != 10 || op2 != 11 )
                begin
                    $display("Error decoding add. Expected immediate %d, actual immediate %d. Expected Rd %d, Actual Rd %d",12'h64,immediate,11,Rd);
                end         
                    
        #1 $finish ;
    
        
    end
    
    
endmodule