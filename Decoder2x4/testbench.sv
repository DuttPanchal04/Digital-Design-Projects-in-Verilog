// Code your testbench here
// or browse Examples
module dec24_tb;
  
  reg a, b;
  wire [3:0] y;
  
  dec24 dut(
  
    .a(a),
    .b(b),
    .y(y)
  
  );
  
  initial begin
    
    $monitor("Time = %t | a = %b | b = %b | y = %b", $realtime, a, b, y);
    
    a = 0; b = 0;
    
    #5 a = 0; b = 0;
    #5 a = 0; b = 1;
    #5 a = 1; b = 0;
    #5 a = 1; b = 1;
    
  end
  
endmodule