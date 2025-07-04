`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ammar Ahmed Wahidi
// 
// Create Date: 06/26/2025 02:58:47 PM
// Design Name: 
// Module Name: HI
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


module HI #(parameter Bits = 32) (clk,reset_n,hi_write,in,out);
input               clk         ;
input               reset_n     ;
input               hi_write    ;
input   [Bits-1:0]  in          ;
output  [Bits-1:0]  out         ;

reg     [Bits-1:0]  hi_reg      ;

always @(posedge clk or negedge reset_n)
begin
    if (~reset_n)
    hi_reg <= 32'b0;
    else if(hi_write)
    hi_reg <= in;
    else
    hi_reg <= hi_reg;
end

assign out =hi_reg ;

endmodule
