/*
   This file was generated automatically by Alchitry Labs version 1.2.1.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

/*
   Parameters:
     PIPELINE_CYCLE_COUNT = PIPELINE_CYCLE_COUNT
     CONDITIONING_CYCLE_COUNT = CONDITIONING_CYCLE_COUNT
     DEBOUNCING_CYCLE_COUNT = CONDITIONING_CYCLE_COUNT-PIPELINE_CYCLE_COUNT
     WIDTH = INPUT_WIDTH
*/
module input_conditioner_28 (
    input clk,
    input [3:0] in,
    output reg [3:0] out,
    output reg [3:0] debug1,
    output reg [3:0] debug2,
    output reg [3:0] debug3
  );
  
  localparam PIPELINE_CYCLE_COUNT = 3'h5;
  localparam CONDITIONING_CYCLE_COUNT = 7'h64;
  localparam DEBOUNCING_CYCLE_COUNT = 8'h5f;
  localparam WIDTH = 3'h4;
  
  
  wire [(3'h4+0)-1:0] M_pipeline_out;
  reg [(3'h4+0)-1:0] M_pipeline_in;
  
  genvar GEN_pipeline0;
  generate
  for (GEN_pipeline0=0;GEN_pipeline0<3'h4;GEN_pipeline0=GEN_pipeline0+1) begin: pipeline_gen_0
    input_pipeline_31 pipeline (
      .clk(clk),
      .in(M_pipeline_in[GEN_pipeline0*(1)+(1)-1-:(1)]),
      .out(M_pipeline_out[GEN_pipeline0*(1)+(1)-1-:(1)])
    );
  end
  endgenerate
  
  reg [6:0] M_counter_d, M_counter_q = 1'h0;
  
  reg [3:0] M_input_tracker_d, M_input_tracker_q = 1'h0;
  
  wire [(3'h7+0)-1:0] M_counter_select_out;
  reg [(3'h7+0)-1:0] M_counter_select_inp0;
  reg [(3'h7+0)-1:0] M_counter_select_s0;
  
  genvar GEN_counter_select0;
  generate
  for (GEN_counter_select0=0;GEN_counter_select0<3'h7;GEN_counter_select0=GEN_counter_select0+1) begin: counter_select_gen_0
    mux2_13 counter_select (
      .inp1(1'h0),
      .inp0(M_counter_select_inp0[GEN_counter_select0*(1)+(1)-1-:(1)]),
      .s0(M_counter_select_s0[GEN_counter_select0*(1)+(1)-1-:(1)]),
      .out(M_counter_select_out[GEN_counter_select0*(1)+(1)-1-:(1)])
    );
  end
  endgenerate
  
  wire [(3'h7+0)-1:0] M_counter_incrementer_s;
  wire [(3'h7+0)-1:0] M_counter_incrementer_cout;
  reg [(3'h7+0)-1:0] M_counter_incrementer_a;
  reg [(3'h7+0)-1:0] M_counter_incrementer_b;
  
  genvar GEN_counter_incrementer0;
  generate
  for (GEN_counter_incrementer0=0;GEN_counter_incrementer0<3'h7;GEN_counter_incrementer0=GEN_counter_incrementer0+1) begin: counter_incrementer_gen_0
    half_adder_29 counter_incrementer (
      .a(M_counter_incrementer_a[GEN_counter_incrementer0*(1)+(1)-1-:(1)]),
      .b(M_counter_incrementer_b[GEN_counter_incrementer0*(1)+(1)-1-:(1)]),
      .s(M_counter_incrementer_s[GEN_counter_incrementer0*(1)+(1)-1-:(1)]),
      .cout(M_counter_incrementer_cout[GEN_counter_incrementer0*(1)+(1)-1-:(1)])
    );
  end
  endgenerate
  
  wire [(3'h4+0)-1:0] M_out_select_out;
  reg [(3'h4+0)-1:0] M_out_select_inp0;
  reg [(3'h4+0)-1:0] M_out_select_inp1;
  reg [(3'h4+0)-1:0] M_out_select_s0;
  
  genvar GEN_out_select0;
  generate
  for (GEN_out_select0=0;GEN_out_select0<3'h4;GEN_out_select0=GEN_out_select0+1) begin: out_select_gen_0
    mux2_13 out_select (
      .inp0(M_out_select_inp0[GEN_out_select0*(1)+(1)-1-:(1)]),
      .inp1(M_out_select_inp1[GEN_out_select0*(1)+(1)-1-:(1)]),
      .s0(M_out_select_s0[GEN_out_select0*(1)+(1)-1-:(1)]),
      .out(M_out_select_out[GEN_out_select0*(1)+(1)-1-:(1)])
    );
  end
  endgenerate
  
  integer i;
  
  always @* begin
    M_input_tracker_d = M_input_tracker_q;
    M_counter_d = M_counter_q;
    
    M_pipeline_in = in;
    M_counter_incrementer_a = M_counter_q;
    M_counter_incrementer_b[0+0-:1] = (|(M_counter_q ^ 8'h5f));
    for (i = 1'h1; i < 3'h7; i = i + 1) begin
      M_counter_incrementer_b[(i)*1+0-:1] = M_counter_incrementer_cout[(i - 1'h1)*1+0-:1];
    end
    M_counter_select_inp0 = M_counter_incrementer_s;
    M_input_tracker_d = M_pipeline_out;
    M_counter_select_s0 = {3'h7{((~|M_pipeline_out)) | ((|(M_pipeline_out ^ M_input_tracker_q)))}};
    M_counter_d = M_counter_select_out;
    M_out_select_s0 = {3'h7{~((|(M_counter_q ^ 8'h5f)))}};
    M_out_select_inp0 = 4'h0;
    M_out_select_inp1 = M_input_tracker_q;
    out = M_out_select_out;
    debug1 = M_pipeline_out;
    debug2 = in;
    debug3 = {3'h7{~((|(M_counter_q ^ 8'h5f)))}};
  end
  
  always @(posedge clk) begin
    M_input_tracker_q <= M_input_tracker_d;
  end
  
  
  always @(posedge clk) begin
    M_counter_q <= M_counter_d;
  end
  
endmodule
