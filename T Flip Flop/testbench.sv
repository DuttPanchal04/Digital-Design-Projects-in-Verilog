// Code your testbench here
// or browse Examples
module tb_t;
  reg t;
  reg clk;
  wire q; 

  t_ff dut ( .t(t),
            .clk(clk),
            .q(q));

  initial begin

    clk = 0;
    forever #5 clk = ~clk;

  end

  initial begin

    $monitor("t = %b | q = %b", t, q);
    
    $dumpfile("t_ff.vcd");
    $dumpvars(0, tb_t);

    t = 0;
    #5 t <= 1;
    #20 t <= 0;
    #20 t <= 1;
    #20 $finish;
  end

  initial
    $monitor ("t=%0d q=%0d",t,  q);
endmodule