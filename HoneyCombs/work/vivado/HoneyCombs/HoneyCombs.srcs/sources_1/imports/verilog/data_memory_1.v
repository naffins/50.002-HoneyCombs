// Based on Alchitry's 2-port RAM, but this one lets us read immediately

module data_memory_1 #(
    parameter SIZE = 16,                // size of each entry
    parameter DEPTH = 64                // number of entries
  )(
    // write interface
    input wclk,                        // write clock
    input [$clog2(DEPTH)-1:0] waddr,   // write address
    input [SIZE-1:0] write_data,       // write data
    input write_en,                    // write enable (1 = write)
    
    // read interface
    input [$clog2(DEPTH)-1:0] raddr,   // read address
    output [SIZE-1:0] read_data    // read data
  );
  
  reg [SIZE-1:0] mem [DEPTH-1:0];      // memory array
  
  // write clock domain
  always @(posedge wclk) begin
    if (write_en)                      // if write enable
      mem[waddr] <= write_data;        // write memory
  end
  
  assign read_data = mem[raddr];           // read memory
  
endmodule