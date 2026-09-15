interface axi_stream_if #(
    parameter int T_DATA_WIDTH = 8
);
    typedef logic [T_DATA_WIDTH-1:0] axis_data_t;
    logic                            tvalid;
    logic                            tready;
    logic                            tlast;
    axis_data_t                      tdata;

    modport tx (input tready, output tvalid, tdata, tlast);
    modport rx (input tvalid, tdata, tlast, output tready);
endinterface

