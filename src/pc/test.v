`timescale 1ns/100ps

`include "src/pc/pc.vh"

module test;
    parameter STEP = 10;

    reg clk;
    reg en;
    reg jmp;
    reg reset;
    reg [`PC_ADDR_WIDTH_VECTOR] addr_in;
    wire [`PC_ADDR_WIDTH_VECTOR] addr_out;

    pc pc1(
        .clk(clk),
        .en(en),
        .jmp(jmp),
        .reset(reset),
        .addr_in(addr_in),
        .addr_out(addr_out)
    );

    always #(STEP / 2) begin
        clk <= ~clk;
    end

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0,test);

        #0 begin
            clk <= 1'b0;
            en <= `ENABLE;
            jmp <= `DISABLE;
            reset <= `DISABLE;
            addr_in <= 32'b0;
        end

        #(STEP * 10) begin
            if (addr_out == 32'd10) begin
                $display("PC INC OK");
            end else begin
                $display("PC INC ERROR");
            end
            en <= `DISABLE;
        end

        #(STEP * 10) begin
            if (addr_out == 32'd10) begin
                $display("PC EN OK");
            end else begin
                $display("PC EN ERROR");
            end
            en <= `ENABLE;
            addr_in <= 32'h33;
            jmp <= `ENABLE;
        end

        #STEP begin
            if (addr_out == 32'h33) begin
                $display("PC JMP OK");
            end else begin
                $display("PC JMP ERROR");
            end
            jmp <= `DISABLE;
        end

        #STEP begin
            reset <= `ENABLE;
            #1 begin
                if (addr_out == 32'h0) begin
                    $display("PC RESET OK");
                end else begin
                    $display("PC RESET ERROR");
                end
            end
        end
        
        #STEP $finish();

    end

endmodule // test