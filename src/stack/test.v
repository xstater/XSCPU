`timescale 1ns/100ps

`include "src/stack/stack.vh"

module test;
    parameter STEP = 10;

    reg clk;
    reg en;
    reg reset;
    reg push;
    reg [`STACK_DATA_WIDTH_VECTOR] data_in;
    wire [`STACK_DATA_WIDTH_VECTOR] data_out;

    stack stack1(
        .clk(clk),
        .en(en),
        .reset(reset),
        .push(push),
        .data_in(data_in),
        .data_out(data_out)
    );

    always #(STEP / 2) begin
        clk <= ~clk;
    end

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0,test);

        clk <= 1'b0;
        en <= `ENABLE;
        reset <= `DISABLE;
        push <= `STACK_PUSH;
        data_in <= `STACK_DATA_WIDTH'h11;
        
        #STEP begin
            data_in <= `STACK_DATA_WIDTH'h12;
        end

        #STEP begin
            data_in <= `STACK_DATA_WIDTH'h13;
        end
        
        #STEP begin
            data_in <= `STACK_DATA_WIDTH'h14;
        end

        #STEP begin
            push <= `STACK_POP;
            if (data_out != `STACK_DATA_WIDTH'h14) begin
                $display("Error1");
            end
        end

        #STEP begin
            if (data_out != `STACK_DATA_WIDTH'h13) begin
                $display("Error2");
            end
        end

        #STEP begin
            if (data_out != `STACK_DATA_WIDTH'h12) begin
                $display("Error2");
            end
            en <= `DISABLE;
        end

        #STEP begin
            if (data_out != `STACK_DATA_WIDTH'h12) begin
                $display("Error2");
            end
            en <= `ENABLE;
        end

        #STEP begin
            if (data_out != `STACK_DATA_WIDTH'h11) begin
                $display("Error2");
            end
        end

        #STEP begin
            $display("Done");
            $finish();
        end
    end

endmodule // test