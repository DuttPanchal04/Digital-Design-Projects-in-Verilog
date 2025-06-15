// Code your design here
module g2b(

  input [3:0] in,
  output [3:0] out

);
  
  assign {out} = { in[3], in[3]^in[2], in[3]^in[2]^in[1], in[3]^in[2]^in[1]^in[0] };
  
endmodule