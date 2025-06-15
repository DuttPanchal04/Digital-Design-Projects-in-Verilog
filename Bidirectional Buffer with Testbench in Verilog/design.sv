module bi_buf(
	
  inout wire a,
  inout wire b,
  input wire en

);
  
  assign b = en ? a : 1'bz;  
  assign a = ~en ? b : 1'bz; 
  
endmodule

