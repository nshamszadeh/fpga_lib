interface spi_bus_if #(
    parameter int NUM_WORKERS = 1
);
    logic                   sclk;
    logic [NUM_WORKERS-1:0] cs_n;
    logic                   mosi;
    logic                   miso;

    modport controller   (input miso, output sclk, cs_n, mosi);
    modport worker       (input sclk, cs_n, mosi, output miso);
endinterface;

module spi_controller #(
    parameter int CLK_DIV     = 4,    // SCLK = clk / CLK_DIV
    parameter int DATA_WIDTH  = 8,    // bits per transfer
    parameter int NUM_WORKERS = 1
)(
    input  logic                             clk,
    input  logic                             rst_n,

    // Control interface
    input  logic                             start,
    input  logic [$clog2(NUM_WORKERS+1)-1:0] worker_sel,
    output logic                             busy,

    // Data interface
    input  logic [DATA_WIDTH-1:0]            tx_data,
    output logic [DATA_WIDTH-1:0]            rx_data,
    output logic                             rx_valid,

    // SPI bus
    spi_bus_if.controller                    spi_bus
);

    // clock divider for sclk
    logic [$clog2(CLK_DIV)-1:0] clk_div_count;
    always_ff @(posedge clk) begin : sclk_generator
        if (!rst_n) begin
            clk_div_count <= '0;
            sclk          <= '0;
        end 
        else begin
            if (clk_div_count == CLK_DIV - 1) begin
                clk_div_count <= '0;
                sclk          <= ~sclk;
            end
            else begin
                clk_div_count <= clk_div_count + 1;
            end
        end 
    end : sclk_generator

    // chip select encoding
    always_comb begin : cs_n_enc
        cs_n = '1;
        
    end : cs_n_enc

endmodule