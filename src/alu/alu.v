`include "src/alu/alu.vh"

module alu(
    input wire [`ALU_OPS_WIDTH_VECTOR] op,
    input wire [`ALU_INPUT_WIDTH_VECTOR] i1,
    input wire [`ALU_INPUT_WIDTH_VECTOR] i2,
    output wire [`ALU_OUTPUT_WIDTH_VECTOR] o
);

    reg [31:0] result;

    assign o = result;

    always @(*) begin
        case (op)
            `ALU_OP_ADD: result <= i1 + i2;
            `ALU_OP_SUB: result <= i1 - i2;
            `ALU_OP_INC: result <= i1 + `ALU_INPUT_WIDTH'b1;
            `ALU_OP_DEC: result <= i1 - `ALU_INPUT_WIDTH'b1;
            `ALU_OP_AND: result <= i1 & i2;
            `ALU_OP_OR : result <= i1 | i2;
            `ALU_OP_NOT: result <= ~i1;
            `ALU_OP_XOR: result <= i1 ^ i2;
            `ALU_OP_NEG: result <= -i1;
            default: result <= i1;
        endcase
    end

endmodule // alu