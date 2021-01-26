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
    output reg[Width-1:0] res,
    input [Width-1:0] op1,
    input [Width-1:0] op2,
    input [5:0] Operation
    );
    localparam [2:0] ADDI = 3'b000,// The state labels and their assignments
                    SLTI = 3'b010,
                    SLTIU = 3'b011,
                    XORI = 3'b100,
                    ORI = 3'b110,
                    ANDI = 3'b111,
                    SLLI = 3'b001,
                    SRLI = 3'b101,
                    SRAI = 3'b101;
    
    
        always @(*)
            begin            
            case (Operation)
                6'b000000: //ADDI
                    begin
                        res = op1 + op2;
                    end
                
                endcase
            
            end
    
endmodule
