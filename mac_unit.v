module mac_unit (
    input clk,
    input rst,
    input [1:0] a,
    input [1:0] b,
    output reg [3:0] accumulator
);

    wire [3:0] product;

    multiplier_2x2 mult (
        .a(a),
        .b(b),
        .product(product)
    );

    always @(posedge clk) begin

        if (rst)
            accumulator <= 4'b0000;

        else
            accumulator <= accumulator + product;

    end

endmodule