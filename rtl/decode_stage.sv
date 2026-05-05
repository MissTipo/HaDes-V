/* Copyright (c) 2024 Tobias Scheipel, David Beikircher, Florian Riedl
 * Embedded Architectures & Systems Group, Graz University of Technology
 * SPDX-License-Identifier: MIT
 * ---------------------------------------------------------------------
 * File: decode_stage.sv
 */



module decode_stage (
    input logic clk,
    input logic rst,

    // Inputs
    input logic [31:0]  instruction_in,
    input logic [31:0]  program_counter_in,
    input forwarding::t exe_forwarding_in,
    input forwarding::t mem_forwarding_in,
    input forwarding::t wb_forwarding_in,

    // Output Registers
    output logic [31:0]   rs1_data_reg_out,
    output logic [31:0]   rs2_data_reg_out,
    output logic [31:0]   program_counter_reg_out,
    output instruction::t instruction_reg_out,

    // Pipeline control
    input  pipeline_status::forwards_t  status_forwards_in,
    output pipeline_status::forwards_t  status_forwards_out,
    input  pipeline_status::backwards_t status_backwards_in,
    output pipeline_status::backwards_t status_backwards_out,
    input  logic [31:0] jump_address_backwards_in,
    output logic [31:0] jump_address_backwards_out
);

    // ── Instruction Decoder ───────────────────────────────────────────
    instruction::t decoded_instruction;

    instruction_decoder decoder (
        .instruction_in  (instruction_in),
        .instruction_out (decoded_instruction)
    );

    // ── Register File ─────────────────────────────────────────────────
    // wb_forwarding_in drives the write port — writeback logically owns
    // the register file but the physical write port lives here
    logic [31:0] reg_read_data1, reg_read_data2;

    register_file regfile (
        .clk           (clk),
        .rst           (rst),
        .read_address1 (decoded_instruction.rs1_address),
        .read_data1    (reg_read_data1),
        .read_address2 (decoded_instruction.rs2_address),
        .read_data2    (reg_read_data2),
        .write_address (wb_forwarding_in.address),
        .write_data    (wb_forwarding_in.data),
        .write_enable  (wb_forwarding_in.data_valid)
    );

    // ── Forwarding Unit ───────────────────────────────────────────────
    // Priority: exe (most recent) > mem > wb
    // Stall if a matching forwarding source has data_valid = 0
    logic [31:0] rs1_data, rs2_data;
    logic needs_stall;

    always_comb begin
        rs1_data    = reg_read_data1;
        rs2_data    = reg_read_data2;
        needs_stall = 1'b0;

        // RS1
        if (decoded_instruction.rs1_address == 5'b0) begin
            rs1_data = 32'b0;
        end else if (exe_forwarding_in.address != 5'b0 &&
                    exe_forwarding_in.address == decoded_instruction.rs1_address) begin
            if (exe_forwarding_in.data_valid) rs1_data = exe_forwarding_in.data;
            else needs_stall = 1'b1;
        end else if (mem_forwarding_in.address != 5'b0 &&
                    mem_forwarding_in.address == decoded_instruction.rs1_address) begin
            if (mem_forwarding_in.data_valid) rs1_data = mem_forwarding_in.data;
            else needs_stall = 1'b1;
        end else if (wb_forwarding_in.address != 5'b0 &&
                    wb_forwarding_in.address == decoded_instruction.rs1_address) begin
            if (wb_forwarding_in.data_valid) rs1_data = wb_forwarding_in.data;
            else needs_stall = 1'b1;
        end

        // RS2
        if (decoded_instruction.rs2_address == 5'b0) begin
            rs2_data = 32'b0;
        end else if (exe_forwarding_in.address != 5'b0 &&
                    exe_forwarding_in.address == decoded_instruction.rs2_address) begin
            if (exe_forwarding_in.data_valid) rs2_data = exe_forwarding_in.data;
            else needs_stall = 1'b1;
        end else if (mem_forwarding_in.address != 5'b0 &&
                    mem_forwarding_in.address == decoded_instruction.rs2_address) begin
            if (mem_forwarding_in.data_valid) rs2_data = mem_forwarding_in.data;
            else needs_stall = 1'b1;
        end else if (wb_forwarding_in.address != 5'b0 &&
                    wb_forwarding_in.address == decoded_instruction.rs2_address) begin
            if (wb_forwarding_in.data_valid) rs2_data = wb_forwarding_in.data;
            else needs_stall = 1'b1;
        end
    end
    // ── Backwards Pass-through (combinatorial) ────────────────────────
    // Later stage STALL takes precedence over decode's own stall
    always_comb begin
        jump_address_backwards_out = jump_address_backwards_in;

        if (status_backwards_in == pipeline_status::STALL) begin
            // Execute is busy — propagate stall to fetch regardless
            status_backwards_out = pipeline_status::STALL;
        end else if (needs_stall && status_forwards_in == pipeline_status::VALID) begin
            // Forwarding data not ready — stall fetch
            status_backwards_out = pipeline_status::STALL;
        end else begin
            // Pass READY or JUMP through from execute
            status_backwards_out = status_backwards_in;
        end
    end

    // ── Sequential Output Registers ───────────────────────────────────
    always_ff @(posedge clk) begin
        if (rst) begin
            status_forwards_out     <= pipeline_status::BUBBLE;
            instruction_reg_out     <= instruction::NOP;
            program_counter_reg_out <= '0;
            rs1_data_reg_out        <= '0;
            rs2_data_reg_out        <= '0;
        end else begin
            case (status_backwards_in)
                pipeline_status::STALL: begin
                    // Execute busy — hold all outputs unchanged
                end

                pipeline_status::JUMP: begin
                    // Flush decode's in-flight instruction
                    status_forwards_out <= pipeline_status::BUBBLE;
                end

                pipeline_status::READY: begin
                    if (needs_stall && status_forwards_in == pipeline_status::VALID) begin
                        // Forwarding stall — send bubble to execute this cycle,
                        // fetch is held so same instruction re-arrives next cycle
                        status_forwards_out <= pipeline_status::BUBBLE;
                    end else begin
                        // Normal — latch decoded outputs
                        status_forwards_out     <= status_forwards_in;
                        instruction_reg_out     <= decoded_instruction;
                        program_counter_reg_out <= program_counter_in;
                        rs1_data_reg_out        <= rs1_data;
                        rs2_data_reg_out        <= rs2_data;
                    end
                end

                default: begin
                    status_forwards_out <= pipeline_status::BUBBLE;
                end
            endcase
        end
    end

endmodule
