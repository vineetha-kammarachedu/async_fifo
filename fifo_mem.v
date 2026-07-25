`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2026 03:56:39 PM
// Design Name: 
// Module Name: fifo_mem
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


module fifo_mem #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_SIZE  = 4
)(
    input wr_clk,
    input wr_en,

    input [ADDR_SIZE:0] wptr,
    input [ADDR_SIZE:0] rptr,

    input [DATA_WIDTH-1:0] data_in,

    output [DATA_WIDTH-1:0] data_out
);

    // MEMORY ARRAY
    reg [DATA_WIDTH-1:0] mem [0:(1<<ADDR_SIZE)-1];

    // WRITE OPERATION
    always @(posedge wr_clk)
    begin
        if(wr_en)
        begin
            mem[wptr[ADDR_SIZE-1:0]] <= data_in;
        end
    end

    // READ OPERATION
    assign data_out = mem[rptr[ADDR_SIZE-1:0]];

endmodule