`timescale 1ns / 1ps
module rom (
    input  [3:0] addr,
    output reg [7:0] instr
);

always @(*) begin
    case (addr)
        4'h0: instr = 8'h12; // LDI 2
        4'h1: instr = 8'h22; // ADD 2
        4'h2: instr = 8'h23; // ADD 3
        4'h3: instr = 8'h70; // JZ 0  (never jumps)
        4'h4: instr = 8'h60; // JMP 0
        default: instr = 8'h00; // NOP
    endcase
end

endmodule
