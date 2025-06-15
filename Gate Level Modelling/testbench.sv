// Code your testbench here
// or browse Examples
module tb;
  
reg A, B;
wire Y;
  
  and_gate dut(
  
    .Y(Y),
    .A(A),
    .B(B)
    
  );
  
  initial begin
    
    A = 0; B = 0;
    $display("%b", Y);
    #5; A = 1; B = 0;
    $display("%b", Y);
    #5; A = 0; B = 1;
    $display("%b", Y);
    #5; A = 1; B = 1;
    $display("%b", Y);
    #5; $finish;
    
  end
  
endmodule