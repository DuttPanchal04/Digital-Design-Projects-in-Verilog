// Code your design here
module top #( 

  parameter WIDTH = 3

) (

  input [WIDTH:0] din,
  output reg [WIDTH:0] dout,
  input clk,
  input rstn

);

  reg [WIDTH:0] q1;

  always @(posedge clk) begin

    if(!rstn) begin

      q1 <= 0;
      dout <= 0;

    end
    else begin

      q1 <= din;
      dout <= q1;

    end

  end

endmodule