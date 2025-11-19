`timescale 1ns/1ps

module tiny_cpu_tb;

    reg         clk;
    reg         rst_n;
    reg  [7:0]  ui_in;
    reg  [7:0]  uio_in;
    wire [7:0]  uo_out;

    tiny_cpu uut (
        .clk(clk),
        .rst_n(rst_n),
        .ui_in(ui_in),
        .uo_out(uo_out),
	.uio_in(uio_in)
    );

    always #5 clk = ~clk;

    initial begin


    $monitor("Time=%0t | Input = %b | Sel = %b | Output = %b |  | Imm = %b", $time, ui_in, uio_in, uo_out, uut.imm);
    
	clk   = 0;
    rst_n = 0;
    ui_in = 8'h00;
	uio_in = 8'h00;

    #10 rst_n = 1;
	#5;
	
	ui_in = 8'b00100001;
	uio_in = 8'b00000000;
	#10;

	ui_in = 8'b00110001;
	uio_in = 8'b00000000;
	#10;

    ui_in = 8'b01000010;
    uio_in = 8'b00000000;
    #10;

    ui_in = 8'b01010010;
    uio_in = 8'b00000000;
    #10;

	ui_in = 8'b00100001;
	uio_in = 8'b00000001;
	#300;
        
        $finish;
    end

endmodule
