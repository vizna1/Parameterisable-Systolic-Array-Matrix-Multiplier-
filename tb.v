`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.11.2026 04:40:52
// Design Name: 
// Module Name: tb
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

module tb ;

    parameter N =4 , DW =8;

    reg clk , rst_n ;

    reg [ DW * N *N -1:0] weights_flat ;

    reg [ DW *N -1:0] inputs_flat ;

    wire [2* DW *N -1:0] outputs_flat ;


    systolic_array #(. N ( N ) , . DW ( DW ) ) dut (

        . clk ( clk ) ,
        . rst_n ( rst_n ) ,

        . weights_flat ( weights_flat ) ,
        . inputs_flat ( inputs_flat ) ,

        . outputs_flat ( outputs_flat )

    );


    always #5 clk = ~ clk ;


    integer i , j ;

    initial begin

        $dumpfile ( "dump.vcd" ) ;
        $dumpvars (0 , tb ) ;


        clk = 0;
        rst_n = 0;


        // Pack the weights (All 1s)

        for ( i = 0; i < N ; i = i + 1) begin

            for ( j = 0; j < N ; j = j + 1) begin

                weights_flat [(( i * N + j ) * DW ) +: DW ] = 1;

            end

        end


        // Pack the inputs (All 2s)

        for ( i = 0; i < N ; i = i + 1) begin

            inputs_flat [( i * DW ) +: DW ] = 2;

        end


        #10 rst_n = 1;

        #100;


        $display (
            "\n-------------------------------------------------"
        );

        $display ( "Expected all outputs = 8." );


        // Unpack the outputs

        for ( i = 0; i < N ; i = i + 1) begin

            $display (
                "Output [%0d] = %0d",
                i,
                outputs_flat [( i *2* DW ) +: 2* DW ]
            );

        end


        $display (
            "\n-------------------------------------------------"
        );


        #20 $finish ;

    end

endmodule
