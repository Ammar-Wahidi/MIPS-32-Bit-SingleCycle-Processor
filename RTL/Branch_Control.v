`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ammar Wahidi
// 
// Create Date: 06/26/2025 03:13:35 PM
// Design Name: Branch Control Logic
// Module Name: Branch_Control
// Project Name: MIPS
// Target Devices: 
// Tool Versions: 
// Description: 
//     Generates the PCSrc signal for branching based on the branch type and flags
//     from the ALU (Zero, Negative, Overflow, Carry).
// 
// Dependencies: None
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//     - Supports various signed branch conditions like EQ, NE, LT, GE, LE, GT.
// 
//////////////////////////////////////////////////////////////////////////////////



module Branch_Control(branch,zero_flag,N_flag,V_flag,C_flag,PCSrc);
input       [2:0]       branch      ;
input                   zero_flag   ;
input                   N_flag      ;
input                   V_flag      ;
input                   C_flag      ;
output reg              PCSrc       ;

// Condition wires derived from ALU flags
wire EQ,NE,LT,GE,LE,GT;

assign EQ = zero_flag;
assign NE = !zero_flag;
assign LT = N_flag ^ V_flag;
assign GE = N_flag ~^ V_flag; 
assign LE = (N_flag ^ V_flag) | zero_flag ; 
assign GT = ~((N_flag ^ V_flag) | zero_flag) ; 

always @(*)
begin
    case(branch)
    0:PCSrc = 1'b0;         // No branch
    1:PCSrc = EQ;           // Branch if Equal (BEQ)
    2:PCSrc = NE;           // Branch if Not Equal (BNE)
    3:PCSrc = LT;           // Branch if Less Than (BLT)
    4:PCSrc = GE;           // Branch if Greater or Equal (BGE)
    5:PCSrc = LE;           // Branch if Less Than or Equal (BLE)
    6:PCSrc = GT;           // Branch if Greater Than (BGT)
    default:PCSrc = 1'b0;   // Default: No branch
    endcase
end
endmodule
