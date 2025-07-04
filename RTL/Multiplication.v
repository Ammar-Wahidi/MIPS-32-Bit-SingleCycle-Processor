`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/26/2025 02:40:40 PM
// Design Name: 
// Module Name: Multiplication
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


module Multiplication #(parameter Bits = 32)(multiplier,multiplicand,unsigned_instr,product);
input       [Bits-1:0]            multiplier     ;
input       [Bits-1:0]            multiplicand   ;
input                             unsigned_instr ; // 1 for MULTU; 0 for MULT
output      [(2*Bits-1):0]        product        ;

reg         [(2*Bits-1):0]        product_reg    ;

// unsigned_instr = 1 for MULTU; 0 for MULT
always @(*)
begin
    if (unsigned_instr)
        product_reg = multiplier * multiplicand       ;
    else
        product_reg = $signed(multiplier) * $signed(multiplicand)  ;
end

assign product = product_reg      ;

endmodule
