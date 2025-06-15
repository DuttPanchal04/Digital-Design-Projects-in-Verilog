// Code your testbench here
// or browse Examples
module tb_sr;
  reg s;
  reg r;
  reg clk;
  wire q; 

  sr_ff dut ( .s(s),
             .r(r),
             .clk(clk),
             .q(q));

  initial begin

    clk = 0;
    forever #5 clk = ~clk;

  end

  initial begin

    $monitor("S = %b | R = %b | Q = %b", s, r, q);
    
    $dumpfile("sr_ff.vcd");
    $dumpvars(0, tb_sr);

    s = 0;
    r = 0;
    #5 s = 0;
    r = 1;
    #20 s = 1;
    r = 0;
    #20 s = 1;
    r = 1;
    #20 $finish;
  end

  initial
    $monitor ("s=%0d r=%0d q=%0d", s, r, q);
endmodule