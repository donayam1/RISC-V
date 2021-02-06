`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/30/2021 10:15:59 PM
// Design Name: 
// Module Name: Cache
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


module Cache #(parameter Width=32,MemWidth=8,Size=256,Addbits=8)(
    output reg [Width-1:0] data,
    
    input [Addbits-1:0] raddress,
    input r,
    
    input [Width-1:0] wdata,
    input [Addbits-1:0] waddress,
    input w,
    

    input clock
);

    reg [MemWidth-1:0] mem [Size-1:0];    
    always @(posedge clock)
    begin        
        if(r)            
            begin 
                data <= {mem[raddress],mem[raddress+1],mem[raddress+2],mem[raddress+3]};
            end
    end
    
    always @(negedge clock)
    begin
        if(w)
            begin
                mem[waddress] = wdata[31:24];
                mem[waddress+1] = wdata[23:16];
                mem[waddress+2] = wdata[15:8];
                mem[waddress+3] = wdata[7:0];
            end
       
    end
    
endmodule 



module InstructionROM #(parameter Width=32,MemWidth=8,Size=256,Addbits=8)(
    output reg [Width-1:0] data,
    
    input [Addbits-1:0] raddress,
    input r,
    
    input [Width-1:0] wdata,
    input [Addbits-1:0] waddress,            
    input w,
    
    input clock
);
    initial
    begin
     data <= 32'h13; //NOP instruction addi x0,x0,0
    end
      
    always @(posedge clock)
    begin        
        if(r)            
            begin 
                case (raddress)
                    8'd0: data <= 32'h06400513; //addi x10,x0,0x64
                    8'd4: data <= 32'h06400593; //addi x10,x0,0x64
                    8'd8: data <= 32'h06400593; //add x12,x10,x11
                    8'd12: data <= 32'h06400593; //add x12,x10,x11
                    8'd16: data <= 32'h06400593; //add x12,x10,x11                         
                    default:
                        data <= 32'h13; //NOP instruction addi x0,x0,0    
                endcase
                //data <= {mem[waddress],mem[waddress+1],mem[waddress+2],mem[waddress+3]};
            end
    end
    
    
    
endmodule 
