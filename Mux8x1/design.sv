// Code your design here
module mux_8_1(

  input wire i0,
  input wire i1,
  input wire i2,
  input wire i3,
  input wire i4,
  input wire i5,
  input wire i6,
  input wire i7,
  input wire [2:0] sel,
  output reg y

);

  always @(*) begin

    case (sel)

      3'b000: y = i0;
      3'b001: y = i1;
      3'b010: y = i2;
      3'b011: y = i3;
      3'b100: y = i4;
      3'b101: y = i5;
      3'b110: y = i6;
      3'b111: y = i7;
      default:  y = i0;
    endcase
  end

endmodule