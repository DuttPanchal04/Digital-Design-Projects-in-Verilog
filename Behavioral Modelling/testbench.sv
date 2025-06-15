module tb;
 
  reg A, B;
  wire Y;

  and_gate dut (
    
    .Y(Y), .A(A), .B(B)
  );

  initial begin

    A = 0; B = 0; #10;
    $display("%b", Y);
    A = 0; B = 1; #10;
     $display("%b", Y);
    A = 1; B = 0; #10;
     $display("%b", Y);
    A = 1; B = 1; #10;
     $display("%b", Y);
    $finish;
  end
endmodule
