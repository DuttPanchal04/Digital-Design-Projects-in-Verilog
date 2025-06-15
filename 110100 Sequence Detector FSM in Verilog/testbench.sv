// Code your testbench here
// or browse Examples
module tb;
  reg clk, rst, in;
  wire out;

  seq_det dut (
    .clk(clk),
    .rst(rst),
    .in(in),
    .out(out)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    
    $dumpfile("test_fsm.vcd");
    $dumpvars(0, tb);
    
    rst = 1; in = 0;
    #12 rst = 0;

    @(posedge clk) in = 1;
    @(posedge clk) in = 1;
    @(posedge clk) in = 0;
    @(posedge clk) in = 1;
    @(posedge clk) in = 0;
    @(posedge clk) in = 0;
    @(posedge clk) in = 0;
    @(posedge clk) in = 0;
    @(posedge clk) in = 1;
    @(posedge clk) in = 1;
    @(posedge clk) in = 0;
    @(posedge clk) in = 1;
    @(posedge clk) in = 0;
    
    //@(posedge clk) rst = 0; // checking reset
    
    @(posedge clk) in = 0;
    @(posedge clk) in = 0;

    @(posedge clk) $finish;
    
  end

  initial begin
    
    $monitor("Time = %0t | in = %b | out = %b | Current State = %0d | Next State = %0d", $time, in, out, dut.current_state, dut.next_state);
    
  end
 
  
endmodule
