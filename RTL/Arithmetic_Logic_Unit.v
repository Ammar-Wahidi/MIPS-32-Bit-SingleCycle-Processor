`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ammar Wahidi
// 
// Create Date: 06/23/2025 07:39:35 PM
// Design Name: Arithmetic Logic Unit
// Module Name: Arithmetic_Logic_Unit
// Project Name: MIPS
// Target Devices: 
// Tool Versions: 
// Description: 32-bit ALU for MIPS processor
// 
// Dependencies: None
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Supports basic arithmetic, logic, and comparison ops
/////////////////////////////////////////////////////////////////////////////////


module Arithmetic_Logic_Unit(Src_A,Src_B,shamt,ALU_control,result,zero,N,V,C);

//Inputs
input           [31:0]      Src_A               ;
input           [31:0]      Src_B               ;
input           [4:0]       shamt               ;
input           [4:0]       ALU_control         ;
//Outputs 
output                      zero                ;
output                      N                   ;
output                      V                   ;
output                      C                   ;
output          [31:0]      result              ;


// Parameterized ALU operation codes
parameter                   ALU_OR  = 5'b00001    ;
parameter                   ALU_AND = 5'b00000    ;
parameter                   ALU_ADD = 5'b00010    ;
parameter                   ALU_SUB = 5'b00110    ;
parameter                   ALU_SLT = 5'b00111    ;
parameter                   ALU_SLL = 5'b01000    ;
parameter                   ALU_SRL = 5'b01001    ;
parameter                   ALU_SRA = 5'b01010    ;
parameter                   ALU_SLLV= 5'b10100    ;
parameter                   ALU_SRLV= 5'b10101    ;
parameter                   ALU_SRAV= 5'b10110    ;
parameter                   ALU_XOR = 5'b00011    ;
parameter                   ALU_NOR = 5'b01100    ;
parameter                   ALU_SRB = 5'b00100    ;
parameter                   ALU_MUL = 5'b01110    ;
parameter                   ALU_DIV = 5'b01111    ;
parameter                   ALU_SLTU= 5'b01101    ;
parameter                   ALU_ADDU= 5'b00101    ;
parameter                   ALU_SUBU= 5'b01011    ;

reg             [31:0]      result_reg          ;
reg                         C_reg               ;
reg                         V_reg               ;
// ALU Operation Selection
always @(*)
begin
    C_reg = 0; // Default: no carry
    V_reg = 0; // Default: no overflow
    case (ALU_control)
    ALU_OR: result_reg = Src_A | Src_B;              // Bitwise OR
    ALU_AND: result_reg = Src_A & Src_B;              // Bitwise AND
    ALU_ADD:
    begin 
        {C_reg,result_reg} = Src_A + Src_B;              // Addition
        V_reg = (~Src_A[31] & ~Src_B[31] & result_reg[31]) | (Src_A[31] & Src_B[31] & ~result_reg[31]); //MSB(b) and MSB(r) ≠ MSB(a)
    end
    ALU_SUB:
    begin
        result_reg = Src_A - Src_B;              // Subtraction
        C_reg = (Src_A < Src_B);
        V_reg = (~Src_A[31] & Src_B[31] & result_reg[31]) | (Src_A[31] & ~Src_B[31] & ~result_reg[31]); //MSB(a) ≠ MSB(b) and MSB(r) ≠ MSB(a)
    end
    ALU_ADDU:
    begin
        {C_reg,result_reg} = Src_A + Src_B;              // Addition
    end
    ALU_SUBU:
    begin
        result_reg = Src_A - Src_B;              // Subtraction
        C_reg = (Src_A < Src_B);
    end
    ALU_SLT:  result_reg = ($signed(Src_A) < $signed(Src_B)) ? 32'b1 : 32'b0; // Set-on-less-than
    ALU_SLL:  result_reg = Src_B<<shamt; // Logical shift left by shamt
    ALU_SRL:  result_reg = Src_B>>shamt; // Logical shift right by shamt
    ALU_SRA:  result_reg = $signed(Src_B)>>>shamt; // Arithmetic shift right by shamt
    ALU_SLLV: result_reg = Src_B<<Src_A[4:0];  // Logical shift left by Src_A value
    ALU_SRLV: result_reg = Src_B>>Src_A[4:0]; // Logical shift right by Src_A value
    ALU_SRAV: result_reg = $signed(Src_B)>>>Src_A[4:0];  // Arithmetic shift right by Src_A value
    ALU_XOR : result_reg = Src_A ^ Src_B; // Bitwise XOR
    ALU_NOR : result_reg = ~(Src_A | Src_B); // Bitwise NOR
    ALU_SRB : result_reg = Src_B; // Pass-through B operand
    ALU_MUL : result_reg = Src_A * Src_B; // Signed multiplication (lower 32 bits used)
    ALU_SLTU: result_reg = Src_A < Src_B ? 32'd1 : 32'd0; // Set-on-less-than unsigned
    default:result_reg = 32'd0; 
    endcase
end

assign result = result_reg;
assign zero   = ~|result ;
assign C      = C_reg;
assign N      = result_reg[31];
assign V      = V_reg;
 
endmodule
