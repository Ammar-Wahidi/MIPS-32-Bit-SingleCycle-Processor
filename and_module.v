`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/24/2025 12:18:05 AM
// Design Name: 2 input AND Gate Module
// Module Name: and_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//   This module implements a simple 1-bit AND gate. It is typically used
//   in MIPS processors to generate the `PCSrc` signal by ANDing the `Branch`
//   control signal with the `Zero` flag from the ALU.
//
// Dependencies: None
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//   - Parameter `Bits` is defined but not used; can be removed or extended
//     for future multi-bit support.
//   - Corrected a typo in the output wire name: `PCScr` ? `PCSrc`
//////////////////////////////////////////////////////////////////////////////////


module and_2input_module #(parameter Bits =1)(
input Branch,
input Zero,
output PCSrc
    );
    
    assign PCSrc = Branch & Zero;
    
endmodule
