`timescale 1ns / 1ps



module wptr_full #(
    parameter ADDR_SIZE = 4
)(
    input wr_clk,
    input rst,
    input wr_en,

    input [ADDR_SIZE:0] wq2_rptr,

   output full,
    output reg [ADDR_SIZE:0] wptr,
    output reg [ADDR_SIZE:0] wgray
);

    // INTERNAL REGISTERS
    wire [ADDR_SIZE:0] wbinnext;
    wire [ADDR_SIZE:0] wgraynext;
    reg [ADDR_SIZE:0] wbin;

    // NEXT POINTER LOGIC
    wire winc;

    assign winc = wr_en && !full;

    assign wbinnext = wbin + winc;

    assign wgraynext = (wbinnext >> 1) ^ wbinnext;
always @(posedge wr_clk or posedge rst)
begin
    if(rst)
    begin
        wbin  <= 0;
        wptr  <= 0;
        wgray <= 0;
    end

    else
    begin
        wbin  <= wbinnext;
        wptr  <= wbinnext;
        wgray <= wgraynext;
    end
end
    assign full = (wgraynext ==
              {~wq2_rptr[ADDR_SIZE:ADDR_SIZE-1],
                wq2_rptr[ADDR_SIZE-2:0]});
endmodule
