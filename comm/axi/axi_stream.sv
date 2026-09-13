interface axi_stream_if #(
    parameter int T_DATA_WIDTH = 8
);
    logic                    tvalid;
    logic                    tready;
    logic                    tlast;
    logic [T_DATA_WIDTH-1:0] tdata;

    modport tx (input tready, output tvalid, tdata, tlast);
    modport rx (input tvalid, tdata, tlast, output tready);
endinterface

module axi_stream_tx #(
    parameter int DATA_WIDTH = 8
)(
    input logic clk,
    input logic rst_n,
    axi_stream_if.tx axi_s_bus
);
// TODO
endmodule

module axi_stream_rx #(
    parameter int DATA_WIDTH = 8
)(
    input logic clk,
    input logic rst_n,
    axi_stream_if.rx axi_s_bus
);
// TODO
endmodule

