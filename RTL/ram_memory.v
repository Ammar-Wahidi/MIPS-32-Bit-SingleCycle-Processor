`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ammar Wahidi
// 
// Create Date: 06/23/2025 05:35:10 PM
// Design Name: Ram Memory
// Module Name: ram_memory
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


module ram_memory #(parameter addr_width = 32, parameter data_width = 8)(clk,reset_n ,we,addr,mem_data_size,unsigned_instr,write_data,read_data);
input                                  clk                             ;
input                                  reset_n                         ;
input                                  we                              ;
input      [addr_width-1:0]            addr                            ;
input      [1:0]                       mem_data_size                   ;
input                                  unsigned_instr                  ;
input      [4*data_width-1:0]          write_data                      ;
output reg [4*data_width-1:0]          read_data                       ;

// Byte-addressable memory array (8-bit per entry)
reg     [data_width-1:0]            memory [0:(2**addr_width)- 1]   ;

// Synchronous write: Little-endian (addr = LSB)
always @(posedge clk)
begin
        if (we) begin
            if (mem_data_size==2'b10)
            begin
                memory[addr]     <= write_data[7:0];      // Byte 0 (LSB)
                memory[addr + 1] <= write_data[15:8];     // Byte 1
                memory[addr + 2] <= write_data[23:16];    // Byte 2
                memory[addr + 3] <= write_data[31:24];    // Byte 3 (MSB)
            end
            else if (mem_data_size==2'b01)
            begin
                memory[addr]     <= write_data[7:0];      // Byte 0 (LSB)
                memory[addr + 1] <= write_data[15:8];     // Byte 1
            end
            else if (mem_data_size==2'b00)
            begin
                memory[addr]     <= write_data[7:0];      // Byte 0 (LSB)
            end
        end
end

// Combinational read
always @(*)
begin
    if (mem_data_size==2'b10) // Word (LW)
        read_data = {memory[addr + 3],memory[addr + 2],memory[addr + 1],memory[addr]} ; 
    else if (mem_data_size==2'b01) // Halfword (LH/LHU)
    begin 
        if (unsigned_instr)  
            read_data = {16'b0, memory[addr + 1], memory[addr]}; // LHU (zero-extend)
        else
            read_data = {{16{memory[addr + 1][7]}}, memory[addr + 1], memory[addr]}; // LH (sign-extend from MSB of high byte)
    end
    else if (mem_data_size==2'b00) 
    begin
        if(unsigned_instr)
            read_data = {24'b0, memory[addr]}; // LBU (zero-extend)
        else
            read_data = {{24{memory[addr][7]}}, memory[addr]}; // LB (sign-extend)
    end
    else
        read_data = {memory[addr + 3],memory[addr + 2],memory[addr + 1],memory[addr]} ; 
end

//////////////////////////////////////////////////////////////////////////////////
// NOT SYNTHESIZABLE: Simulation-only initialization
always @(negedge reset_n) begin
    if (~reset_n)
    begin    
        for (integer i = 0; i < 2**addr_width; i = i + 1) begin
            memory[i] = 0;
        end
    end
end

initial 
begin
#20 $readmemh("Test4_v2.mem",memory);
end

//////////////////////////////////////////////////////////////////////////////////

endmodule
