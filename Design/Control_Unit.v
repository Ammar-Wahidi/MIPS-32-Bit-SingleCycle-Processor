`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ammar Wahidi
// 
// Create Date: 06/23/2025 11:42:18 PM
// Design Name: MIPS Control Unit
// Module Name: Control_Unit
// Project Name: MIPS Processor
// Target Devices: 
// Tool Versions: 
// Description: 
//   Top-level control unit that generates control signals based on instruction
//   opcode and function fields. This unit instantiates two submodules:
//   1. Main_Decoder: generates high-level control signals and ALUOp
//   2. ALU_Decoder: determines specific ALU operation using Funct and ALUOp
//
// Dependencies: Main_Decoder.v, ALU_Decoder.v
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//   - Supports basic MIPS instructions: R-type, lw, sw, beq, addi, jump
//////////////////////////////////////////////////////////////////////////////////


module Control_Unit (OPcode,Funct,rt,MemtoReg,MemWrite,Branch,ALUSrc,RegDst,RegWrite,Jump,ALU_control,hi_src,lo_src,mem_data_size,JumpReg,sign,hi_w,lo_w,unsigned_instr);

//inputs
input       [5:0]   OPcode; // Instruction[31:26] - primary opcode
input       [5:0]   Funct;  // Instruction[5:0] - function field (R-type)
input       [4:0]   rt;

//Output
output      [2:0]   MemtoReg;
output              MemWrite;
output      [2:0]   Branch;
output      [1:0]   ALUSrc;
output      [1:0]   RegDst;
output              RegWrite;
output              Jump;
output      [4:0]   ALU_control ;
output      [1:0]   hi_src;
output      [1:0]   lo_src;
output              JumpReg;
output      [1:0]   mem_data_size;
output              sign;
output              hi_w;
output              lo_w;
output              unsigned_instr;

wire        [3:0]   ALUOp;

// Generates control signals and ALUOp based on opcode
Main_Decoder MainDecoder (
.OPcode(OPcode),
.Funct(Funct),
.rt(rt),
.MemtoReg(MemtoReg),
.MemWrite(MemWrite),
.Branch(Branch),
.ALUSrc(ALUSrc),
.RegDst(RegDst),
.RegWrite(RegWrite),
.Jump(Jump),
.ALUOp(ALUOp),
.hi_src(hi_src),
.lo_src(lo_src),
.JumpReg(JumpReg),
.mem_data_size(mem_data_size),
.sign(sign),
.hi_w(hi_w),
.lo_w(lo_w),
.unsigned_instr(unsigned_instr)
);

// Selects actual ALU operation using funct field and ALUOp
ALU_Decoder ALUDecoder (
.Funct(Funct),
.ALUOp(ALUOp),
.ALU_control(ALU_control)
);

endmodule
