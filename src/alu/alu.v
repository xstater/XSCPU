`include "src/alu/alu.vh"

module alu(
    input wire clk,
    input wire en,
    input wire in_select,
    input wire [`ALU_OPS_WIDTH_VECTOR] op,
    input wire [`ALU_DATA_WIDTH_VECTOR] in,
    output wire [`ALU_DATA_WIDTH_VECTOR] out
);

    reg [`ALU_DATA_WIDTH_VECTOR] result;
    reg [`ALU_DATA_WIDTH_VECTOR] i1,i2;

    assign out = result;

    initial begin
        i1 <= `ALU_DATA_WIDTH'b0;
        i2 <= `ALU_DATA_WIDTH'b0;
    end

    always @(posedge clk) begin
        if (en == `ENABLE) begin
            if (in_select == `ALU_IN_SELECT_I1) begin
                i1 <= in;
            end else begin
                i2 <= in;
            end
        end
        case (op)
            `ALU_OP_ADD: result <= i1 + i2;
            `ALU_OP_SUB: result <= i1 - i2;
            `ALU_OP_INC: result <= i1 + `ALU_DATA_WIDTH'b1;
            `ALU_OP_DEC: result <= i1 - `ALU_DATA_WIDTH'b1;
            `ALU_OP_AND: result <= i1 & i2;
            `ALU_OP_OR : result <= i1 | i2;
            `ALU_OP_NOT: result <= ~i1;
            `ALU_OP_XOR: result <= i1 ^ i2;
            `ALU_OP_NEG: result <= -i1;
            default: result <= i1;
        endcase
    end

endmodule // alu