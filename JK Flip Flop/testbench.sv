module tb_jk;
  reg j;
  reg k;
  reg clk;

  jk_ff dut ( .j(j),
             .k(k),
             .clk(clk),
             .q(q));

  initial begin

    clk = 0;
    forever #5 clk = ~clk;

  end

  initial begin

    $monitor("J = %b | K = %b | Q = %b", j, k, q);
    
    $dumpfile("jk_ff.vcd");
    $dumpvars(0, tb_jk);

    j <= 0;
    k <= 0;
    #5 j <= 0;
    k <= 1;
    #20 j <= 1;
    k <= 0;
    #20 j <= 1;
    k <= 1;
    #20 $finish;
  end

endmodule