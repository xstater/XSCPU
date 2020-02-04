`ifndef _RAM_VH_
`define _RAM_VH_

`include "src/defs.vh"

`define RAM_SIZE 128
`define RAM_SIZE_VECTOR (`RAM_SIZE-1):0
`define RAM_ADDR_WIDTH 8
`define RAM_ADDR_WIDTH_VECTOR (`RAM_ADDR_WIDTH-1):0
`define RAM_DATA_WIDTH 32
`define RAM_DATA_WIDTH_VECTOR (`RAM_DATA_WIDTH-1):0

`define RAM_WRITE 1'b1
`define RAM_READ  1'b0

`endif