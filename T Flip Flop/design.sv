// Code your design here
module t_ff(

  input t,
  input clk,
  output reg q

);  

  always @(posedge clk) begin

    if (t)
      q <= ~q;
    else
      q <= 1'b0;

  end


endmodule