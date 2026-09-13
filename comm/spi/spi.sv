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
    input  logic [$clog2(NUM_WORKERS+1)-1:0] worker_sel,
    


    // SPI bus
    spi_bus_if.controller                    spi_bus
);
    // clock division to generate sclk
    clk_div spi_clk_div #(CLK_DIV) 
    (
        .clk_in(clk),
        .rst_n(rst_n),
        .clk_out(sclk)
    );

    // chip select encoding
    always_comb begin : cs_n_enc
        cs_n = '1;
        
    end : cs_n_enc

endmodule

module spi_worker #(
    parameter int DATA_WIDTH = 8
)(
    input  logic                  rst_n,

    spi_bus_if.worker             spi_bus,

    // Data interface
    output logic [DATA_WIDTH-1:0] rx_data,
    output logic                  rx_valid,
    input  logic [DATA_WIDTH-1:0] tx_data
);
    // TODO
endmodule