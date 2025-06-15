//50 Mhz,50% Duty Cycle
`timescale 1ns/1ps
module top;
	logic clk=0;
 // real freq=50_00_00_00; // for 50mhz clock
  
  real freq = 25_00_00_00; // for 25mhz clock
  
  real time_total=1/freq * (10**9); 
  
  //real duty_cycle=0.50; // with 50% duty cycle where ton=toff
    
 real duty_cycle=0.25; // with 25% duty cycle where ton<toff
  
   // real duty_cycle=0.75; // with 75% duty cycle where ton>toff
  
  // real duty_cycle=1; // with 100% duty cycle where ton (toff=0)
  
  real t_on=time_total * duty_cycle;
  
  real t_off=time_total-t_on;
  
  always begin
    
    #(t_off)clk=1;
    #(t_on) clk=0;
    
  end
  
  initial begin
    
    $dumpfile("test_clk.vcd");
    $dumpvars(0, top);
    
    $display("Frequency: %0f",freq);
    $display("Time period: %0f",time_total);
    $display("Duty: %0f",duty_cycle);
    $display("Ton : %0f",t_on);
    $display("Toff: %0f",t_off);
    #1000 $finish;
  end
  
endmodule