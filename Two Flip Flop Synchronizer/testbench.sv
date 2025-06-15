// Code your testbench here
// or browse Examples
module tb #(
		
  parameter WIDTH = 3
  	
) ;
  
  reg clk, rstn;
  reg [WIDTH:0] din;
  wire [WIDTH:0] q1, dout;
  
  top dut(
  
    .clk(clk),
    .rstn(rstn),
    .din(din),
    .dout(dout)
  
  );
  
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  initial begin
   
    $monitor("rstn = %b | din = %b | q1 = %b | dout = %b", rstn, din, dut.q1, dout );
    
    din = 4'b1010; rstn = 0;
    
    @(posedge clk) rstn = 1;
    @(posedge clk) din = 4'b1111;
    @(posedge clk);
    @(posedge clk) rstn = 0;
    @(posedge clk) $finish;
    
  end
  
endmodule