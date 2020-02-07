`ifndef _STACK_H_
`define _STACK_H_

`include "src/defs.vh"

`define STACK_SIZE 128
`define STACK_WIDTH 8
`define STACK_WIDTH_VECTOR (`STACK_WIDTH-1):0

`define STACK_DATA_WIDTH 32
`define STACK_DATA_WIDTH_VECTOR (`STACK_DATA_WIDTH-1):0

`define STACK_PUSH 1'b1
`define STACK_POP  1'b0

`endif