interface axi_stream_if #(
    parameter int DATA_WIDTH = 8
);
    typedef logic [DATA_WIDTH-1:0] axis_data_t;
    logic                            tvalid;
    logic                            tready;
    logic                            tlast;
    axis_data_t                      tdata;

    modport tx (input tready, output tvalid, tdata, tlast);
    modport rx (input tvalid, tdata, tlast, output tready);
endinterface

// optional fifo buffer
module axi_stream_fifo #(
    parameter int DATA_WIDTH = 8, // fifo width
    parameter int FIFO_DEPTH = 8
)(
    input  logic                 clk,
    input  logic                 rst_n,

    axi_stream_if.rx             rx_axis, // upstream   consumer
    axi_stream_if.tx             tx_axis  // downstream producer     
);

    // TODO

endmodule