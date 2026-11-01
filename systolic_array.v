`timescale 1ns/1ps

module systolic_array #( parameter N =4 , DW =8) (
    input clk , rst_n ,

    input [ DW * N *N -1:0] weights_flat ,

    input [ DW *N -1:0] inputs_flat ,

    output [2* DW *N -1:0] outputs_flat
);

    wire [ DW -1:0] weights [0: N -1][0: N -1];
    wire [ DW -1:0] inputs [0: N -1];
    wire [2* DW -1:0] outputs [0: N -1];

    genvar i , j ;

    generate

        for ( i = 0; i < N ; i = i + 1) begin : unpack_w

            for ( j = 0; j < N ; j = j + 1) begin : unpack_w_col

                assign weights [ i ][ j ] =
                    weights_flat [(( i * N + j ) * DW ) +: DW ];

            end
        end

        for ( i = 0; i < N ; i = i + 1) begin : unpack_d

            assign inputs [ i ] = inputs_flat [( i * DW ) +: DW ];

        end

    endgenerate


    // ---------- GRID CONNECTIONS ----------

    wire [ DW -1:0] w_int [0: N -1][0: N -1];
    wire [ DW -1:0] d_int [0: N -1][0: N -1];
    wire [2* DW -1:0] p_int [0: N -1][0: N -1];


    generate

        for ( i = 0; i < N ; i = i + 1) begin : row

            for ( j = 0; j < N ; j = j + 1) begin : col

                wire [ DW -1:0] w_in , d_in ;
                wire [2* DW -1:0] p_in ;


                if ( i == 0) begin : top_weight

                    assign w_in = weights [0][ j ];

                end else begin : mid_weight

                    assign w_in = w_int [i -1][ j ];

                end


                if ( j == 0) begin : left_data

                    assign d_in = inputs [ i ];

                end else begin : mid_data

                    assign d_in = d_int [ i ][ j -1];

                end


                if ( i == 0) begin : top_psum

                    assign p_in = 0;

                end else begin : mid_psum

                    assign p_in = p_int [i -1][ j ];

                end


                pe #(. DW ( DW ) ) pe_inst (

                    . clk ( clk ) ,
                    . rst_n ( rst_n ) ,

                    . weight_in ( w_in ) ,
                    . data_in ( d_in ) ,
                    . psum_in ( p_in ) ,

                    . weight_out ( w_int [ i ][ j ]) ,
                    . data_out ( d_int [ i ][ j ]) ,
                    . psum_out ( p_int [ i ][ j ])

                );

            end
        end


        for ( i = 0; i < N ; i = i + 1) begin : pack_out

            assign outputs_flat [( i *2* DW ) +: 2* DW ] =
                p_int [N -1][ i ];

        end

    endgenerate

endmodule