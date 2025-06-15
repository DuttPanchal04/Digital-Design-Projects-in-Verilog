// Code your design here
module seq_det(

	input clk,
  	input rst,
  	input in,
  	output out
  
);
  
  reg [2:0] current_state, next_state;
 
  parameter a = 0,
          b = 1,
          c = 2,
          d = 3,
          e = 4,
          f = 5;
 
  assign out = (current_state == f) ? b : a;  
  
  /*always @(posedge clk or posedge rst) begin
    
    if (rst)
      current_state <= a;
    else
      current_state <= next_state;
  
  end
  */
  
  // we used active low reset because it is less affected by noise and power on glitches. Active low ( 0 ) is more noise immune and reliable at power on than active high ( 1 ). If active high is used, it can float the inputs at unexpected noise or at power on. That's why we used active low reset.
  
  always @(posedge clk or negedge rst) begin
    
    if (!rst)
      current_state <= next_state;
    else
      current_state <= a;
	
  end
  
  always @(current_state or in) begin
    
    case (current_state)
      
      a: next_state = in ? b : a;
      b: next_state = in ? c : a;
      c: next_state = in ? c : d;
      d: next_state = in ? e : a;
      e: next_state = in ? c : f;
      f: next_state = in ? b : a;
      
    endcase
    
  end
  
endmodule