`include "src/stack/stack.vh"

module stack(
    input wire clk,
    input wire en,
    input wire reset,
    input wire push,//push:1 push 0 pop 
    input wire [`STACK_DATA_WIDTH_VECTOR] data_in,
    output wire [`STACK_DATA_WIDTH_VECTOR] data_out
);

    reg [`STACK_DATA_WIDTH_VECTOR] istack[`STACK_WIDTH_VECTOR];
    reg [`STACK_DATA_WIDTH_VECTOR] output_buffer;
    reg [`STACK_WIDTH_VECTOR] top_ptr;
    integer i;

    assign data_out = output_buffer;

    initial begin
        top_ptr <= `STACK_WIDTH'b0;
        istack[top_ptr] <= `STACK_DATA_WIDTH'b0;
        output_buffer <= istack[top_ptr];
    end

    always @(posedge clk) begin
        if (en == `ENABLE) begin
            if (push == `STACK_PUSH) begin
                top_ptr = top_ptr + `STACK_WIDTH'b1;
                istack[top_ptr] = data_in;
                output_buffer = istack[top_ptr];
            end else begin
                top_ptr = top_ptr - `STACK_WIDTH'b1;
                output_buffer = istack[top_ptr];
            end
        end
    end

    always @(posedge reset) begin
        top_ptr <= `STACK_WIDTH'b0;
    end

endmodule // stack