// Code your design here

// I'm designing 16x8 dual port ram where data width = 8, depth or number of memory location = 16, and address width =  4 ( as 2^4 = 16 )
module dual_port_ram #(
  parameter data_width = 8,
  parameter addr_width = 4,
  parameter depth = 16
)(
  input clk0, clk1,
  input rst,

  input [data_width-1:0] din_a,
  input [addr_width-1:0] addr_a,
  input we_a, re_a,
  output reg [data_width-1:0] dout_a,

  input [data_width-1:0] din_b,
  input [addr_width-1:0] addr_b,
  input we_b, re_b,
  output reg [data_width-1:0] dout_b
);

  reg [data_width-1:0] mem[0:depth-1];
  integer i;

  // Reset logic
  always @(posedge rst) begin
    for (i = 0; i < depth; i = i + 1)
      mem[i] <= 0;

    dout_a <= 0;
    dout_b <= 0;
  end

  // Port A
  always @(posedge clk0) begin
    if (!rst) begin
      if (we_a)
        mem[addr_a] <= din_a;
      if (re_a)
        dout_a <= mem[addr_a];
    end
  end

  // Port B
  always @(posedge clk1) begin
    if (!rst) begin
      if (we_b)
        mem[addr_b] <= din_b;
      if (re_b)
        dout_b <= mem[addr_a]; // read input data of port-A from Port-B 
    end
  end

endmodule
