`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2026 03:38:58 PM
// Design Name: 
// Module Name: async_fifo
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


module async_fifo #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_SIZE  = 4
)(
    input wr_clk,
    input rd_clk,
    input rst,

    input wr_en,
    input rd_en,

    input [DATA_WIDTH-1:0] data_in,

    output [DATA_WIDTH-1:0] data_out,

    output full,
    output empty
);

    // INTERNAL POINTER SIGNALS

    wire [ADDR_SIZE:0] wptr;
    wire [ADDR_SIZE:0] rptr;

    wire [ADDR_SIZE:0] wgray;
    wire [ADDR_SIZE:0] rgray;

    // SYNCHRONIZED POINTERS

    wire [ADDR_SIZE:0] wq2_rptr;
    wire [ADDR_SIZE:0] rq2_wptr;

    //====================================================
    // WRITE POINTER + FULL LOGIC
    //====================================================

    wptr_full #(ADDR_SIZE) wptr_full_inst (
        .wr_clk(wr_clk),
        .rst(rst),
        .wr_en(wr_en),

        .wq2_rptr(wq2_rptr),

        .full(full),

        .wptr(wptr),
        .wgray(wgray)
    );

    //====================================================
    // READ POINTER + EMPTY LOGIC
    //====================================================

    rptr_empty #(ADDR_SIZE) rptr_empty_inst (
        .rd_clk(rd_clk),
        .rst(rst),
        .rd_en(rd_en),

        .rq2_wptr(rq2_wptr),

        .empty(empty),

        .rptr(rptr),
        .rgray(rgray)
    );

    //====================================================
    // READ POINTER SYNCHRONIZER
    //====================================================

    sync_r2w #(ADDR_SIZE) sync_r2w_inst (
        .wr_clk(wr_clk),
        .rst(rst),

        .rptr(rgray),

        .wq2_rptr(wq2_rptr)
    );

    //====================================================
    // WRITE POINTER SYNCHRONIZER
    //====================================================

    sync_w2r #(ADDR_SIZE) sync_w2r_inst (
        .rd_clk(rd_clk),
        .rst(rst),

        .wptr(wgray),

        .rq2_wptr(rq2_wptr)
    );

    //====================================================
    // FIFO MEMORY
    //====================================================

    fifo_mem #(DATA_WIDTH, ADDR_SIZE) fifo_mem_inst (
        .wr_clk(wr_clk),
        .wr_en(wr_en && !full),

        .wptr(wptr),
        .rptr(rptr),

        .data_in(data_in),

        .data_out(data_out)
    );

endmodule