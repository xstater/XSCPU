`ifndef _ALU_H_
`define _ALU_H_

`include "src/defs.vh"

`define ALU_INPUT_WIDTH 32
`define ALU_INPUT_WIDTH_VECTOR (`ALU_INPUT_WIDTH-1):0
`define ALU_OUTPUT_WIDTH 32
`define ALU_OUTPUT_WIDTH_VECTOR (`ALU_OUTPUT_WIDTH-1):0

`define ALU_OPS_WIDTH 4
`define ALU_OPS_WIDTH_VECTOR (`ALU_OPS_WIDTH-1):0

`define ALU_OP_ADD 1
`define ALU_OP_SUB 2
`define ALU_OP_INC 3
`define ALU_OP_DEC 4
`define ALU_OP_AND 5
`define ALU_OP_OR  6
`define ALU_OP_NOT 7
`define ALU_OP_XOR 8
`define ALU_OP_NEG 9

`endif