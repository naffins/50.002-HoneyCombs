/*
   This file was generated automatically by Alchitry Labs version 1.2.1.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module mux4_6 (
    input inp0,
    input inp1,
    input inp2,
    input inp3,
    input s0,
    input s1,
    output reg out
  );
  
  
  
  wire [(2'h2+0)-1:0] M_constituent_mux_out;
  reg [(2'h2+0)-1:0] M_constituent_mux_inp0;
  reg [(2'h2+0)-1:0] M_constituent_mux_inp1;
  reg [(2'h2+0)-1:0] M_constituent_mux_s0;
  
  genvar GEN_constituent_mux0;
  generate
  for (GEN_constituent_mux0=0;GEN_constituent_mux0<2'h2;GEN_constituent_mux0=GEN_constituent_mux0+1) begin: constituent_mux_gen_0
    mux2_8 constituent_mux (
      .inp0(M_constituent_mux_inp0[GEN_constituent_mux0*(1)+(1)-1-:(1)]),
      .inp1(M_constituent_mux_inp1[GEN_constituent_mux0*(1)+(1)-1-:(1)]),
      .s0(M_constituent_mux_s0[GEN_constituent_mux0*(1)+(1)-1-:(1)]),
      .out(M_constituent_mux_out[GEN_constituent_mux0*(1)+(1)-1-:(1)])
    );
  end
  endgenerate
  
  wire [1-1:0] M_final_mux_out;
  reg [1-1:0] M_final_mux_inp0;
  reg [1-1:0] M_final_mux_inp1;
  reg [1-1:0] M_final_mux_s0;
  mux2_8 final_mux (
    .inp0(M_final_mux_inp0),
    .inp1(M_final_mux_inp1),
    .s0(M_final_mux_s0),
    .out(M_final_mux_out)
  );
  
  always @* begin
    M_constituent_mux_inp0[0+0-:1] = inp0;
    M_constituent_mux_inp1[0+0-:1] = inp1;
    M_constituent_mux_inp0[1+0-:1] = inp2;
    M_constituent_mux_inp1[1+0-:1] = inp3;
    M_constituent_mux_s0[0+0-:1] = s0;
    M_constituent_mux_s0[1+0-:1] = s0;
    M_final_mux_inp0 = M_constituent_mux_out[0+0-:1];
    M_final_mux_inp1 = M_constituent_mux_out[1+0-:1];
    M_final_mux_s0 = s1;
    out = M_final_mux_out;
  end
endmodule
