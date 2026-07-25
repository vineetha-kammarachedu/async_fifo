`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2026 03:54:06 PM
// Design Name: 
// Module Name: sync_w2r
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


module sync_w2r #(
    parameter ADDR_SIZE = 4
)(
    input rd_clk,
    input rst,

    input [ADDR_SIZE:0] wptr,

    output reg [ADDR_SIZE:0] rq2_wptr
);

    reg [ADDR_SIZE:0] rq1_wptr;

    always @(posedge rd_clk or posedge rst)
    begin
        if(rst)
        begin
            rq1_wptr <= 0;
            rq2_wptr <= 0;
        end

        else
        begin
            rq1_wptr <= wptr;
            rq2_wptr <= rq1_wptr;
        end
    end

endmodule
