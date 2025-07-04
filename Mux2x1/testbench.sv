// Code your testbench here
// or browse Examples
`timescale 1ns/100ps

module mux_2_1_tb;

  //inputs
  reg a, b, select;
  //outputs
  wire y;

  mux_2_1 u0_DUT(
    .a(a),
    .b(b),
    .select(select),
    .y(y)
  );

  initial begin

    $monitor("sel = %b | a = %b | b = %b | y = %b", select, a, b, y);
    
    $dumpfile("test_2_1mux.vcd");
    $dumpvars(0,mux_2_1_tb);
    
    a=1'b0;b=1'b0; select=1'b0;
    #5 a=1'b1; 
    #5 select = 1'b1;
    #5 b=1'b1;
    #5 a=1'b0;
    #5 $finish;
    
  end
endmodule