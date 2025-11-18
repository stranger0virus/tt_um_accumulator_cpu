`timescale 1ns/1ps

module tiny_cpu_tb;

    reg         clk;
    reg         rst_n;
    reg  [7:0]  ui_in;
    wire [7:0]  uo_out;

    // Instantiate the CPU
    tiny_cpu uut (
        .clk(clk),
        .rst_n(rst_n),
        .ui_in(ui_in),
        .uo_out(uo_out)
    );

    // Clock generation: 10ns period = 100MHz
    always #5 clk = ~clk;

    initial begin
        $dumpfile("tiny_cpu_tb.vcd");
        $dumpvars(0, tiny_cpu_tb);

        // Initialize signals
        clk   = 0;
        rst_n = 0;
        ui_in = 8'h00;

        // Hold reset for some cycles
        #20;
        rst_n = 1;

        // Run long enough to execute ROM program
        #400;

        $finish;
    end

endmodule
