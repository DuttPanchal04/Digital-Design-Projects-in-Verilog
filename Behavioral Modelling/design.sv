// Behavioural Modeling
module and_gate(output reg Y, input A, B);
  always @ (*)
    Y = A & B; 
endmodule