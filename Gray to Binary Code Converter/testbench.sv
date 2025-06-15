// Code your testbench here
// or browse Examples
module tb;
  
  reg [3:0] in;
  wire [3:0] out;
  
  g2b dut(
  
    .in(in),
    .out(out)
    
  );
  
  initial begin
    
    $monitor("in = %b | out = %b", in,out);
    
    in = 4'b0000;
    #5 in = 4'b1010;
    #5 in = 4'b1111;
    #5 in = 1011;
    #5 in = 4'b1101;
    #5 $finish;
    
  end
  
endmodule