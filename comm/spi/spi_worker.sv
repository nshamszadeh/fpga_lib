module spi_worker #(
    parameter int DATA_WIDTH = 8
)(
    input  logic                  clk,
    input  logic                  rst_n,

    // SPI bus
    input  logic                  sclk,
    input  logic                  cs_n,
    input  logic                  mosi,
    output logic                  miso,

    // Data interface
    output logic [DATA_WIDTH-1:0] rx_data,
    output logic                  rx_valid,
    input  logic [DATA_WIDTH-1:0] tx_data
);

    // TODO

endmodule