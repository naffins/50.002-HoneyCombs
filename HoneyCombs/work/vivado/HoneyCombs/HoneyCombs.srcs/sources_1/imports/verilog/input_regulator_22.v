/*
   This file was generated automatically by Alchitry Labs version 1.2.1.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

/*
   Parameters:
     INPUT_WIDTH = 1
     DATA_WIDTH = 16
     PIPELINE_CYCLE_COUNT = 5
     CONDITIONING_CYCLE_COUNT = 100
     INPUT_REFRESH_CYCLE_COUNT = 50000000
     INPUT_REFRESH_CYCLE_COUNT_OFFSET = INPUT_REFRESH_CYCLE_COUNT-1
*/
module input_regulator_22 (
    input clk,
    input [0:0] inp,
    output reg [0:0] map_inp,
    input [15:0] map_out,
    input [15:0] input_read,
    output reg input_write_enable,
    output reg [15:0] input_write_data
  );
  
  localparam INPUT_WIDTH = 1'h1;
  localparam DATA_WIDTH = 5'h10;
  localparam PIPELINE_CYCLE_COUNT = 3'h5;
  localparam CONDITIONING_CYCLE_COUNT = 7'h64;
  localparam INPUT_REFRESH_CYCLE_COUNT = 26'h2faf080;
  localparam INPUT_REFRESH_CYCLE_COUNT_OFFSET = 27'h2faf07f;
  
  
  wire [1-1:0] M_conditioner_out;
  wire [1-1:0] M_conditioner_debug1;
  wire [1-1:0] M_conditioner_debug2;
  wire [1-1:0] M_conditioner_debug3;
  input_conditioner_30 conditioner (
    .clk(clk),
    .in(inp),
    .out(M_conditioner_out),
    .debug1(M_conditioner_debug1),
    .debug2(M_conditioner_debug2),
    .debug3(M_conditioner_debug3)
  );
  
  reg [25:0] M_counter_d, M_counter_q = 1'h0;
  
  reg [15:0] M_input_tracker_d, M_input_tracker_q = 1'h0;
  
  wire [(5'h1a+0)-1:0] M_counter_incrementer_s;
  wire [(5'h1a+0)-1:0] M_counter_incrementer_cout;
  reg [(5'h1a+0)-1:0] M_counter_incrementer_a;
  reg [(5'h1a+0)-1:0] M_counter_incrementer_b;
  
  genvar GEN_counter_incrementer0;
  generate
  for (GEN_counter_incrementer0=0;GEN_counter_incrementer0<5'h1a;GEN_counter_incrementer0=GEN_counter_incrementer0+1) begin: counter_incrementer_gen_0
    half_adder_29 counter_incrementer (
      .a(M_counter_incrementer_a[GEN_counter_incrementer0*(1)+(1)-1-:(1)]),
      .b(M_counter_incrementer_b[GEN_counter_incrementer0*(1)+(1)-1-:(1)]),
      .s(M_counter_incrementer_s[GEN_counter_incrementer0*(1)+(1)-1-:(1)]),
      .cout(M_counter_incrementer_cout[GEN_counter_incrementer0*(1)+(1)-1-:(1)])
    );
  end
  endgenerate
  
  wire [(5'h1a+0)-1:0] M_counter_select_out;
  reg [(5'h1a+0)-1:0] M_counter_select_inp0;
  reg [(5'h1a+0)-1:0] M_counter_select_inp1;
  reg [(5'h1a+0)-1:0] M_counter_select_s0;
  
  genvar GEN_counter_select0;
  generate
  for (GEN_counter_select0=0;GEN_counter_select0<5'h1a;GEN_counter_select0=GEN_counter_select0+1) begin: counter_select_gen_0
    mux2_13 counter_select (
      .inp0(M_counter_select_inp0[GEN_counter_select0*(1)+(1)-1-:(1)]),
      .inp1(M_counter_select_inp1[GEN_counter_select0*(1)+(1)-1-:(1)]),
      .s0(M_counter_select_s0[GEN_counter_select0*(1)+(1)-1-:(1)]),
      .out(M_counter_select_out[GEN_counter_select0*(1)+(1)-1-:(1)])
    );
  end
  endgenerate
  
  wire [(5'h10+0)-1:0] M_input_write_data_select_out;
  reg [(5'h10+0)-1:0] M_input_write_data_select_inp0;
  reg [(5'h10+0)-1:0] M_input_write_data_select_inp1;
  reg [(5'h10+0)-1:0] M_input_write_data_select_s0;
  
  genvar GEN_input_write_data_select0;
  generate
  for (GEN_input_write_data_select0=0;GEN_input_write_data_select0<5'h10;GEN_input_write_data_select0=GEN_input_write_data_select0+1) begin: input_write_data_select_gen_0
    mux2_13 input_write_data_select (
      .inp0(M_input_write_data_select_inp0[GEN_input_write_data_select0*(1)+(1)-1-:(1)]),
      .inp1(M_input_write_data_select_inp1[GEN_input_write_data_select0*(1)+(1)-1-:(1)]),
      .s0(M_input_write_data_select_s0[GEN_input_write_data_select0*(1)+(1)-1-:(1)]),
      .out(M_input_write_data_select_out[GEN_input_write_data_select0*(1)+(1)-1-:(1)])
    );
  end
  endgenerate
  
  integer i;
  
  always @* begin
    M_input_tracker_d = M_input_tracker_q;
    M_counter_d = M_counter_q;
    
    map_inp = M_conditioner_out;
    M_counter_incrementer_a = M_counter_q;
    M_counter_incrementer_b[0+0-:1] = 1'h1;
    for (i = 1'h1; i < 5'h1a; i = i + 1) begin
      M_counter_incrementer_b[(i)*1+0-:1] = M_counter_incrementer_cout[(i - 1'h1)*1+0-:1];
    end
    M_input_tracker_d = map_out;
    M_counter_select_s0 = {5'h1a{((|map_out)) & ((~|(map_out ^ M_input_tracker_q))) & ((((~|M_counter_q)) & ((~|input_read))) | (((|M_counter_q)) & ((|(M_counter_q ^ 27'h2faf07f)))))}};
    M_counter_select_inp0 = 26'h0000000;
    M_counter_select_inp1 = M_counter_incrementer_s;
    M_counter_d = M_counter_select_out;
    input_write_enable = ((~|(map_out))) | ((|(map_out ^ M_input_tracker_q))) | ((~|(M_counter_q ^ 27'h2faf07f)));
    M_input_write_data_select_s0 = {5'h10{((~|(M_counter_q ^ 27'h2faf07f))) | ((|(map_out ^ M_input_tracker_q)))}};
    M_input_write_data_select_inp0 = 16'h0000;
    M_input_write_data_select_inp1 = map_out;
    input_write_data = M_input_write_data_select_out;
  end
  
  always @(posedge clk) begin
    M_counter_q <= M_counter_d;
  end
  
  
  always @(posedge clk) begin
    M_input_tracker_q <= M_input_tracker_d;
  end
  
endmodule
