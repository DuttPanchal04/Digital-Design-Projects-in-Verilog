// Code your testbench here
// or browse Examples
module mux_8_1_tb;

  reg i0,i1,i2,i3, i4, i5, i6, i7;
  reg [2:0] sel;
  wire y;

  mux_8_1 dut(

    .i0(i0),
    .i1(i1),
    .i2(i2),
    .i3(i3),
    .i4(i4),
    .i5(i5),
    .i6(i6),
    .i7(i7),
    .sel(sel),
    .y(y)

  );

  initial begin

    $monitor("Time=%0t | sel=%b | y=%b", $time, sel, y);

    $dumpfile("test_mux8x1.vcd");
    $dumpvars(0, mux_8_1_tb);

    i0 = 1'b1; i1 = 1'b0; i2 = 1'b1; i3 = 1'b0; i4=1'b0; i5 = 0; i6 = 1; i7 = 0; sel = 3'b000;

    #5 sel = 3'b000;
    #5 sel = 3'b001;
    #5 sel = 3'b010;
    #5 sel = 3'b011;
    #5 sel = 3'b100;
    #5 sel = 3'b101;
    #5 sel = 3'b110;
    #5 sel = 3'b111;
    
    #5 $finish;

  end
endmodule