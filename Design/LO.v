`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ammar Ahmed Walodi
// 
// Create Date: 06/26/2025 02:58:47 PM
// Design Name: 
// Module Name: LO
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


module LO #(parameter Bits = 32) (clk,reset_n,lo_write,in,out);
input               clk         ;
input               reset_n     ;
input               lo_write    ;
input   [Bits-1:0]  in          ;
output  [Bits-1:0]  out         ;

reg     [Bits-1:0]  lo_reg      ;

always @(posedge clk or negedge reset_n)
begin
    if (~reset_n)
    lo_reg <= 32'b0;
    else if(lo_write)
    lo_reg <= in;
    else
    lo_reg <= lo_reg;
end

assign out =lo_reg ;

endmodule
