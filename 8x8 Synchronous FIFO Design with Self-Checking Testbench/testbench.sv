module sync_8x8_fifo_tb;

  parameter DATA_WIDTH = 8;
  parameter DEPTH = 8;

  reg clk, rst;
  reg we, re;
  reg [DATA_WIDTH-1:0] w_data;
  wire [DATA_WIDTH-1:0] r_data;

  wire full, empty, almost_full, almost_empty;

  integer i;

  // I am taking reference memory array, and some extra varibales for reference pointers and a counter required for slef-checking tb.
  reg [DATA_WIDTH-1:0] ref_fifo [0:DEPTH-1];
  reg [$clog2(DEPTH)-1:0] ref_wp, ref_rp;
  reg [$clog2(DEPTH+1)-1:0] ref_count;


  sync_8x8_fifo dut (
    .clk(clk),
    .rst(rst),
    .we(we),
    .re(re),
    .w_data(w_data),
    .r_data(r_data),
    .full(full),
    .empty(empty),
    .almost_full(almost_full),
    .almost_empty(almost_empty)
  );

  initial begin

    clk = 0;
    forever #5 clk = ~clk;

  end

  initial begin

    $dumpfile("test_fifo.vcd");
    $dumpvars(0, sync_8x8_fifo_tb);

    // monitoring everything
    //$monitor("rst = %b | we = %b | re = %b | wp = %0b | rp = %0b | w_data = %b | r_data = %b | full = %b | empty = %b | almost_full = %b | almost_empty = %b | overrun = %b | underrun = %b |", rst, we, re, dut.wp, dut.rp, w_data, r_data, full, empty, almost_full, almost_empty, dut.overrun, dut.underrun);


    rst = 0; we = 0; re = 0; w_data = 0;
    ref_wp = 0; ref_rp = 0; ref_count = 0;

    #12 rst = 1; we = 1;

    // self-checking part for proper writing data into fifo
    for (i = 0; i < DEPTH; i = i + 1) begin

      @(posedge clk);
      w_data = i;

      ref_fifo[ref_wp] = w_data;
      ref_wp = (ref_wp + 1) % DEPTH;
      ref_count = ref_count + 1;

    end

    @(posedge clk); we = 0;

    @(posedge clk); // wait to update fifo

    // checking reference values with my original design.
    for (i = 0; i < DEPTH; i = i + 1) begin

      if (dut.fifo[i] !== ref_fifo[i]) begin

        $display("Fail at slot %0d | Expected = %0b | Got = %0b", i, ref_fifo[i], dut.fifo[i]);

      end else begin

        $display("Pass at slot %0d | Expected = %0b | Got = %0b", i, ref_fifo[i], dut.fifo[i]);

      end

    end


    // self-checking part for proper reading data from fifo in order.

    re = 1; we = 0;

    for (i = 0; i<8; i = i + 1) begin

      @(posedge clk);

      // checking reference values with my original design.
      if (r_data !== ref_fifo[ref_rp]) begin

        $display("Read fail at cycle %0d | Expected = %0b | Got = %0b", i, ref_fifo[ref_rp], r_data);

      end else begin

        $display("Read pass at cycle %0d | Data = %0b", i, r_data);

      end

      // increment read pointer and decrement counter, same as design logic.
      ref_rp = ref_rp + 1;
      ref_count = ref_count - 1;

    end

    @(posedge clk);
    re = 0;

    #20;

    $finish;

  end

  /*
  // self-checking part for checking status signal conditions. 
  always @(posedge clk) begin

    if (rst) begin

      if (full !== (ref_count == DEPTH)) begin

        $display("Fail: FULL | Expected = %b | Got = %b | ref_count = %0d", (ref_count == DEPTH), full, ref_count);

      end

      if (empty !== (ref_count == 0)) begin

        $display("Fail: EMPTY | Expected = %b | Got = %b | ref_count = %0d", (ref_count == 0), empty, ref_count);

      end

      if (almost_full !== (ref_count >= (DEPTH - 2))) begin

        $display("Fail: ALMOST_FULL | Expected = %b | Got = %b | ref_count = %0d", (ref_count >= (DEPTH - 2)), almost_full, ref_count);

      end

      if (almost_empty !== (ref_count <= 2)) begin

        $display("Fail: ALMOST_EMPTY | Expected = %b | Got = %b | ref_count = %0d", (ref_count <= 2), almost_empty, ref_count);

      end

    end

  end
*/


endmodule