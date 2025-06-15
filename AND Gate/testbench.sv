// Code your testbench here
// or browse Examples
`timescale 1ns/1ps

module and_tb;
  
reg a;
reg b;
wire y;
  
  and_gate dut(
  
    .a(a),
    .b(b),
    .y(y)
    
  );
  
  initial begin
  
  a = 0; b = 0;
    $display("%b", y); 
  #5 a = 1; b = 0;
     $display("%b", y); 
  #5 a = 0; b = 1;
     $display("%b", y); 
  #5 a = 1; b = 1;
     $display("%b", y); 
  #5 $finish;
    
  end
  
  
endmodule