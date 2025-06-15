// Code your design here
// File: adder.v
module adder (
    input  [1:0] a,
    input  [1:0] b,
    output [2:0] sum
);
    assign sum = a + b; // pass
  
  	// assign sum = a- b; // fail
  
endmodule
