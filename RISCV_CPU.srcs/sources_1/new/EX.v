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
    
    input [1:0]aluOp1Select,     //Selects between op1 and pc (AUIPC) 1-> pc 0->op1
    input [1:0]aluOp2Select,     //selects between op2 and imm        1 -> imm 0 -> op2
    
    input [3:0] operation,  //selected alu operation 
    
    input jBaseSelect,    //selects base address for jump or branch instruction 
    input clock
    );
        
//    wire select;
    reg aluOp1;
    reg aluOp2;
    reg [Width-1:0] jampAddress;
    wire [Width-1:0] ba;
    
    always @(*)
    begin
        if(jBaseSelect)
            jampAddress = (op1 + immidiate) & 32'hFFFFFFFE;
        else 
            jampAddress = pc + immidiate;            
    end
    
    
    //assign ba = jBaseSelect==1?(jampBase + immidiate) & 32'hFFFFFFFE:(jampBase + immidiate);
    
        
    always @(posedge clock)
    begin 
           branchAdress <= jampAddress;
    end
    
        
    /*
        This is used for branch instructions  
    */
    always @(*)
    begin
        case (aluOp1Select)
//            2'b00:
//            begin
                
//            end
            2'b01:
            begin
                aluOp1 = op2;
            end
            2'b10:
            begin
                aluOp1 = pc;
            end
            2'b11:
            begin
                aluOp1 = 0;
            end
            default:
            begin
                aluOp1 = op1;
            end            
        endcase 
        
        case (aluOp2Select)
//            2'b00:
//            begin
                
//            end
            2'b01:
            begin
                aluOp2 = immidiate;
            end
            2'b10:
            begin
                aluOp2 = op1;
            end
            2'b11:
            begin
                aluOp2 = 4;
            end
            default:
            begin
                aluOp2 = op2;
            end                   
        endcase
                
     end
    
    
    
     ALU alu(res,aluOp1,aluOp2,operation,clock);
    
    
endmodule
