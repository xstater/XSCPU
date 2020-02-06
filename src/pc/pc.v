`include "src/pc/pc.vh"

module pc(
    input wire clk,
    input wire en,
    input wire jmp,
    input wire reset,
    input wire [`PC_ADDR_WIDTH_VECTOR] addr_in,
    output wire [`PC_ADDR_WIDTH_VECTOR] addr_out
);

    reg [`PC_ADDR_WIDTH_VECTOR] addr;

    assign addr_out = addr;

    initial begin
        addr <= `PC_ADDR_WIDTH'b0;
    end

    always @(posedge clk) begin
        if (en == `ENABLE) begin
            if (jmp == `ENABLE) begin
                addr <= addr_in;
            end else begin
                addr <= addr + `PC_ADDR_WIDTH'b1;
            end
        end
    end

    always @(posedge reset) begin
        addr <= `PC_ADDR_WIDTH'b0;
    end

endmodule // pc