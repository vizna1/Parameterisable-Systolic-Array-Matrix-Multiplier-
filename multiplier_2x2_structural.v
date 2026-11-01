module multiplier_2x2_structural (
    input [1:0] a,
    input [1:0] b,
    output [3:0] product
);

    wire p00, p01, p10, p11;
    wire c1;

    assign p00 = a[0] & b[0];
    assign p01 = a[0] & b[1];
    assign p10 = a[1] & b[0];
    assign p11 = a[1] & b[1];

    assign product[0] = p00;

    full_adder FA1 (
        .a(p01),
        .b(p10),
        .cin(1'b0),
        .sum(product[1]),
        .cout(c1)
    );

    full_adder FA2 (
        .a(p11),
        .b(c1),
        .cin(1'b0),
        .sum(product[2]),
        .cout(product[3])
    );

endmodule