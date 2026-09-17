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

/*
(receive from fpga) axis_rx -> mosi -> external module/device
external module/device -> miso -> axis_tx (transmit to rest of fpga)

IDLE gates on the tx handshake, SHIFT is a free-running bit counter with no stream awareness at all, PRESENT gates on the rx handshake before releasing back to IDLE. The two handshakes never touch each other directly — they're just the entry and exit conditions of the same state machine.

One thing worth knowing but not necessarily acting on yet: IDLE and PRESENT could in principle be merged into one waiting state (checking both handshakes at once) to shave a cycle off back-to-back transfers when the rx consumer is already ready.

IDLE — waiting to start a frame.
    mosi_axis.tready = 1 (ready to accept a tx word).
    cs_n deasserted, no shifting.
    On mosi_axis.tvalid && mosi_axis.tready: latch tdata into the tx shift register, reset the bit counter to 0, assert cs_n for the selected worker, → SHIFT.


SHIFT — the actual bit-banging, purely mechanical.
    mosi_axis.tready = 0 (shift register occupied, can't accept a new word).
    cs_n held asserted.
    Each sclk edge: shift the tx register out on mosi (MSB first), shift miso into the rx register, increment the bit counter.
    When the counter reaches DATA_WIDTH: cs_n deasserts, latch the completed rx shift register into a holding register, → PRESENT.

PRESENT — handing the received word off, gating the next frame.
    miso_axis.tvalid = 1, tdata = the latched rx word.
    mosi_axis.tready stays 0 here too — you can't start the next frame until this word is consumed, since there's no FIFO to hold a second one.
    On miso_axis.tvalid && miso_axis.tready: → IDLE.

*/
module spi_controller #(
    parameter int CLK_DIV     = 4,    // SCLK = clk / CLK_DIV
    parameter int DATA_WIDTH  = 8,    // bits per transfer
    parameter int NUM_WORKERS = 1
)(
    input  logic                             clk,
    input  logic                             rst_n,
    input  logic [$clog2(NUM_WORKERS+1)-1:0] worker_sel,
    // SPI bus
    spi_bus_if.controller                    spi_bus,
    // axi stream bus
    axi_stream_if.tx                         miso_axis,
    axi_stream_if.rx                         mosi_axis
);
    // clock division to generate sclk
    clk_div spi_clk_div #(CLK_DIV) 
    (
        .clk_in(clk),
        .rst_n(rst_n),
        .clk_out(sclk)
    );

    // chip select one-hot encoding
    one_hot #(.N(NUM_WORKERS), .INVERT(1))
    (
        .in_data(worker_sel),
        .one_hot_out(cs_n)
    );


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
