`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Addis Ababa University 
// Engineer: Donayam
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
    output [Width-1:0] op1,
    output [Width-1:0] op2,
    output reg[Width-1:0] immediate,
    output reg[Width-1:0] PC,
    output reg[5:0] Rd,
        
        
    output reg[3:0] operation, //the alu operation to perform
    output reg operandRevers, //indicates the operand should be reversed in the alu for performing grater than or equal to for branch instruciton
    output reg immidateSelect, // select the immidiate filed for alu operation 
    output reg j,               //indicates the instruction is jamp
    output reg R, //control line  read signal   
    output reg W, //control for the WB stage
    
    
    input [Width-1:0]pc,
    
        
    input w,    
    input [5:0] rd,
    input [Width-1:0]wdata,
    
    input [Width-1:0] Instruction,
    input clock
    );
        localparam [6:0] R_TYPE = 7'b0110011,// Opcodes
                    I_TYPE = 7'b0010011,
                    LUI=7'b0110111,
                    AUIPC = 7'b0010111,
                    JAL = 7'b1101111,
                    JALR = 7'b1100111,
                    
                    B_TYPE = 7'b1100011,
                    LOAD =7'b0000011,  
                    STORE = 7'b0100011
                    ;    

    
    wire  [Width-1:0]rdata1;
    wire  [Width-1:0]rdata2;
    
    wire [5:0] rs1;
    wire [5:0] rs2;
    wire [2:0] func3;
    wire [6:0] func7;
    
    assign rs1 = Instruction[19:15];
    assign rs2 = Instruction[24:20];
    assign func3 =  Instruction[14:12];
    assign func7 =  Instruction[31:25];
    
        RegisterFile rf(op1,op2,rs1,rs2,rd,w,r,wdata,clock);
    
        //immediate filed determination         
        always @(posedge clock)
        begin

            Rd <= Instruction[11:7];
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
                        immediate <= {Instruction[31:12],{12'h0}};//{12{0}}};
                    end
                 JAL:    
                    begin                        
                        immediate <= {{11{Instruction[31]}}, {{Instruction[31],Instruction[19:12],Instruction[20],Instruction[30:21]}<<1}};                        
                    end
                 JALR:    
                    begin                        
                        immediate <= {{20{Instruction[31]}},Instruction[31:20]};
                    end 
                 B_TYPE:    
                    begin                        
                        immediate <= {{20{Instruction[31]}},{{Instruction[31],Instruction[7],Instruction[30:25],Instruction[11:8]}<<1}};                        
                    end 
                STORE:
                    begin
                        immediate <= {{20{Instruction[31]}},Instruction[31:25],Instruction[11:7]};
                    end    
                default:
                        immediate <= 32'hx;
            endcase 
        end    
        
        
        always @(posedge clock)
        begin
        
            operandRevers <= 0;
            j<=0;
            operation <= {0,func3};
            immidateSelect <= 0;
            
            case (Instruction[6:0]) //opcode 
                LOAD:
                    begin
                        immidateSelect <= 1'bx;
                    end
                I_TYPE:
                    begin          
                       immidateSelect <= 1;                                    
                    end
                 R_TYPE:
                    begin
                    end
                 LUI,AUIPC:
                    begin
                        immidateSelect <= 1'bx;
                        operation <= 4'b1111;
                    end
                 JAL:    
                    begin        
                        j <=1;                
                    end
                 JALR:    
                    begin    
                        j <=1;                     
                    end 
                 B_TYPE:    
                    begin     
                        j<=1;  
                        if(func3 == 3'b101 || func3 == 3'b111)
                        begin
                            operandRevers <= 1;
                            operation <= 4'b1000; // subtraction                             
                        end                 
                    end 
                STORE:
                    begin
                    end    
                default:
                        immediate <= 32'hx;
            endcase 
        end
        
        
endmodule
