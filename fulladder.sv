module half_adder (
    input logic a, 
    input logic b, 
    output logic sum,
    output logic carry
);
  
    assign sum = a ^ b;
    assign carry = a & b;
  
endmodule

module full_adder (
    input logic a, 
    input logic b,
    input logic c,
    output logic sum,
    output logic carry
);

    logic sum1, carry1, carry2;

    half_adder ha1 (.a(a), .b(b), .sum(sum1), .carry(carry1));
    half_adder ha2 (.a(sum1), .b(c), .sum(sum), .carry(carry2));

    assign carry = carry1 | carry2;

endmodule
