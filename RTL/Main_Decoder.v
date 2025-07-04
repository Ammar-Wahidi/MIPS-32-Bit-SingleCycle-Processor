`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ammar Wahidi
// 
// Create Date: 06/23/2025 07:59:05 PM
// Design Name: Main Decoder
// Module Name: Main_Decoder
// Project Name: MIPS
// Target Devices: 
// Tool Versions: 
// Description: Control unit generating main control signals for MIPS datapath
//              based on instruction opcode.
// 
// Dependencies: None
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// - Based on MIPS single-cycle control logic.
// 
//////////////////////////////////////////////////////////////////////////////////

module Main_Decoder(OPcode,Funct,rt,MemtoReg,MemWrite,Branch,ALUSrc,RegDst,RegWrite,ALUOp,Jump,hi_src,lo_src,mem_data_size,JumpReg,sign,hi_w,lo_w,unsigned_instr);

//inputs
input       [5:0]   OPcode;
input       [5:0]   Funct;
input       [4:0]   rt;
//Output
output      [2:0]   MemtoReg;
output              MemWrite;
output      [2:0]   Branch;
output      [1:0]   ALUSrc;
output      [1:0]   RegDst;
output              RegWrite;
output              Jump;
output      [3:0]   ALUOp;
output      [1:0]   hi_src;
output      [1:0]   lo_src;
output              JumpReg;
output      [1:0]   mem_data_size;
output              sign;
output              hi_w;
output              lo_w;
output              unsigned_instr;

// Opcode Parameters 
parameter           OP_RTYPE = 6'b000000;
parameter           OP_LW    = 6'b100011;
parameter           OP_SW    = 6'b101011;
parameter           OP_BEQ   = 6'b000100;
parameter           OP_ADDI  = 6'b001000;
parameter           OP_JUMP  = 6'b000010;
parameter           OP_JUMPAL= 6'b000011;
parameter           OP_LB    = 6'b100000;
parameter           OP_LH    = 6'b100001;
parameter           OP_SB    = 6'b101000;
parameter           OP_SH    = 6'b101001;
parameter           OP_BNE   = 6'b000101;
parameter           OP_BLEZ  = 6'b000110;
parameter           OP_BGTZ  = 6'b000111;
parameter           OP_BLT   = 6'b111001;   // (new op)
parameter           OP_BGE   = 6'b111010;   // (new op)
parameter           OP_BLE   = 6'b111011;   // (new op)
parameter           OP_BGT   = 6'b111100;   // (new op)
parameter           OP_B_TWOB= 6'b000001;
parameter           OP_LUI   = 6'b001111;
parameter           OP_ANDI  = 6'b001100;
parameter           OP_ORI   = 6'b001101;
parameter           OP_XORI  = 6'b001110;
parameter           OP_MUL   = 6'b011100;
parameter           OP_SLTI  = 6'b001010;
parameter           OP_SLTIU = 6'b001011;
parameter           OP_LBU   = 6'b100100;
parameter           OP_LHU   = 6'b100101;
parameter           OP_ADDIU = 6'b001001;

parameter           R_MULT   = 6'b011000;
parameter           R_DIV    = 6'b011010;
parameter           R_MFHI   = 6'b010000;
parameter           R_MFLO   = 6'b010010;
parameter           R_MTHI   = 6'b010001;
parameter           R_MTLO   = 6'b010011;
parameter           R_JUMPR  = 6'b001000;
parameter           R_JUMPALR= 6'b001001;
parameter           R_MULTU  = 6'b011001;
parameter           R_DIVU   = 6'b011011;

reg     [2:0]           MemtoReg_reg;
reg                     MemWrite_reg;
reg     [2:0]           Branch_reg;
reg     [1:0]           ALUSrc_reg;
reg     [1:0]           RegDst_reg;
reg                     RegWrite_reg;
reg                     Jump_reg;
reg     [3:0]           ALUOp_reg;
reg     [1:0]           hi_src_reg;
reg     [1:0]           lo_src_reg;
reg                     JumpReg_reg;
reg     [1:0]           mem_data_size_reg;
reg                     sign_reg;
reg                     hi_w_reg;
reg                     lo_w_reg;
reg                     unsigned_instr_reg;

always @(*)
begin
    case (OPcode)
    OP_RTYPE:
    begin
        case(Funct)
        R_MULT      :{RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b0_01_00_000_0_000_0010_0_01_01_10_0_0_1_1_0 ;
        R_DIV       :{RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b0_01_00_000_0_000_0010_0_10_10_10_0_0_1_1_0 ;
        R_MFHI      :{RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b1_01_00_000_0_010_0010_0_00_00_10_0_0_0_0_0 ;
        R_MFLO      :{RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b1_01_00_000_0_011_0010_0_00_00_10_0_0_0_0_0 ;
        R_MTHI      :{RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b0_01_00_000_0_000_0010_0_00_00_10_0_0_1_0_0 ;
        R_MTLO      :{RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b0_01_00_000_0_000_0010_0_00_00_10_0_0_0_1_0 ;
        R_JUMPR     :{RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b0_01_00_000_0_000_0010_0_00_00_10_1_0_0_0_0 ;
        R_JUMPALR   :{RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b1_10_00_000_0_100_0010_0_00_00_10_1_0_0_0_0 ;
        R_MULTU     :{RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b0_01_00_000_0_000_0010_0_01_01_10_0_0_1_1_1 ;
        R_DIVU      :{RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b0_01_00_000_0_000_0010_0_10_10_10_0_0_1_1_1 ;
        default     :{RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b1_01_00_000_0_000_0010_0_00_00_10_0_0_0_0_0 ;
        endcase     
    end
    OP_LW:    {RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b1_00_01_000_0_001_0000_0_00_00_10_0_1_0_0_0 ;
    OP_SW:    {RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b0_00_01_000_1_000_0000_0_00_00_10_0_1_0_0_0 ;
    OP_BEQ:   {RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b0_00_00_001_0_000_0001_0_00_00_10_0_1_0_0_0 ;
    OP_ADDI:  {RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b1_00_01_000_0_000_0000_0_00_00_10_0_1_0_0_0 ;
    OP_JUMP:  {RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b0_00_00_000_0_000_0000_1_00_00_10_0_1_0_0_0 ;
    OP_JUMPAL:{RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b1_10_00_000_0_100_0000_1_00_00_10_0_1_0_0_0 ;
    OP_LB:    {RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b1_00_01_000_0_001_0000_0_00_00_00_0_1_0_0_0 ;
    OP_LH:    {RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b1_00_01_000_0_001_0000_0_00_00_01_0_1_0_0_0 ;
    OP_SB:    {RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b0_00_01_000_1_000_0000_0_00_00_00_0_1_0_0_0 ;
    OP_SH:    {RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b0_00_01_000_1_000_0000_0_00_00_01_0_1_0_0_0 ;
    OP_B_TWOB:{RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = (rt) ? 28'b0_00_10_100_0_000_0001_0_00_00_10_0_1_0_0_0 : 28'b0_00_10_011_0_000_0001_0_00_00_10_0_1_0_0_0 ;
    OP_BNE:   {RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b0_00_00_010_0_000_0001_0_00_00_10_0_1_0_0_0 ;
    OP_BLEZ:  {RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b0_00_10_101_0_000_0001_0_00_00_10_0_1_0_0_0 ;
    OP_BGTZ:  {RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b0_00_10_110_0_000_0001_0_00_00_10_0_1_0_0_0 ;
    OP_BLT:   {RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b0_00_00_011_0_000_0001_0_00_00_10_0_1_0_0_0 ;
    OP_BGE:   {RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b0_00_00_100_0_000_0001_0_00_00_10_0_1_0_0_0 ;
    OP_BLE:   {RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b0_00_00_101_0_000_0001_0_00_00_10_0_1_0_0_0 ;
    OP_BGT:   {RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b0_00_00_110_0_000_0001_0_00_00_10_0_1_0_0_0 ;
    OP_LUI:   {RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b1_00_11_000_0_000_0110_0_00_00_10_0_1_0_0_0 ;
    OP_ANDI:  {RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b1_00_01_000_0_000_0011_0_00_00_10_0_0_0_0_0 ;
    OP_ORI:   {RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b1_00_01_000_0_000_0100_0_00_00_10_0_0_0_0_0 ;
    OP_XORI:  {RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b1_00_01_000_0_000_0101_0_00_00_10_0_0_0_0_0 ;
    OP_MUL:   {RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b1_01_00_000_0_000_0111_0_00_00_10_0_1_0_0_0 ;
    OP_SLTI:  {RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b1_00_01_000_0_000_1010_0_00_00_10_0_1_0_0_0 ;
    OP_SLTIU: {RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b1_00_01_000_0_000_1010_0_00_00_10_0_0_0_0_1 ;
    OP_LBU:   {RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b1_00_01_000_0_001_0000_0_00_00_00_0_1_0_0_1 ;
    OP_LHU:   {RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b1_00_01_000_0_001_0000_0_00_00_01_0_1_0_0_1 ;
    OP_ADDIU: {RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b1_00_01_000_0_000_1100_0_00_00_10_0_0_0_0_1 ;
    default:  {RegWrite_reg,RegDst_reg,ALUSrc_reg,Branch_reg,MemWrite_reg,MemtoReg_reg,ALUOp_reg,Jump_reg,hi_src_reg,lo_src_reg,mem_data_size_reg,JumpReg_reg,sign_reg,hi_w_reg,lo_w_reg,unsigned_instr_reg} = 28'b0_00_00_000_0_000_0000_0_00_00_00_0_0_0_0_0 ;
    endcase
end

// Assign internal registers to outputs
assign MemtoReg         = MemtoReg_reg;
assign MemWrite         = MemWrite_reg;
assign Branch           = Branch_reg;
assign ALUSrc           = ALUSrc_reg;
assign RegDst           = RegDst_reg;
assign RegWrite         = RegWrite_reg;
assign Jump             = Jump_reg;
assign ALUOp            = ALUOp_reg;
assign hi_src           = hi_src_reg;
assign lo_src           = lo_src_reg;
assign JumpReg          = JumpReg_reg;
assign mem_data_size    = mem_data_size_reg;
assign sign             = sign_reg;
assign hi_w             = hi_w_reg;
assign lo_w             = lo_w_reg;
assign unsigned_instr   = unsigned_instr_reg;

endmodule
