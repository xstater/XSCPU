`include "src/ram/ram.vh"

module ram(
    input wire clk,
    input wire en,
    input wire wr,
    input wire reset,
    input wire [`RAM_ADDR_WIDTH_VECTOR] addr,
    inout wire [`RAM_DATA_WIDTH_VECTOR] data
);

    reg [`RAM_DATA_WIDTH_VECTOR] rdata[`RAM_SIZE_VECTOR];
    integer i;

    always @(posedge clk) begin
        if (en == `ENABLE) begin
            if (reset == `ENABLE) begin
                for (i = 0; i < `RAM_SIZE; i = i + 1) begin
                    rdata[i] <= `RAM_DATA_WIDTH'b0;
                end
            end else if (wr == `RAM_WRITE) begin
                
            end
        end
    end
endmodule // ram