`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2021 01:20:55 PM
// Design Name: 
// Module Name: ALU
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


module  ALU #(parameter Width=32) (
    output  reg [Width-1:0] res,
    input signed [Width-1:0] op1,
    input signed [Width-1:0] op2,
    input [3:0] operation,
    input clock
    );
    localparam [2:0] ADD = 4'b0000,// 
                     SUB = 4'b1000,
                     SLT = 4'b0010,
                    SLTU = 4'b0011,
                     XOR = 4'b0100,
                      OR = 4'b0110,
                     AND = 4'b0111,
                     SLL = 4'b0001,
                     SRL = 4'b0101,
                     SRA = 4'b1101;
                    
     wire [Width-1:0] uop1,uop2;
     assign uop1 = op1;
     assign uop2= op2;
    
        always @(posedge clock)
            begin            
            case (operation)
                ADD: begin
                    res <= op1 + op2;
                    end 
                SUB: begin
                    res <= op1 - op2;
                end   
                SLT: begin
                    res <= op1 < op2;
                end                
                SLTU: begin
                    res <= op1 < op2;
                end
                XOR: begin
                    res <= op1^op2;
                end
                OR: begin
                    res <= op1 | op2;
                end
                AND: begin
                    res <= op1 & op2;
                end
                SLL: begin
                    res <= op1 << op2[4:0];
                end
                SRL: begin
                    res <= op1 >> op2[4:0];
                end
                SRA: begin
                    res <= op1 >>> op2[4:0];
                end
                endcase            
            end    
endmodule
