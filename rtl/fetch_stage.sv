/* Copyright (c) 2024 Tobias Scheipel, David Beikircher, Florian Riedl
 * Embedded Architectures & Systems Group, Graz University of Technology
 * SPDX-License-Identifier: MIT
 * ---------------------------------------------------------------------
 * File: fetch_stage.sv
 */



module fetch_stage (
    input logic clk,
    input logic rst,

    // Memory interface
    wishbone_interface.master wb,

    //  Output data
    output logic [31:0] instruction_reg_out,
    output logic [31:0] program_counter_reg_out,

    // Pipeline control
    output pipeline_status::forwards_t  status_forwards_out,
    input  pipeline_status::backwards_t status_backwards_in,
    input  logic [31:0] jump_address_backwards_in
);

    // Internal PC: byte address of the instruction currently being fetched
    logic [31:0] pc;

    // ── Wishbone: always drive a read request for the current pc ──────
    always_comb begin
        wb.cyc      = 1'b1;
        wb.stb      = 1'b1;
        wb.adr      = pc >> 2;  // wishbone uses word addresses
        wb.sel      = 4'b1111;  // full 32-bit word
        wb.we       = 1'b0;     // always a read
        wb.dat_mosi = '0;
    end

    // ── Sequential logic ──────────────────────────────────────────────
    always_ff @(posedge clk) begin
        if (rst) begin
            pc                      <= constants::RESET_ADDRESS;
            instruction_reg_out     <= constants::NOP;
            program_counter_reg_out <= constants::RESET_ADDRESS;
            status_forwards_out     <= pipeline_status::BUBBLE;
        end else begin
            case (status_backwards_in)

                pipeline_status::STALL: begin
                    // Downstream is busy — hold all output registers
                    // and do not advance pc (re-fetch same address next cycle)
                end

                pipeline_status::JUMP: begin
                    // Redirect pc, output a bubble so decode ignores this cycle
                    pc                  <= jump_address_backwards_in;
                    status_forwards_out <= pipeline_status::BUBBLE;
                end

                pipeline_status::READY: begin
                    // Downstream ready — capture wishbone result
                    if (wb.ack) begin
                        instruction_reg_out     <= wb.dat_miso;
                        program_counter_reg_out <= pc;
                        status_forwards_out     <= pipeline_status::VALID;
                        pc                      <= pc + 32'd4;
                    end else if (wb.err) begin
                        // Memory error — report FETCH_FAULT, still advance pc
                        program_counter_reg_out <= pc;
                        status_forwards_out     <= pipeline_status::FETCH_FAULT;
                        pc                      <= pc + 32'd4;
                    end
                end

                default: begin
                    status_forwards_out <= pipeline_status::BUBBLE;
                end

            endcase
        end
    end

endmodule
