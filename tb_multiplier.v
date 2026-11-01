`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.11.2026 04:42:05
// Design Name: 
// Module Name: tb_multiplier
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns/1ps

module tb_multiplier;

    reg [1:0] a;
    reg [1:0] b;

    wire [3:0] product;

    integer i, j;

    multiplier_2x2 dut (
        .a(a),
        .b(b),
        .product(product)
    );

    initial begin

        $display("2x2 MULTIPLIER TEST");

        for (i = 0; i < 4; i = i + 1) begin

            for (j = 0; j < 4; j = j + 1) begin

                a = i;
                b = j;

                #10;

                $display(
                    "A=%d B=%d Product=%d Expected=%d",
                    a, b, product, i*j
                );

                if (product !== i*j)
                    $display("ERROR");

            end

        end

        $finish;

    end

endmodule