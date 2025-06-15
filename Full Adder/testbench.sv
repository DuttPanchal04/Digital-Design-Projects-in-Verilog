// Code your testbench here
// or browse Examples

`timescale 1ns/1ps

module fa_tb;
  
reg a;
reg b;
  reg cin;
wire s;
  wire cout;
  
 	fa dut(
  
    .a(a),
    .b(b),
      .cin(cin),
      .s(s),
      .cout(cout)
    
  );
  
  initial begin
  
  a = 0; b = 0; cin = 0;
    $display("%b %b", s, cout); 
    #5 a = 0; b = 0; cin = 1;
    $display("%b %b", s, cout);
    #5 a = 0; b = 1; cin = 0;
    $display("%b %b", s, cout);
    #5 a = 1; b = 1; cin = 1;
    $display("%b %b", s, cout);
    #5 $finish;
    
  end
  
  
endmodule