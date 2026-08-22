module spi_controller #(
    parameter int CLK_DIV   = 4,    // SCLK = clk / CLK_DIV
    parameter int DATA_WIDTH = 8    // bits per transfer
)(
    input  logic                  clk,
    input  logic                  rst_n,

    // Control interface
    input  logic                  start,
    output logic                  busy,

    // Data interface
    input  logic [DATA_WIDTH-1:0] tx_data,
    output logic [DATA_WIDTH-1:0] rx_data,
    output logic                  rx_valid,

    // SPI bus
    output logic                  sclk,
    output logic                  cs_n,
    output logic                  mosi,
    input  logic                  miso
);

    // TODO

endmodule