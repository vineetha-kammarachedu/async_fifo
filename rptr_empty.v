module rptr_empty #(
    parameter ADDR_SIZE = 4
)(
    input rd_clk,
    input rst,
    input rd_en,

    input [ADDR_SIZE:0] rq2_wptr,

    output empty,

    output reg [ADDR_SIZE:0] rptr,
    output reg [ADDR_SIZE:0] rgray
);

    // INTERNAL SIGNALS
    wire [ADDR_SIZE:0] rbinnext;
    wire [ADDR_SIZE:0] rgraynext;

    reg [ADDR_SIZE:0] rbin;

    wire rinc;

    // EMPTY CONDITION
    wire rempty_val;

    // READ ENABLE
    assign rinc = rd_en && !rempty_val;

    // NEXT BINARY POINTER
    assign rbinnext = rbin + rinc;

    // BINARY TO GRAY
    assign rgraynext = (rbinnext >> 1) ^ rbinnext;

    // EMPTY DETECTION
    assign rempty_val = (rgraynext == rq2_wptr);

    assign empty = rempty_val;

    // POINTER UPDATE
    always @(posedge rd_clk or posedge rst)
    begin
        if(rst)
        begin
            rbin  <= 0;
            rptr  <= 0;
            rgray <= 0;
        end

        else
        begin
            rbin  <= rbinnext;
            rptr  <= rbinnext;
            rgray <= rgraynext;
        end
    end

endmodule