`timescale 1ns/100ps

`include "src/alu/alu.vh"

module test;
    parameter STEP = 1.0;

    reg clk;
    reg [`ALU_OPS_WIDTH_VECTOR] op;
    reg [`ALU_INPUT_WIDTH_VECTOR] i1;
    reg [`ALU_INPUT_WIDTH_VECTOR] i2;
    wire [`ALU_OUTPUT_WIDTH_VECTOR] o;

    alu alu1(
        .op(op),
        .i1(i1),
        .i2(i2),
        .o(o)
    );

    always #(STEP / 2) begin
        clk <= ~clk;
    end

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0,test);

        #0 begin
            clk <= 0;
            op <= `ALU_OP_ADD;
            i1 <= 32'h33;
            i2 <= 32'h11;
        end

        #STEP begin
            if (o == 32'h44) begin
                $display("ADD OK");
            end else begin
                $display("ADD Error");
            end
            #1 op <= `ALU_OP_SUB;
        end

        #STEP begin
            if (o == 32'h22) begin
                $display("SUB OK");
            end else begin
                $display("SUB Error");
            end
            #1 op <= `ALU_OP_INC;
        end

        #STEP begin
            if (o == 32'h34) begin
                $display("INC OK");
            end else begin
                $display("INC Error");
            end
            #1 op <= `ALU_OP_DEC;
        end

        #STEP begin
            if (o == 32'h32) begin
                $display("DEC OK");
            end else begin
                $display("DEC Error");
            end
            #1 op <= `ALU_OP_AND;
        end

        #STEP begin
            if (o == 32'h11) begin
                $display("AND OK");
            end else begin
                $display("AND Error");
            end
            #1 op <= `ALU_OP_OR;
        end

        #STEP begin
            if (o == 32'h33) begin
                $display("OR OK");
            end else begin
                $display("OR Error");
            end
            #1 op <= `ALU_OP_NOT;
        end

        #STEP begin
            if (o == 32'hFFFFFFCC) begin
                $display("NOT OK");
            end else begin
                $display("NOT Error");
            end
            #1 op <= `ALU_OP_NEG;
        end

        #STEP begin
            if (o == 32'hFFFFFFCD) begin
                $display("NEG OK");
            end else begin
                $display("NEG Error");
            end
        end

        #STEP begin
            $finish();
        end

    end
endmodule // test