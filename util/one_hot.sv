module one_hot #(
    parameter int N,
    parameter int INVERT
)(
    input  logic [$clog2(N+1)-1:0] in_data,
    output logic [N-1:0]           one_hot_out
);
    genvar i;
    generate
        for (i = 0; i < N; i++) begin
            assign one_hot_out[i] = INVERT ? ((i == in_data) ? 1'b0 : 1'b1)
                                            : ((i == in_data) ? 1'b1 : 1'b0);
        end
    endgenerate
endmodule