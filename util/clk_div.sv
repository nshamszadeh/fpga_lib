module clk_div #(
    parameter int CLK_DIV = 4,
)(
    input logic clk_in, 
    input logic rst_n,
    output logic clk_out
);
    logic [CLK_DIV-1:0] clk_div_count = '0;
    always_ff @(clk_in) begin
        if (!rst_n) begin
            clk_div_count <= '0;
            clk_out       <= '0;  
        end 
        else begin
            if (clk_div_count == CLK_DIV - 1) begin
                clk_div_count <= '0;
                clk_out <= ~clk_out;
            end
            else begin
                clk_div_count <= clk_div_count + 1;
            end
        end
    end
endmodule