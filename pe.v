`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.11.2026 04:37:17
// Design Name: 
// Module Name: pe
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

module pe #( parameter DW =8) (
    input clk , rst_n ,
    input [ DW -1:0] weight_in ,
    input [ DW -1:0] data_in ,
    input [2* DW -1:0] psum_in ,
    output [ DW -1:0] weight_out ,
    output [ DW -1:0] data_out ,
    output [2* DW -1:0] psum_out
);

    reg [ DW -1:0] weight_reg , data_reg ;
    reg [2* DW -1:0] psum_reg ;

    wire [2* DW -1:0] product = weight_reg * data_reg ;

    always @ ( posedge clk or negedge rst_n ) begin
        if (! rst_n ) begin
            weight_reg <= 0;
            data_reg <= 0;
            psum_reg <= 0;
        end else begin
            weight_reg <= weight_in ;
            data_reg <= data_in ;
            psum_reg <= psum_in + product ;
        end
    end

    assign weight_out = weight_reg ;
    assign data_out = data_reg ;
    assign psum_out = psum_reg ;

endmodule
