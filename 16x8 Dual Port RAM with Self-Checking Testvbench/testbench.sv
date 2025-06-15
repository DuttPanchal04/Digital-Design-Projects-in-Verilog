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
  reg [7:0] expected_data [0:15];

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

    // self-checking part for write data in memory
    for (i = 0; i < 16; i = i + 1) begin

      expected_data[i] = i;

    end

    // Check memory data after write
    for (i = 0; i < 16; i = i + 1) begin

      if (dut.mem[i] !== expected_data[i]) begin

        $display("Write error at addr %0b | Expected = %0b | Correct Data = %0b", i, expected_data[i], dut.mem[i]);

      end 

      else begin

        $display("Write pass at addr %0b | Data = %0b", i, dut.mem[i]);

      end

    end


    // now Read from all 16 locations using Port B and then compare with expected values

    for (i = 0; i < 16; i = i + 1) begin

      @(posedge clk);
      addr_b = i;
      re_b   = 1;

    end

    @(posedge clk);

    re_b = 0;

    $display("Read completed!");


    // self-checking part for read data from port-B
    re_b = 1;
    
    for (i = 0; i < 16; i = i + 1) begin
      
      addr_b = i;
      
      @(posedge clk);
      
      if (dout_b !== expected_data[i]) begin
        
        $display("Read error at addr %0b | Expected = %0b | Got = %0b", i, expected_data[i], dout_b);
        
      end 
      
      else begin
        
        $display("Read pass at addr %0b | Data = %0b", i, dout_b);
        
      end
      
    end
    
    re_b = 0;



    // check final memory data
    #5;
    for(i=0; i<16; i=i+1) begin
      $display("data is %0b at %0b", dut.mem[i], i);
    end


    #10;

    #10; $finish;

  end

endmodule