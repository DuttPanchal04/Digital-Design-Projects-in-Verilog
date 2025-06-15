// Code your testbench here
// or browse Examples
`timescale 1ns/1ps

module inv_tb;
  
reg a; wire y;
  
  inv dut(
  
    .a(a),
    .y(y)
  
  );
  
  initial begin
  
  a = 0; 
  $display("%b", y);
 
  #5 a = 1;
  $display("%b", y);
    
  #5 a = 0;
  $display("%b", y);
    
  end
  
  
  
endmodule