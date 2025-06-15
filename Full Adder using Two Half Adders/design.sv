// Code your design here
module ha(

	input a, b,
  	output s, c
  
);
  
  assign s = a^b;
  assign c = a&&b;
  
endmodule

// Full adder using Half Adder using Instantiation
module fa(

  input a, b, cin,
  output s, cout

);
  
  wire w1, w2, w3;
  
  ha h1( .a(a), .b(b), .s(w1), .c(w2) );
  ha h2( .a(w1), .b(cin), .s(s), .c(w3) );
  
  or(cout, w3, w2);
  
endmodule