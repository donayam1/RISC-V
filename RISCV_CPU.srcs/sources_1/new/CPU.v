`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2021 02:19:48 PM
// Design Name: 
// Module Name: CPU
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


module CPU #(parameter Width=32,Addbits=8)(
        input en,
        input clock
    );
    
    
    //load default instructions to the instruction cache
    wire  [Width-1:0] pc;
    wire [Width-1:0] instruction;
    
    wire [Width-1:0] branchAddress;      
    wire branch;
    
    wire [Addbits-1:0] waddress;
    wire [Width-1:0] wdata;
    wire ifw;
    wire ifen;
    
    assign ifen = en;
    
    initial
    begin
        
    end
    
    
    
    IF instractionFetch(pc,instruction,branchAddress,branch,        
                        waddress,wdata,ifw,ifen,clock);
    
    
    wire [Width-1:0] op1;
    wire [Width-1:0] op2;
    wire [Width-1:0] immediate;
    wire [Width-1:0] PCd;
    wire [5:0] Rd;
    wire [3:0] operation; //the alu operation to perform
    wire [1:0] aluOp1Select,aluOp2Select;
    wire j;               //indicates the instruction is jamp
    wire R; //control line  read signal   
    wire W; //control for the WB stage
    
    wire idw;
    wire idwdata;
    
    ID id(op1,op2,immediate,PCd,Rd,operation, aluOp1Select,aluOp2Select,
          j,R,W,pc,idw,rd,idwdata,instruction,clock);
    
    
    
    
endmodule
