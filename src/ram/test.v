`timescale 1ns/100ps

module test;

    reg clk;

    always #5 begin
        clk <= ~clk;
    end

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0,test);

        clk = 0;

        #100 begin
            $finish();
        end
    end

endmodule // test