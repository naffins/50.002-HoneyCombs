// Based on Alchitry's 2-port RAM. Read/write tested
// Modified to:
// - Include input-specific addresses (0,29) with input write/read interface

module data_memory #(
    parameter SIZE = 16,                // Size of entry at each address
    parameter DEPTH = 64,                // Number of entries/address
    parameter JOYSTICK_ADDR = 0,
    parameter BUTTON_ADDR = 29
  )(
    input clk,                        // clock
  
    // regular write interface
    input [$clog2(DEPTH)-1:0] waddr,   // write address (of size log(DEPTH))
    input [SIZE-1:0] write_data,       // write data (of size SIZE)
    input write_en,                    // write enable (1 = write)
    
    // regular read interface
    input [$clog2(DEPTH)-1:0] raddr,   // read address (of size log(DEPTH))
    output [SIZE-1:0] read_data,    // read data (of size SIZE)
    
    // joystick input write interface
    input [SIZE-1:0] input0_write_data,
    input input0_write_en,
    
    // button input write interface
    input [SIZE-1:0] input1_write_data,
    input input1_write_en,
    
    // input read interface
    output [SIZE-1:0] input0_read_data,
    output [SIZE-1:0] input1_read_data
  );
  
  reg [SIZE-1:0] mem [DEPTH-1:0];      // memory array to store values
  
  // write clock domain
  always @(posedge clk) begin
    
    // Perform regular write (highest precedence)
    if (write_en) 
      mem[waddr] <= write_data;
      
    // Perform joystick input write only if joystick write is enabled and regular write isn't writing to joystick address
    if (input0_write_en & (~(write_en & (waddr==JOYSTICK_ADDR)))) 
      mem[JOYSTICK_ADDR] <= input0_write_data;
      
    // Perform button input write only if button write is enabled and regular write isn't writing to button address
    if (input1_write_en & (~(write_en & (waddr==BUTTON_ADDR)))) 
      mem[BUTTON_ADDR] <= input1_write_data;
      
  end
  
  assign read_data = mem[raddr];       // read memory directly from memory array (I suppose a mux is implemented in background)
  assign input0_read_data = mem[JOYSTICK_ADDR];     // read joystick input directly from memory array
  assign input1_read_data = mem[BUTTON_ADDR];      // read button input directly from memory array
  
endmodule