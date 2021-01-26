`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2021 01:49:14 PM
// Design Name: 
// Module Name: ID
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


module ID #(parameter Width=32)(
    output reg[Width-1:0] op1,
    output reg[Width-1:0] op2,
    output reg[Width-1:0] immediate,
    output reg[Width-1:0] PC,
    output reg[5:0] Rd,
    
    
    input [5:0] rd,
    input [Width-1:0]pc,
        
    input rw,
    input [Width-1:0]wdata,
    
    input [Width-1:0] Instruction,
    input clock
    );
        localparam [6:0] R_TYPE = 7'b0110011,// The state labels and their assignments
                    I_TYPE = 7'b0010011,
                    LUI=7'b0110111,
                    AUIPC = 7'b0010111,
                    JAL = 7'b1101111,
                    JALR = 7'b1100111,
                    
                    B_TYPE = 7'b1100011,
                    LOAD =7'b0000011,  
                    STOR = 7'b0100011
                    ;    

    
    wire  [Width-1:0]rdata1;
    wire  [Width-1:0]rdata2;
    
    wire [5:0] rs1;
    wire [5:0] rs2;

    
    assign rs1 = Instruction[19:15];
    assign rs2 = Instruction[24:20];
     
    
        RegisterFile rf(rdata1,rdata2,rs1,rs2,rd,rw,wdata,clock);
    
        always @(posedge clock)
        begin

            Rd <= Instruction[11:7];
            op1 <= rdata1;
            op2 <= rdata2;
            PC <= pc;
            
            case (Instruction[6:0]) //opcode 
                I_TYPE,LOAD:
                    begin                        
                        immediate <= {{20{Instruction[31]}}, Instruction[31:20] };                        
                    end
                 R_TYPE:
                    begin
                        immediate <= {{20{Instruction[31]}}, Instruction[31:25] };                        
                    end
                 LUI,AUIPC:
                    begin
                        immediate[Width-1:0] <= {Instruction[31:12],{12{0}}};
                    end
                 JAL:    
                    begin                        
                        immediate <= {{12{Instruction[31]}},Instruction[31],Instruction[19:12],Instruction[20],Instruction[30:21]};                        
                    end
                 JALR:    
                    begin                        
                        immediate <= {{20{Instruction[31]}},Instruction[31:20]};
                    end 
                 B_TYPE:    
                    begin                        
                        immediate <= {{20{Instruction[31]}},Instruction[31],Instruction[8],Instruction[30:25],Instruction[11:8]};                        
                    end 
                STOR:
                    begin
                        immediate <= {{20{Instruction[31]}},Instruction[31:25],Instruction[11:7]};
                    end    
            endcase 
        end    
endmodule
