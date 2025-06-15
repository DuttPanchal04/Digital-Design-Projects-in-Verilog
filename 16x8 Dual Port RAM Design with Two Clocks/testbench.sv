`timescale 1ns/1ps
module tb;

  reg clk0 = 0, clk1 = 0;
  reg [7:0] din_a, din_b;
  reg [3:0] addr_a, addr_b;
  reg we_a, we_b;
  reg re_a, re_b;
  wire [7:0] dout_a, dout_b;
  reg rst;

  dual_port_ram dut(
    .clk0(clk0), 
    .clk1(clk1),
    .rst(rst),
    .din_a(din_a), .din_b(din_b),
    .dout_a(dout_a), .dout_b(dout_b),
    .addr_a(addr_a), .addr_b(addr_b),
    .we_a(we_a), .we_b(we_b),
    .re_a(re_a), .re_b(re_b)
  );

  always #5 clk0 = ~clk0;  // 100 MHz
  always #10 clk1 = ~clk1; // 50 MHz

  initial begin

    $dumpfile("test_ram.vcd");
    $dumpvars(0, tb);
    
    
    $monitor("Time = %t | Din_a = %b | Din_b = %b | addr_a = %b | addr_b = %b | we_a = %b | we_b = %b | @addr_a = %b | @addr_b = %b | re_a = %b | re_b = %b | rst = %b | dout_a = %b | dout_b = %b", $realtime, din_a, din_b, addr_a, addr_b, we_a, we_b, dut.mem[addr_a], dut.mem[addr_b], re_a, re_b, rst, dout_a, dout_b);

    din_a = 8'b1; din_b = 8'b10;
    addr_a = 4'b1010; addr_b = 4'b1111;
    we_a = 0; we_b = 0;
    re_a = 0; re_b = 0;
    rst = 1;

    #1 rst = 0; 

    // Write from Port A and Read from Port-B
    
    // As frequency of writing of port-A is more and frequency of reading of port-B is low, port-B will miss to read some data written by Port-A. 
    
    // Port-A is fast, Port-B is slow.
    
    @(posedge clk0); we_a = 1;
    @(posedge clk1); re_b = 1;
    @(posedge clk0); din_a = 8'b11;
    @(posedge clk0); din_a = 8'b111;
    @(posedge clk0); din_a = 8'b11010;
    @(posedge clk0); din_a = 8'b10101;
    @(posedge clk0); din_a = 8'b01010;
    @(posedge clk0); din_a = 8'b1111111;
    @(posedge clk0); din_a = 8'b00110011;
    @(posedge clk0); din_a = 8'b11100011;
    @(posedge clk0); din_a = 8'b1101001;
    @(posedge clk0); we_a = 0;
    @(posedge clk1); re_b = 0;

    #10 $finish;
  end

endmodule
