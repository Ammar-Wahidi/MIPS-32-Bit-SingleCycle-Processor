`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ammar Wahidi
// 
// Create Date: 06/24/2025 12:27:02 AM
// Design Name: MIPS 32-bit Processor Wrapper
// Module Name: MIPS_32Bit_Wrapper
// Project Name: MIPS
// Target Devices: 
// Tool Versions: 
// Description: 
//   Top-level integration of a 32-bit single-cycle MIPS processor,
//   connecting PC, instruction fetch, decode, ALU, memory access,
//   and control logic.
// 
// Dependencies: 
//   - Program Counter
//   - Instruction Decoder
//   - Control Unit
//   - Register File
//   - ALU
//   - Data & Instruction Memory
//   - Sign Extension, Shift Modules, Multiplexers
// 
// Revision:
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////

(* DONT_TOUCH = "TRUE" *)
module MIPS_32Bit_Wrapper(clk,reset_n);

//Inputs
input clk;
input reset_n;

//Wires 

wire            [31:0]      PC_current          ;
wire            [31:0]      PC_next             ;
wire            [31:0]      instr               ;
// Instruction decoding
wire            [5:0]       OPcode              ;
wire            [5:0]       Funct               ;
wire            [4:0]       rs                  ;
wire            [4:0]       rt_r                ;
wire            [4:0]       rd_r                ;
wire            [4:0]       shamt               ;
wire            [4:0]       rt_i                ;
wire            [15:0]      imm                 ;
wire            [25:0]      addr_j              ;
// Control signals
wire            [2:0]       MemtoReg            ;
wire                        MemWrite            ;
wire            [2:0]       Branch              ;
wire            [1:0]       ALUSrc              ;
wire            [1:0]       RegDst              ;
wire                        RegWrite            ;
wire                        Jump                ;
wire            [4:0]       ALU_control         ;
wire            [1:0]       hi_src              ;
wire            [1:0]       lo_src              ;
wire                        JumpReg             ;
wire            [1:0]       mem_data_size       ;
wire                        sign                ;
wire                        hi_w                ;
wire                        lo_w                ;
wire                        unsigned_instr      ;

wire            [4:0]       mux_to_a3           ;
wire            [31:0]      mux_to_wd3          ;
wire            [31:0]      rd1_rf              ;
wire            [31:0]      rd2_rf              ;
wire            [31:0]      sign_imm            ;
wire            [31:0]      srcA                ;
wire            [31:0]      srcB                ;
wire                        zero                ;
wire                        N_flag              ;
wire                        V_flag              ;
wire                        C_flag              ;
wire            [31:0]      ALU_result          ;
wire            [31:0]      ALU_to_addr         ;
wire            [31:0]      read_data_DM        ;
wire            [31:0]      aluDM_result        ;

// PC control logic
wire            [31:0]      pc_plus4            ;
wire            [31:0]      imm_out_shifted     ;
wire            [31:0]      pc_Branch           ;
wire            [27:0]      addr_j_shifted      ;
wire            [31:0]      PCjump              ;
wire                        PCSrc               ;
wire            [31:0]      pc_mux1out          ;
wire            [31:0]      pc_mux2out          ;
wire            [31:0]      pc_mux3out          ;
wire            [31:0]      imm_shifted16       ;

// MUL and DIV 
wire            [63:0]      product             ;
wire            [31:0]      quotient            ;
wire            [31:0]      remainder           ;
wire            [31:0]      mux_2_hi            ;
wire            [31:0]      mux_2_lo            ;
wire            [31:0]      HI_wire             ;
wire            [31:0]      LO_wire             ;

// Combinational Assignments 
assign srcA         = rd1_rf;                         // ALU source A is register rs
assign ALU_to_addr  = ALU_result;                     // ALU result used as memory address
assign mux_to_wd3   = aluDM_result;                   // Data to be written back to register
assign PCjump       = {pc_plus4[31:28], addr_j_shifted}; // Jump target address
assign PC_next      = pc_mux3out;                     // Final next PC value

// Modules
Progame_Counter PC (
.clk(clk),
.reset_n(reset_n),
.PC_next(PC_next),
.PC(PC_current)
);

ram_memory #(.addr_width(7),.data_width(8)) Instruction_Memory (
.clk(clk),
.reset_n(reset_n),
.addr(PC_current),
.unsigned_instr(1'b0),
.mem_data_size(2'b10),
.read_data(instr)
);

Instruction_Decoder instr_decoder (
.instr(instr),
.OPcode(OPcode),
.Funct(Funct),
.rs(rs),
.rt_r(rt_r),
.rd_r(rd_r),
.shamt(shamt),
.rt_i(rt_i),
.imm(imm),
.addr_j(addr_j)
);

Control_Unit Controller (
.OPcode(OPcode),
.Funct(Funct),
.rt(rt_i),

.MemtoReg(MemtoReg),
.MemWrite(MemWrite),
.Branch(Branch),
.ALUSrc(ALUSrc),
.RegDst(RegDst),
.RegWrite(RegWrite),
.Jump(Jump),
.ALU_control(ALU_control),
.hi_src(hi_src),
.lo_src(lo_src),
.JumpReg(JumpReg),
.mem_data_size(mem_data_size),
.sign(sign),
.hi_w(hi_w),
.lo_w(lo_w),
.unsigned_instr(unsigned_instr)
);

Branch_Control branch_cController(
.branch(Branch),
.zero_flag(zero),
.N_flag(N_flag),
.V_flag(V_flag),
.C_flag(C_flag),
.PCSrc(PCSrc)
);

// Register Destination MUX (for write address)
mux_4x1 #(.Bits(5)) instr_a3rf_RegDst (
.a(rt_i),
.b(rd_r),
.c(5'b11111),
.sel(RegDst),
.mux_out(mux_to_a3)
);

Register_File register_file (
.clk(clk),
.we3(RegWrite),
.addr_r1(rs),
.addr_r2(rt_r),
.addr_w3(mux_to_a3),
.write_data3(mux_to_wd3),
.read_data1(rd1_rf),
.read_data2(rd2_rf)
);

Sign_Extension sign_extend_zero (
.imm(imm),
.sign(sign),
.sign_imm(sign_imm)
);

shift_left_by_16 SLL_by_16 (
.imm(imm),
.out_shifted(imm_shifted16)
);

// ALU Source B MUX
mux_4x1 #(.Bits(32)) rf_rd2alu_ALUSrc (
.a(rd2_rf),
.b(sign_imm),
.c(31'd0),
.d(imm_shifted16),
.sel(ALUSrc),
.mux_out(srcB)
);

Arithmetic_Logic_Unit ALU (
.Src_A(srcA),
.Src_B(srcB),
.shamt(shamt),
.ALU_control(ALU_control),
.zero(zero),
.N(N_flag),
.V(V_flag),
.C(C_flag),
.result(ALU_result)
);

Multiplication #(.Bits(32))  MUL (
.multiplier(rd1_rf),
.multiplicand(rd2_rf),
.unsigned_instr(unsigned_instr),
.product(product)
);

Division DIV (
.dividend(rd1_rf),
.divisor(rd2_rf),
.unsigned_instr(unsigned_instr),
.quotient(quotient),
.remainder(remainder)
);

// write to hi_reg
mux_4x1 #(.Bits(32)) to_hi (
.a(rd1_rf),
.b(product[63:32]),
.c(remainder),
.sel(hi_src),
.mux_out(mux_2_hi)
);

// write to lo_reg
mux_4x1 #(.Bits(32)) to_lo (
.a(rd1_rf),
.b(product[31:0]),
.c(quotient),
.sel(lo_src),
.mux_out(mux_2_lo)
);

HI HI_reg (
.clk(clk),
.reset_n(reset_n),
.hi_write(hi_w),
.in(mux_2_hi),
.out(HI_wire)
);

LO LO_reg (
.clk(clk),
.reset_n(reset_n),
.lo_write (lo_w),
.in(mux_2_lo),
.out(LO_wire)
);

ram_memory #(.addr_width(5),.data_width(8)) Data_Memory (
.clk(clk),
.reset_n(reset_n),
.we(MemWrite),
.addr(ALU_to_addr),
.mem_data_size(mem_data_size),
.unsigned_instr(unsigned_instr),
.write_data(rd2_rf),
.read_data(read_data_DM)
);

// Write-back MUX
mux_8x1 #(.Bits(32)) alu_ADA_MemtoReg (
.a(ALU_result),
.b(read_data_DM),
.c(HI_wire),
.d(LO_wire),
.e(pc_plus4),
.sel(MemtoReg),
.mux_out(aluDM_result)
);

shift_left_by_2 #(.Bits(32)) SL2 (
.in(sign_imm),
.out_shifted(imm_out_shifted)
);

Add_module #(.Bits(32)) addpc_4
(
.a(PC_current),
.b(32'd4),
.pc(pc_plus4)
);

Add_module #(.Bits(32)) addpc_imm
(
.a(imm_out_shifted),
.b(pc_plus4),
.pc(pc_Branch)
);

shift_left_by_2 #(.Bits(28)) SL2_J(
.in({2'b00,addr_j}),
.out_shifted(addr_j_shifted)
);

// MUX to select between PC+4 and PC+Branch (for branches)
mux_2x1 #(.Bits(32)) branch_mux
(
.a(pc_plus4),
.b(pc_Branch),
.sel(PCSrc),
.mux_out(pc_mux1out)
);

// MUX to select between Branch result and Jump target 
mux_2x1 #(.Bits(32)) jump_mux
(
.a(pc_mux1out),
.b(PCjump),
.sel(Jump),
.mux_out(pc_mux2out)
);

mux_2x1 #(.Bits(32)) Jump_Reg_mux (
.a(pc_mux2out),
.b(rd1_rf),
.sel(JumpReg),
.mux_out(pc_mux3out)
);

endmodule
