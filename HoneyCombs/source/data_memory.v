// Based on Alchitry's 2-port RAM, but this one lets us read immediately

module data_memory #(
    parameter SIZE = 16,                // Size of entry at each address
    parameter DEPTH = 64                // Number of entries/address
  )(
    // write interface
    input clk,                        // clock
    input [$clog2(DEPTH)-1:0] waddr,   // write address (of size log(DEPTH))
    input [SIZE-1:0] write_data,       // write data (of size SIZE)
    input write_en,                    // write enable (1 = write)
    
    // read interface
    input [$clog2(DEPTH)-1:0] raddr,   // read address (of size log(DEPTH))
    output [SIZE-1:0] read_data    // read data (of size SIZE)
  );
  
  reg [SIZE-1:0] mem [DEPTH-1:0];      // memory array to store values
  
  // write clock domain
  always @(posedge wclk) begin
    if (write_en)                      // if write enable
      mem[waddr] <= write_data;        // write memory
  end
  
  assign read_data = mem[raddr];       // read memory directly from memory array (I suppose a mux is implemented in background)
  
endmodule