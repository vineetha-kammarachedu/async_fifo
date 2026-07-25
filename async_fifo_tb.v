`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2026 04:04:28 PM
// Design Name: 
// Module Name: async_fifo_tb
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


module async_fifo_tb;

    parameter DATA_WIDTH = 8;
    parameter ADDR_SIZE  = 4;

    reg wr_clk;
    reg rd_clk;
    reg rst;

    reg wr_en;
    reg rd_en;

    reg [DATA_WIDTH-1:0] data_in;

    wire [DATA_WIDTH-1:0] data_out;

    wire full;
    wire empty;

    // DUT INSTANTIATION

    async_fifo #(DATA_WIDTH, ADDR_SIZE) dut (
        .wr_clk(wr_clk),
        .rd_clk(rd_clk),
        .rst(rst),

        .wr_en(wr_en),
        .rd_en(rd_en),

        .data_in(data_in),

        .data_out(data_out),

        .full(full),
        .empty(empty)
    );

    //====================================================
    // WRITE CLOCK : 10ns
    //====================================================

    always #5 wr_clk = ~wr_clk;

    //====================================================
    // READ CLOCK : 14ns
    //====================================================

    always #7 rd_clk = ~rd_clk;

    //====================================================
    // TEST SEQUENCE
    //====================================================

    initial
    begin

        // INITIAL VALUES
        wr_clk = 0;
        rd_clk = 0;

        rst = 1;

        wr_en = 0;
        rd_en = 0;

        data_in = 0;

        // RESET
        #20;
        rst = 0;

        // WRITE DATA
        #10;

        wr_en = 1;

        data_in = 8'h11; #10;
        data_in = 8'h22; #10;
        data_in = 8'h33; #10;
        data_in = 8'h44; #10;

        wr_en = 0;

        // WAIT
        #40;

        // READ DATA
        rd_en = 1;

        #80;

        rd_en = 0;

        // END SIMULATION
        #50;
        
// OVERFLOW TEST

    wr_en = 1;

    repeat(20)
   begin
     data_in = data_in + 1;
     #10;
   end

wr_en = 0;

// UNDERFLOW TEST

rd_en = 1;

#300;

rd_en = 0;

#50;

#50;
        $finish;

    end

endmodule