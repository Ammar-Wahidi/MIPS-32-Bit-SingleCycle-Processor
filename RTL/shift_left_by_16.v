`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ammar Wahidi
// 
// Create Date: 06/26/2025 02:19:42 PM
// Design Name: 
// Module Name: shift_left_by_16
// Project Name: MIPS
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


module shift_left_by_16 #(parameter Bits = 32)(
input   [Bits-1:0]  imm,
output  [Bits-1:0]  out_shifted
);

assign out_shifted = imm <<16;

endmodule
