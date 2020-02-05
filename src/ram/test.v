`timescale 1ns/100ps

`include "src/ram/ram.vh"


module test;
    reg clk;
    reg en;
    reg wr;
    reg reset;
    reg  [`RAM_ADDR_WIDTH_VECTOR] addr;
    reg  [`RAM_DATA_WIDTH_VECTOR] data_in;
    wire [`RAM_DATA_WIDTH_VECTOR] data_out;

    parameter STEP = 10.00;

    ram ram1(
        .clk(clk),
        .en(en),
        .wr(wr),
        .reset(reset),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out)
    );

    always #(STEP / 2) begin
        clk <= ~clk;
    end

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0,test);

        #0 begin
            clk <= 1'b0;
            en <= `DISABLE;
            wr <= `RAM_READ;
            reset <= `DISABLE;
            addr <= 8'd2;
            data_in <= 32'b0;
        end

        #STEP begin //the 1st clk negedge
            en <= `ENABLE;
            wr <= `RAM_WRITE;
            data_in <= 32'h3f;
        end

        #STEP begin //the 2nd clk negedge
            wr <= `RAM_READ;

            if (data_out == 32'h3f) begin
                $display("Load & Store OK");
            end else begin
                $display("Load & Store Failed");
            end
        end

        #STEP begin //the 3rd clk negedge
            reset <= `ENABLE;
        end

        #STEP begin //the 4th clk negedge
            if (data_out == 32'h0) begin
                $display("reset OK");
            end else begin
                $display("reset Failed");
            end
        end

        #STEP begin //the 5th clk negedge
            reset <= `DISABLE;
            en <= `DISABLE;
        end

        #(STEP * 2) begin
            $finish();
        end
    end

endmodule // test