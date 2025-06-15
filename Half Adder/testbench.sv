
`timescale 1ns/1ps

module ha_tb;
  
reg a;
reg b;
wire s;
  wire c;
  
 	ha dut(
  
    .a(a),
    .b(b),
      .s(s),
      .c(c)
    
  );
  
  initial begin
  
  a = 0; b = 0;
    $display("%b %b", s, c); 
  #5 a = 1; b = 0;
 $display("%b %b", s, c);
    #5 a = 0; b = 1;
 $display("%b %b", s, c);
    #5 a = 1; b = 1;
 $display("%b %b", s, c);
    #5 $finish;
    
  end
  
  
endmodule