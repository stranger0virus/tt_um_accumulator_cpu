module tt_um_yourname (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire clk,
    input  wire rst_n
);

    // We don't use the bidirectional pins
    assign uio_out = 8'd0;
    assign uio_oe  = 8'd0;

    tiny_cpu cpu (
        .clk(clk),
        .rst_n(rst_n),
        .ui_in(ui_in),
        .uo_out(uo_out)
    );

endmodule
