`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ammar Wahidi
// 
// Create Date: 06/26/2025 02:46:23 PM
// Design Name: Division Module
// Module Name: Division
// Project Name: MIPS
// Target Devices: 
// Tool Versions: 
// Description: 
//   Performs unsigned 32-bit division and outputs the quotient and remainder.
//
// Dependencies: None
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// - Make sure to avoid division by zero.
//
//////////////////////////////////////////////////////////////////////////////////


module Division(dividend,divisor,unsigned_instr,quotient,remainder);
input   [31:0]      dividend        ;
input   [31:0]      divisor         ;
input               unsigned_instr  ; // 1: DIVU, 0: DIV
output  [31:0]      quotient        ;
output  [31:0]      remainder       ;

reg     [31:0]      quotient_reg    ;
reg     [31:0]      remainder_reg   ;

always @(*) begin
    if (divisor != 0) begin
        if (unsigned_instr) begin
            quotient_reg  = dividend / divisor;
            remainder_reg = dividend % divisor;
        end else begin
            quotient_reg  = $signed(dividend) / $signed(divisor);
            remainder_reg = $signed(dividend) % $signed(divisor);
        end
    end else begin
        quotient_reg  = 0;
        remainder_reg = 0;
    end
end

assign quotient  = quotient_reg;
assign remainder = remainder_reg;

endmodule
