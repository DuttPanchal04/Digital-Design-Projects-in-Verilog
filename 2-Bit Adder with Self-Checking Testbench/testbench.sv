// Code your testbench here
// or browse Examples
`timescale 1ns/1ps

module adder_tb;

    reg  [1:0] a, b;
    wire [2:0] sum;

    reg [2:0] expected_sum;

    adder uut (
        .a(a),
        .b(b),
        .sum(sum)
    );

    task run_test;
        input [1:0] ta, tb;
        begin
            a = ta;
            b = tb;
            expected_sum = ta + tb;
            #5; 

            if (sum === expected_sum)
                $display("PASS: a=%b b=%b sum=%b", a, b, sum);
            else
                $display("FAIL: a=%b b=%b sum=%b (expected %b)", a, b, sum, expected_sum);
        end
    endtask

    initial begin
        $display("Starting self-checking testbench...");
        
        run_test(2'b00, 2'b00);
        run_test(2'b01, 2'b01);
        run_test(2'b10, 2'b01);
        run_test(2'b11, 2'b01);
        run_test(2'b10, 2'b10);
        run_test(2'b11, 2'b11);

        $display("Testing complete.");
        $finish;
    end

endmodule
