`timescale 1ns/100ps

`include "src/alu/alu.vh"

module test;
    parameter STEP = 10.0;

    reg clk;
    reg en;
    reg in_select;
    reg [`ALU_OPS_WIDTH_VECTOR] op;
    reg [`ALU_DATA_WIDTH_VECTOR] in;
    wire [`ALU_DATA_WIDTH_VECTOR] out;

    alu alu1(
        .clk(clk),
        .en(en),
        .in_select(in_select),
        .op(op),
        .in(in),
        .out(out)
    );

    always #(STEP / 2) begin
        clk <= ~clk;
    end

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0,test);

        clk <= 1'b0;
        en <= `DISABLE;
        in_select <= `ALU_IN_SELECT_I1;
        op <= `ALU_OP_ADD;
        in <= `ALU_DATA_WIDTH'b0;

        #STEP begin
            en <= `ENABLE;
            in <= `ALU_DATA_WIDTH'h33;
        end

        #STEP begin
            in_select <= `ALU_IN_SELECT_I2;
            in <= `ALU_DATA_WIDTH'h11;
        end

        #STEP begin
            en <= `DISABLE;
        end

        #STEP begin
            if (out == 32'h44) begin
                $display("ADD OK");
            end else begin
                $display("ADD Error");
            end
            #1 op <= `ALU_OP_SUB;
        end

        #(STEP - 1) begin
            if (out == 32'h22) begin
                $display("SUB OK");
            end else begin
                $display("SUB Error");
            end
            #1 op <= `ALU_OP_INC;
        end

        #(STEP - 1) begin
            if (out == 32'h34) begin
                $display("INC OK");
            end else begin
                $display("INC Error");
            end
            #1 op <= `ALU_OP_DEC;
        end

        #(STEP - 1) begin
            if (out == 32'h32) begin
                $display("DEC OK");
            end else begin
                $display("DEC Error");
            end
            #1 op <= `ALU_OP_AND;
        end

        #(STEP - 1) begin
            if (out == 32'h11) begin
                $display("AND OK");
            end else begin
                $display("AND Error");
            end
            #1 op <= `ALU_OP_OR;
        end

        #(STEP - 1) begin
            if (out == 32'h33) begin
                $display("OR OK");
            end else begin
                $display("OR Error");
            end
            #1 op <= `ALU_OP_NOT;
        end

        #(STEP - 1) begin
            if (out == 32'hFFFFFFCC) begin
                $display("NOT OK");
            end else begin
                $display("NOT Error");
            end
            #1 op <= `ALU_OP_NEG;
        end

        #(STEP - 1) begin
            if (out == 32'hFFFFFFCD) begin
                $display("NEG OK");
            end else begin
                $display("NEG Error");
            end
        end

        #(STEP - 1) begin
            $finish();
        end

    end

endmodule // test