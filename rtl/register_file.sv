/* Copyright (c) 2024 Tobias Scheipel, David Beikircher, Florian Riedl
 * Embedded Architectures & Systems Group, Graz University of Technology
 * SPDX-License-Identifier: MIT
 * ---------------------------------------------------------------------
 * File: register_file.sv
 */



module register_file (
    input logic clk,
    input logic rst,
    // read ports
    input  logic [4:0]  read_address1,
    output logic [31:0] read_data1,
    input  logic [4:0]  read_address2,
    output logic [31:0] read_data2,
    // write port
    input  logic [4:0]  write_address,
    input  logic [31:0] write_data,
    input  logic        write_enable
);

    logic [31:0] registers [31:0];

    // Asynchronous reads — x0 always returns 0
    always_comb begin
        read_data1 = (read_address1 == 5'b0) ? 32'b0 : registers[read_address1];
        read_data2 = (read_address2 == 5'b0) ? 32'b0 : registers[read_address2];
    end

    // Synchronous write — never write to x0
    always_ff @(posedge clk) begin
        if (write_enable && write_address != 5'b0) begin
            registers[write_address] <= write_data;
        end
    end

endmodule
