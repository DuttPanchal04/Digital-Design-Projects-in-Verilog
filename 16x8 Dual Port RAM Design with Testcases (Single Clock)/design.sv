// Code your design here

// I'm designing 16x8 dual port ram where data width = 8, depth or number of memory location = 16, and address width =  4 ( as 2^4 = 16 )

module dual_port_ram #(

  parameter data_width = 8,
  parameter addr_width = 4,
  parameter depth = 16

) (

  input clk,
  input rst,

  // for port A
  input [ data_width - 1 : 0] din_a,
  output reg [ data_width - 1 : 0] dout_a,
  input [ addr_width - 1 : 0 ] addr_a,
  input we_a,
  input re_a,

  // for port B
  input [ data_width - 1 : 0] din_b,
  output reg [ data_width - 1 : 0] dout_b,
  input [ addr_width - 1 : 0 ] addr_b,
  input we_b,
  input re_b

);

  // then we have to declare internal memory arrary
  reg [ data_width - 1 : 0 ] mem [ 0 : depth - 1 ];

  // write/read and reset logic
  always @(posedge clk or negedge rst) begin

    integer i;

    if(rst) begin

      
      // For port-A write
      if(we_a) 
        mem[addr_a] <= din_a;
        
      
      
      // For writing input data to only first and last location of ram
      /*if(we_a) begin
        mem[0] <= din_a;
        mem[depth-1] <= din_a;
      end
	*/
      
      
      // For port-A read
      if(re_a)
        dout_a <= mem[addr_a]; // for reading port-A data from Port-A
      
      // dout_a <= mem[addr_b]; // for reading port-B data from port-A

      
      // For port-B write
      if(we_b) 
        mem[addr_b] <= din_b;

      
      // For port-B read
      if(re_b)
        dout_b <= mem[addr_b]; // for reading port-B data from port-B
      
      // dout_b <= mem[addr_a]; // for reading port-A input data from port-B

    end

    else begin

      dout_a <= 1'b0;
      dout_b <= 1'b0;

      for (i=0; i < 16; i = i + 1) begin
        mem[i] <= 0;
      end

    end

  end


endmodule