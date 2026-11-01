`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.11.2026 04:41:30
// Design Name: 
// Module Name: tb_mac
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

module tb_mac;

    reg clk;
    reg rst;

    reg [1:0] a;
    reg [1:0] b;

    wire [3:0] accumulator;

    mac_unit dut (
        .clk(clk),
        .rst(rst),
        .a(a),
        .b(b),
        .accumulator(accumulator)
    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("mac.vcd");
        $dumpvars(0, tb_mac);

        clk = 0;
        rst = 1;

        a = 0;
        b = 0;

        #10;

        rst = 0;

        a = 2;
        b = 3;

        #10;

        $display("Accumulator = %d", accumulator);

        a = 1;
        b = 2;

        #10;

        $display("Accumulator = %d", accumulator);

        a = 3;
        b = 2;

        #10;

        $display("Accumulator = %d", accumulator);

        #10;

        $finish;

    end

endmodule