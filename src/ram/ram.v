`include "src/ram/ram.vh"

module ram(
    input wire clk,
    input wire en,
    input wire wr,
    input wire [`RAM_ADDR_WIDTH] addr,
    inout wire [`RAM_DATA_WIDTH] data
);

    reg [`RAM_DATA_WIDTH] rdata[`RAM_SIZE];

endmodule // ram