/*
   This file was generated automatically by Alchitry Labs version 1.2.1.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module pc_4 (
    input clk,
    input rst,
    input pcsel,
    input [8:0] c,
    output reg [15:0] ia
  );
  
  
  
  wire [(5'h10+0)-1:0] M_reset_mux_out;
  reg [(5'h10+0)-1:0] M_reset_mux_inp0;
  reg [(5'h10+0)-1:0] M_reset_mux_inp1;
  
  genvar GEN_reset_mux0;
  generate
  for (GEN_reset_mux0=0;GEN_reset_mux0<5'h10;GEN_reset_mux0=GEN_reset_mux0+1) begin: reset_mux_gen_0
    mux2_13 reset_mux (
      .s0(rst),
      .inp0(M_reset_mux_inp0[GEN_reset_mux0*(1)+(1)-1-:(1)]),
      .inp1(M_reset_mux_inp1[GEN_reset_mux0*(1)+(1)-1-:(1)]),
      .out(M_reset_mux_out[GEN_reset_mux0*(1)+(1)-1-:(1)])
    );
  end
  endgenerate
  
  wire [(5'h10+0)-1:0] M_pc_select_out;
  reg [(5'h10+0)-1:0] M_pc_select_inp0;
  reg [(5'h10+0)-1:0] M_pc_select_inp1;
  
  genvar GEN_pc_select0;
  generate
  for (GEN_pc_select0=0;GEN_pc_select0<5'h10;GEN_pc_select0=GEN_pc_select0+1) begin: pc_select_gen_0
    mux2_13 pc_select (
      .s0(pcsel),
      .inp0(M_pc_select_inp0[GEN_pc_select0*(1)+(1)-1-:(1)]),
      .inp1(M_pc_select_inp1[GEN_pc_select0*(1)+(1)-1-:(1)]),
      .out(M_pc_select_out[GEN_pc_select0*(1)+(1)-1-:(1)])
    );
  end
  endgenerate
  
  reg [15:0] M_pc_reg_d, M_pc_reg_q = 1'h0;
  
  wire [16-1:0] M_pc_plus_out;
  reg [16-1:0] M_pc_plus_in;
  pc_incrementer_16_14 pc_plus (
    .in(M_pc_plus_in),
    .out(M_pc_plus_out)
  );
  
  wire [16-1:0] M_pc_plus_c_s;
  wire [1-1:0] M_pc_plus_c_z;
  wire [1-1:0] M_pc_plus_c_v;
  wire [1-1:0] M_pc_plus_c_n;
  reg [16-1:0] M_pc_plus_c_a;
  reg [16-1:0] M_pc_plus_c_b;
  adder16_15 pc_plus_c (
    .a(M_pc_plus_c_a),
    .b(M_pc_plus_c_b),
    .s(M_pc_plus_c_s),
    .z(M_pc_plus_c_z),
    .v(M_pc_plus_c_v),
    .n(M_pc_plus_c_n)
  );
  
  reg [15:0] pc;
  
  always @* begin
    M_pc_reg_d = M_pc_reg_q;
    
    pc[0+15-:16] = M_pc_reg_q[0+15-:16];
    ia = pc[0+15-:16];
    M_pc_plus_in = pc[0+15-:16];
    M_pc_plus_c_a = M_pc_plus_out;
    M_pc_plus_c_b[9+6-:7] = {3'h7{c[8+0-:1]}};
    M_pc_plus_c_b[0+8-:9] = c;
    M_pc_select_inp0 = M_pc_plus_out;
    M_pc_select_inp1 = M_pc_plus_c_s;
    M_reset_mux_inp0 = M_pc_select_out;
    M_reset_mux_inp1 = 16'h0000;
    M_pc_reg_d = M_reset_mux_out;
  end
  
  always @(posedge clk) begin
    M_pc_reg_q <= M_pc_reg_d;
  end
  
endmodule
