`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ammar Wahidi
// 
// Create Date: 06/23/2025 08:29:57 PM
// Design Name: ALU Decoder
// Module Name: ALU_Decoder
// Project Name: MIPS
// Target Devices: 
// Tool Versions: 
// Description: 
//  - This module decodes the ALU operation based on ALUOp (from Main Decoder)
//    and function field (for R-type instructions).
// 
// Dependencies: None
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU_Decoder(Funct,ALUOp,ALU_control);

//Inputs
input       [5:0]       Funct           ;
input       [3:0]       ALUOp           ;
//Outputs
output      [4:0]       ALU_control     ;

reg         [4:0]       ALU_control_reg ;
always @(*)
begin
    case(ALUOp)
    4'b0000:ALU_control_reg = 5'b00010; //add
    4'b0001:ALU_control_reg = 5'b00110; //sub
    4'b0010:
    begin
        case(Funct)
        6'b100000:ALU_control_reg = 5'b00010 ; //add 
        6'b100010:ALU_control_reg = 5'b00110 ; //sub
        6'b100100:ALU_control_reg = 5'b00000 ; //and
        6'b100101:ALU_control_reg = 5'b00001 ; //or
        6'b101010:ALU_control_reg = 5'b00111 ; //slt (set on less than)
        6'b000000:ALU_control_reg = 5'b01000 ; //sll (shift left logic)
        6'b000010:ALU_control_reg = 5'b01001 ; //srl (shift right logic)
        6'b000011:ALU_control_reg = 5'b01010 ; //sra (shift right arithmetic)
        6'b000100:ALU_control_reg = 5'b10100 ; //sllv (shift left logic var)
        6'b000110:ALU_control_reg = 5'b10101 ; //srlv (shift right logic var)
        6'b000111:ALU_control_reg = 5'b10110 ; //srav (shift right arithmetic var)
        6'b100110:ALU_control_reg = 5'b00011 ; //xor
        6'b100111:ALU_control_reg = 5'b01100 ; //nor
        6'b100001:ALU_control_reg = 5'b00101 ; //addu
        6'b100011:ALU_control_reg = 5'b01011 ; //subu
        6'b101011:ALU_control_reg = 5'b01101 ; //sltu
        default:ALU_control_reg =5'b10000; //no opertion
        endcase
    end  
    4'b0011:ALU_control_reg =5'b00000; //and
    4'b0100:ALU_control_reg =5'b00001; //or
    4'b0101:ALU_control_reg =5'b00011; //xor
    4'b0110:ALU_control_reg =5'b00100; //Transfer SrcB 
    4'b0111:ALU_control_reg =5'b01110; //mul
    4'b1001:ALU_control_reg =5'b01111; //div
    4'b1010:ALU_control_reg =5'b01101; //sltu
    4'b1011:ALU_control_reg =5'b00111; //slt
    4'b1100:ALU_control_reg =5'b00101; //addu
    default:ALU_control_reg =5'b10000; //no opertion
    endcase
        
end

assign ALU_control = ALU_control_reg;
endmodule
