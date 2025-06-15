module d_ff_tb;

  reg d;
  reg clk;
  reg reset;
  wire y;

  d_ff dut(

    .d(d),
    .clk(clk),
    .reset(reset),
    .q(q)

  );

  // clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // test sequence
  initial begin
    
    $monitor("reset = %b | d = %b | q = %b", reset, d, q);

    $dumpfile("test_d_ff.vcd");
    $dumpvars(0, d_ff_tb);

    reset = 1; d = 0;

    #12 reset = 0;
    #10 d = 1;
    #10 d = 0;
    #10 d = 1;

    #20 $finish;
  end

endmodule
