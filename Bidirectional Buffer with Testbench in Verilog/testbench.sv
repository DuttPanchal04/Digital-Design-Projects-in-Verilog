module bi_buf_tb;

  reg en;
  
  // As we cannot assign values to Inout ports directly, we have to make seperate variables to drive values A and B.

  reg a_drv, b_drv; 
  wire a, b;
  
  assign a = en ? a_drv : 1'bz; // a drive when en = 1, output to b.
  assign b = en ? 1'bz : b_drv; // b drive when en = 0, output to a.
  
  bi_buf dut (
    .a(a),
    .b(b),
    .en(en)
  );

  initial begin
    
    $dumpfile("bi_buf_tb.vcd");
    $dumpvars(0, bi_buf_tb);

    $monitor("Time = %t | en = %b | a = %b | b = %b", $time, en, a, b);

    
    en = 1; a_drv = 1'b1; b_drv = 1'bz; #5;
    a_drv = 1'b0; #5; // reset value to 0 ( not necessory )

    en = 0; a_drv = 1'bz; b_drv = 1'b1; #5;
    b_drv = 1'b0; #5; // reset value to 0 ( not necessory )
    
    en = 1; a_drv = 1'b1; b_drv = 1'bz; #5;
    a_drv = 1'b0; #5;
    
    en = 0; a_drv = 1'bz; b_drv = 1'b0; #5;
    b_drv = 1'b0; #5;
    
    en = 1; a_drv = 1'bz; b_drv = 1'bz; #5;
   // a_drv = 1'b0; #5;
    
    en = 0; a_drv = 1'bz; b_drv = 1'bz; #5;
   // b_drv = 1'b0; #5;
        
    en = 1; a_drv = 1'bx; b_drv = 1'bz; #5;
   // a_drv = 1'b0; #5;
    
    en = 0; a_drv = 1'bz; b_drv = 1'bx; #5;
   // b_drv = 1'b0; #5;

    $finish;
    
  end

endmodule