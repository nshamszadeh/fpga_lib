import util_pkg::shift_dir_t;

module shift_reg_in #(
    parameter int         DATA_WIDTH = 8,
    parameter shift_dir_t DIR        = LEFT
)(
    input  logic                  clk,
    input  logic                  rst_n,
    input  logic                  en,
    input  logic                  data_s_in,
    output logic [DATA_WIDTH-1:0] data_reg_out
);
    generate
        case (DIR)
            LEFT: begin
                always_ff @(posedge clk) begin
                    if (!rst_n)  data_reg_out <= '0;
                    else if (en) data_reg_out <= {data_reg_out[DATA_WIDTH-2:0], data_s_in};
                end
            end
            RIGHT: begin
                always_ff @(posedge clk) begin
                    if (!rst_n)  data_reg_out <= '0;
                    else if (en) data_reg_out <= {data_s_in, data_reg_out[DATA_WIDTH-1:1]};
                end
            end
        endcase
    endgenerate
endmodule

module shift_reg_out #(
    parameter int         DATA_WIDTH  = 8,
    parameter shift_dir_t DIR         = LEFT
)(
    input  logic                  clk,
    input  logic                  rst_n,
    input  logic                  en,
    input  logic [DATA_WIDTH-1:0] data_reg_in,
    output logic                  data_s_out
);
    logic [DATA_WIDTH-1:0] shift_reg;

    generate
        case (DIR)
            LEFT: begin
                assign data_s_out = shift_reg[DATA_WIDTH-1];
                always_ff @(posedge clk ) begin
                    if (!rst_n)    shift_reg <= '0;
                    else if (load) shift_reg <= data_reg_in;
                    else if (en)   shift_reg <= {shift_reg[DATA_WIDTH-2:0], 1'b0};
                end
            end
            RIGHT: begin
                assign data_s_out = shift_reg[0];
                always_ff @(posedge clk) begin
                   if (!rst_n)    shift_reg <= '0;
                   else if (load) shift_reg <= data_reg_in;
                   else if (en)   shift_reg <= {1'b0, shift_reg[DATA_WIDTH-1:1]}; 
                end
            end
        endcase
    endgenerate
endmodule