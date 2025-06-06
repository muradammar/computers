`timescale 1ns / 1ps

module test_bench;

    logic a, b, c;
    logic sum, carry;

    //instantiate the DUT 
    full_adder fa1 (
        .a(a),
        .b(b),
        .c(c),
        .sum(sum),
        .carry(carry)
    );

    initial begin
        $monitor("a=%b, b=%b, c=%b => sum=%b, carry=%b", a, b, c, sum, carry);

        a=0; b=0; c=0; #10;
        a=1; b=0; c=0; #10;
        a=0; b=1; c=0; #10;
        a=0; b=0; c=1; #10;
        a=1; b=1; c=0; #10;
        a=1; b=0; c=1; #10;
        a=0; b=1; c=1; #10;
        a=1; b=1; c=1; #10;

        $finish;
    end

endmodule