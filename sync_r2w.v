`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2026 03:52:28 PM
// Design Name: 
// Module Name: sync_r2w
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


module sync_r2w #(
    parameter ADDR_SIZE = 4
)(
    input wr_clk,
    input rst,

    input [ADDR_SIZE:0] rptr,

    output reg [ADDR_SIZE:0] wq2_rptr
);

    reg [ADDR_SIZE:0] wq1_rptr;

    always @(posedge wr_clk or posedge rst)
    begin
        if(rst)
        begin
            wq1_rptr <= 0;
            wq2_rptr <= 0;
        end

        else
        begin
            wq1_rptr <= rptr;
            wq2_rptr <= wq1_rptr;
        end
    end

endmodule