import util_pkg::shift_dir_t;

module shift_reg_in #(
    parameter int         DATA_WIDTH = 8,
    parameter shift_dir_t DIR        = LEFT
)(
    input logic clk,
    input logic rst_n,
    input logic en,
    input logic data,
    output logic [DATA_WIDTH-1:0] out_reg
);
    generate
        case (DIR)
            LEFT: begin
                always_ff @(posedge clk) begin
                    if (!rst_n) out_reg <= '0;
                    else if (en) out_reg <= {out_reg[DATA_WIDTH-2:0], data};
                end
            end
            RIGHT: begin
                always_ff @(posedge clk) begin
                    if (rst_n) out_reg <= '0;
                    else if (en) out_reg <= {data, out_reg[DATA_WIDTH-1:1]};
                end
            end
        endcase
    endgenerate
endmodule

module shift_reg_out #(
    parameter int DATA_WIDTH  = 8,
    parameter shift_dir_t DIR = LEFT
)(
    input  logic                  clk,
    input  logic                  rst_n,
    input  logic                  en,
    input  logic [DATA_WIDTH-1:0] data_reg,
    output logic                  out_data
);

endmodule