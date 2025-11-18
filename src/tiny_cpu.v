`timescale 1ns / 1ps
`include "alu.v"
`include "rom.v"

module tiny_cpu (
    input        clk,
    input        rst_n,
    input  [7:0] ui_in,
    output [7:0] uo_out
);

    // Registers
    reg [3:0] pc;
    reg [3:0] acc;

    wire [7:0] instr;
    wire [3:0] opcode = instr[7:4];
    wire [3:0] imm    = instr[3:0];

    wire [3:0] alu_out;

    // Instantiate ROM & ALU
    rom u_rom (.addr(pc), .instr(instr));
    alu u_alu (.acc(acc), .imm(imm), .opcode(opcode), .result(alu_out));

    // Sequential logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pc  <= 4'd0;
            acc <= 4'd0;
        end else begin
            // ACC update
            case (opcode)
                4'h1: acc <= imm;        // LDI
                4'h2: acc <= alu_out;    // ADD
                4'h3: acc <= alu_out;    // SUB
                4'h4: acc <= alu_out;    // AND
                4'h5: acc <= alu_out;    // OR
                default: acc <= acc;
            endcase

            // PC logic
            if (opcode == 4'h6) begin
                pc <= imm;               // JMP
            end else if (opcode == 4'h7 && acc == 4'd0) begin
                pc <= imm;               // JZ
            end else begin
                pc <= pc + 1;
            end
        end
    end

    // Output ACC and PC
    assign uo_out = {pc, acc};

endmodule
