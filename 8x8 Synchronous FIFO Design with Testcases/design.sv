module sync_8x8_fifo #(
  parameter DATA_WIDTH = 8, // data bus is 8 bit wide
  parameter DEPTH = 8 // number of slots/racks is 8
)(
  input clk, rst,
  input we, re,

  // 8 bit write & read data
  input [DATA_WIDTH-1:0] w_data,
  output reg [DATA_WIDTH-1:0] r_data,
  output reg full, empty, almost_empty, almost_full
);

  // 3 bit write/read pointers
  reg [$clog2(DEPTH)-1:0] wp, rp;
  
  // memory array 
  reg [DATA_WIDTH-1:0] fifo [0:DEPTH-1];

  // additional counter
  reg [$clog2(DEPTH+1)-1:0] count;

  // varibales for overrun and underrun
  reg overrun, underrun;

  always @(posedge clk or negedge rst) begin

    // if reset is 0 (active low), then move our pointers to 000 and clear output read data port. 

    if (!rst) begin
      wp <= 0; rp <= 0;
      r_data <= 0;
      count <= 0;
      full <= 0;
      empty <= 1;
      almost_full <= 0;
      almost_empty <= 1;
    end 

    // if reset is high, then start main operation.
    else begin


      // if write enable (we) is high AND full is low, then write data into fifo and then increment the write pointer by 1.
     if (we && !full) begin
        fifo[wp] <= w_data;
        wp <= wp + 1;
        count <= count + 1;
      end
     
      // if read enable is high AND empty is low then only read data from fifo and increament read pointers
      if (re && !empty) begin
        r_data <= fifo[rp];
        fifo[rp] <= 8'b0; // clear data inside fifo once it readed
        rp <= rp + 1;
        count <= count - 1;
      end

      // assigning value to some output status signals based on some condition

      // when count reach == depth, then make full flag high.
      full <= (count == DEPTH);

      // when count reach == 0, then make empty flag high.
      empty <= (count == 0);

      // if count >= 6 in this case, almost_full will high.
      almost_full <= (count >= DEPTH-2);

      // when count <= 2 here, almost_empty will high.
      almost_empty <= (count <= 3'b010);

      // checking overrun and overrun

      // when both we and full flag is high, then its overrun. (just inform by flag, not taking any action)
      overrun <= (we && full);

      // when both re and empty flag is high, then its underrun. (just inform by flag, not taking any action)
      underrun <= (re && empty);


    end
  end

endmodule
