`include "src/ram/ram.vh"

module ram(
    input wire clk,
    input wire en,
    input wire wr,
    input wire reset,
    input wire [`RAM_ADDR_WIDTH_VECTOR] addr,
    input wire [`RAM_DATA_WIDTH_VECTOR] data_in,
    output wire [`RAM_DATA_WIDTH_VECTOR] data_out
);

    reg [`RAM_DATA_WIDTH_VECTOR] rdata[`RAM_SIZE_VECTOR];
    integer i;

    assign data_out = en == `ENABLE ? rdata[addr] : 32'bz;

    initial begin
        for (i = 0; i < `RAM_SIZE; i = i + 1) begin
            rdata[i] <= `RAM_DATA_WIDTH'b0;
        end
    end

    always @(posedge clk) begin
        if (en == `ENABLE) begin
            if (wr == `RAM_WRITE) begin
                rdata[addr] <= data_in;
            end
        end
    end

    always @(posedge reset) begin
        for (i = 0; i < `RAM_SIZE; i = i + 1) begin
            rdata[i] <= `RAM_DATA_WIDTH'b0;
        end
    end
endmodule // ram