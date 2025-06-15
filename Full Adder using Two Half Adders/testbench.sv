// Code your testbench here
// or browse Examples
module fa_tb;
  
  reg a, b, cin;
  wire s, cout;
  
  fa dut(
  
    .a(a),
    .b(b),
    .cin(cin),
    .s(s),
    .cout(cout)
    
  );
  
  initial begin
    
    $monitor("Time = %t | a = %b | b = %b | cin = %b | Sum = %b | Cout = %b |", $realtime, a, b, cin, s, cout);
    
    a = 0; b = 0; cin = 0;
    
    a = 0; b = 0; cin = 0; #10;
    a = 0; b = 0; cin = 1; #10;
    a = 0; b = 1; cin = 0; #10;
    a = 0; b = 1; cin = 1; #10;
    a = 1; b = 0; cin = 0; #10;
    a = 1; b = 0; cin = 1; #10;
    a = 1; b = 1; cin = 0; #10;
    a = 1; b = 1; cin = 1; #10;
    
  end
  
  
endmodule