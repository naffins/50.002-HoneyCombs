// Base regfile module
// Based on Alchitry's 2-port RAM. Read/write tested

module regfile_base_16 #(
    parameter SIZE = 16,                // Size of entry at each address
    parameter DEPTH = 8                // Number of entries/address
  )(
    input clk,                        // clock
  
    // regular write interface
    input [$clog2(DEPTH)-1:0] waddr,   // write address (of size log(DEPTH))
    input [SIZE-1:0] write_data,       // write data (of size SIZE)
    input write_en,                    // write enable (1 = write)
    
    // regular read interface 0
    input [$clog2(DEPTH)-1:0] raddr0,   // read address (of size log(DEPTH))
    output [SIZE-1:0] read_data0,    // read data (of size SIZE)
    
    // regular read interface 1
    input [$clog2(DEPTH)-1:0] raddr1,   // read address (of size log(DEPTH))
    output [SIZE-1:0] read_data1    // read data (of size SIZE)
  );
  
  reg [SIZE-1:0] mem [DEPTH-1:0];      // memory array to store values
  
  // write clock domain
  always @(posedge clk) begin
    
    // Perform regular write (highest precedence)
    if (write_en) 
      mem[waddr] <= write_data;
      
  end
  
  assign read_data0 = mem[raddr0];       // read memory directly from memory array (I suppose a mux is implemented in background)
  assign read_data1 = mem[raddr1];
  
endmodule