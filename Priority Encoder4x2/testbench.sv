// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examples
module priority_encoder42_tb;
  
  reg i0, i1, i2, i3;
  wire y0, y1;
  
  priority_encoder42 dut(
  
    .i0(i0),
    .i1(i1),
    .i2(i2),
    .i3(i3),
    .y0(y0),
    .y1(y1)
    
  );
  
  initial begin
    
    $monitor("Time = %t | i0 = %b | i1 = %b | i2 = %b | i3 = %b | y1 = %b | y0 = %b", $realtime, i0, i1, i2, i3, y1, y0);
    
    i0 = 0; i1 = 0; i2 = 0; i3 = 0;
    
    #5  i0 = 0; i1 = 0; i2 = 0; i3 = 0;  
    #5  i0 = 0; i1 = 0; i2 = 0; i3 = 1;  
    #5  i0 = 0; i1 = 0; i2 = 1; i3 = 0;  
    #5  i0 = 0; i1 = 0; i2 = 1; i3 = 1;  
    #5  i0 = 0; i1 = 1; i2 = 0; i3 = 0; 
    #5  i0 = 0; i1 = 1; i2 = 0; i3 = 1;  
    #5  i0 = 0; i1 = 1; i2 = 1; i3 = 0;  
    #5  i0 = 0; i1 = 1; i2 = 1; i3 = 1;  
    #5  i0 = 1; i1 = 0; i2 = 0; i3 = 0; 
    #5  i0 = 1; i1 = 0; i2 = 0; i3 = 1; 
    #5  i0 = 1; i1 = 0; i2 = 1; i3 = 0;
    #5  i0 = 1; i1 = 0; i2 = 1; i3 = 1;  
    #5  i0 = 1; i1 = 1; i2 = 0; i3 = 0;
    #5  i0 = 1; i1 = 1; i2 = 0; i3 = 1; 
    #5  i0 = 1; i1 = 1; i2 = 1; i3 = 0; 
    #5  i0 = 1; i1 = 1; i2 = 1; i3 = 1; 

    #5 $finish;
    
  end
  
endmodule