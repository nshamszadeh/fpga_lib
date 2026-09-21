`define LEFT  0
`define RIGHT 1

module shift_reg_in #(
    parameter int DATA_WIDTH = 8,
    parameter int DIR        = `LEFT
)(
    input logic clk,
    input logic rst_n,
    input logic en,
    input logic data,
    output logic [DATA_WIDTH-1:0] out_reg
);
    generate
        case (DIR)
            `LEFT: begin
                always_ff @(posedge clk) begin
                    if (rst_n) out_reg <= '0;
                    else begin
                        if (en) begin
                            // shift left
                        end
                    end
                end
            end
            `RIGHT: begin
                always_ff @(posedge clk) begin
                    if (rst_n) out_reg <= '0;
                    else begin
                        if (en) begin
                            // shift right
                        end
                    end
                end
            end

        endcase
    endgenerate
endmodule