// Code your design here

module fa(

	input a,
  	input b,
  input cin,
  	output s,
  output cout
  
);
  
  assign s = (a^b)^cin;
  assign cout = ((a&b) | (b&cin) | (a&cin));
  
endmodule