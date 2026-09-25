module clk_div #(
    parameter int CLK_DIV = 4
)(
    input  logic clk_in, 
    input  logic rst_n,
    output logic clk_out,
    output logic clk_tick_out
);
    logic [$clog2(CLK_DIV+1)-1:0] clk_div_count = '0;
    always_ff @(posedge clk_in) begin
        if (!rst_n) begin
            clk_div_count <=   '0;
            clk_out       <= 1'b0;
            clk_tick_out  <= 1'b0;  
        end 
        else begin
            if (clk_div_count == (CLK_DIV+1)/2 - 1) begin
                clk_out       <= ~clk_out;
                clk_tick_out  <= clk_in;
            end
            else begin
                clk_div_count <= clk_div_count + 1; // should 0 automatically
                clk_tick_out  <= 1'b0;
            end
        end
    end
endmodule