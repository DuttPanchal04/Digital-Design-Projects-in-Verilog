// Code your testbench here
// or browse Examples
module tb;

  reg [7:0] din_a, din_b;
  reg [3:0] addr_a, addr_b;
  reg we_a, we_b;
  reg re_a, re_b;
  wire [7:0] dout_a, dout_b;
  reg clk;
  reg rst;

  dual_port_ram dut(

    .clk(clk),
    .rst(rst),
    .din_a(din_a),
    .din_b(din_b),
    .dout_a(dout_a),
    .dout_b(dout_b),
    .addr_a(addr_a),
    .addr_b(addr_b),
    .we_a(we_a),
    .we_b(we_b),
    .re_a(re_a),
    .re_b(re_b)

  );

  integer i;

  // clock generation
  initial begin

    clk = 0;
    forever #5 clk = ~clk;

  end


  // actual testcases
  initial begin

    $dumpfile("test_dpt.vcd");
    $dumpvars(0, tb);

    $monitor("Time = %t | Din_a = %b | Din_b = %b | addr_a = %b | addr_b = %b | we_a = %b | we_b = %b | @addr_a = %b | @addr_b = %b | re_a = %b | re_b = %b | rst = %b | dout_a = %b | dout_b = %b", $realtime, din_a, din_b, addr_a, addr_b, we_a, we_b, dut.mem[addr_a], dut.mem[addr_b], re_a, re_b, rst, dout_a, dout_b);


    // initially
    din_a = 8'b1; din_b = 8'b10;

    addr_a = 4'b1010; addr_b = 4'b1111; // for writing on different addresses

    // addr_a = 4'b1111; addr_b = 4'b1111; // for writing on same address

    we_a = 1'b0; we_b = 1'b0;

    re_a = 1'b0; re_b = 1'b0;

    rst = 1'b1;


    // check data in memory before any write. (Default value) or used this for loop block to check data after reset testcase also.
    /*
    for(i=0; i<16; i=i+1) begin
      $display("data is %0b at %0b", dut.mem[i], i);
    end
    */


    /*
    // WWWWW-RRRRR (Write and Read by Port-A)
    @(posedge clk);

    we_a = 1; re_a = 0;

    for (i = 0; i < 5; i = i + 1) begin
      addr_a = i;
      @(posedge clk);
    end

    we_a = 0; re_a = 1;

    for (i = 0; i < 5; i = i + 1) begin
      addr_a = i;
      @(posedge clk);
      //$display("Read A: addr = %0d, data = %0d", i, dout_a);
    end

    re_a = 0;
	*/


    /*
    // WRWRWRWRWRWR... (through port-B)
    for (i = 5; i < 10; i = i + 1) begin

      addr_b = i;
      we_b = 1; re_b = 0;
      @(posedge clk);
      we_b = 0; re_b = 1;
      @(posedge clk);
      //$display("Read B: addr = %0d, data = %0d", i, dout_b);

    end

    re_b = 0;

*/


    // write data from both ports to different memory locations


    /*    
    @(posedge clk);
    we_a = 1'b1;
    we_b = 1'b1; 
	*/


    /*
    @(posedge clk);
    we_b = 1'b0;
    we_a = 1'b1;

    @(posedge clk);
    we_a = 1'b0;
    we_b = 1'b1;
    */


    /*
     @(posedge clk);
      we_a = 1'b0;
      we_b = 1'b0;
   */  


    // when both ports try to write on same address
    /*
    @(posedge clk);

    we_a = 1;
    we_b = 1;

    @(posedge clk);
    we_a = 0; we_b = 0; 

    @(posedge clk);
    re_a = 1'b1;
    re_b = 1'b1;
    $display("dout_a = %b | dout_b = %b", dout_a, dout_b);
    */



    // read data from memory locations
    /*
    @(posedge clk);
    we_a = 1'b0;
    we_b = 1'b0;
    re_a = 1'b1;
    re_b = 1'b1;
   */


    // check data in memory after write.
    /*for(i=0; i<16; i=i+1) begin
      $display("data is %0b at %0b", dut.mem[i], i);
    end
   */



    // Read during write (different address)
    /*
    addr_a = 4'b0001; din_a = 8'hAA; din_b = 8'h0A; we_a = 1;
    addr_b = 4'b0010; re_b = 1;

    @(posedge clk);

    we_a = 0; re_b = 0;
*/


    // Read during write (same address)
    /*
    addr_a = 4'd3; din_a = 8'hBB; we_a = 1;
    addr_b = 4'd3; re_b = 1;
    @(posedge clk);
    we_a = 0; re_b = 0;
*/


    // Write to all 16 memory address locations using Port A
  
    for (i = 0; i < 16; i = i + 1) begin
      @(posedge clk);
      addr_a = i;
      din_a  = i;
      we_a   = 1;
    end

    @(posedge clk);
    we_a = 0;

    $display("Write completed!");

    // Read from all 16 locations using Port B
    
    for (i = 0; i < 16; i = i + 1) begin
      @(posedge clk);
      addr_b = i;
      re_b   = 1;
    end

    @(posedge clk);
    re_b = 0;

    $display("Read completed!");



    /* use this for check reset at any time ( clears all memory locations and both port's output pins). First write something, then read it, then reset, and then read again.*/

    /*
    #10;
    rst = 1'b0;
    */


    // check final memory data
    #5;
    for(i=0; i<16; i=i+1) begin
      $display("data is %0b at %0b", dut.mem[i], i);
    end



    #10;

    #10; $finish;

  end

endmodule