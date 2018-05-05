
module channel_stub #(
    parameter FACTOR = 1,
    parameter SIZE   = 1024,
    parameter TCLK   = 10ns
)(
    input                   wrclk_i   ,
    input            [31:0] data_i    ,
    input                   wrreq_i   ,

    input                   rdclk_i   ,
    input                   rdreq_i   ,
    output           [31:0] q_o       ,
    output                  rdempty_o ,
    output [$clog2(SIZE):0] rdusedw_o
);
    timeunit 1ns;
    timeprecision 1ps;

    localparam DATA_W = 32;

    logic chclk = '0;
    always #(TCLK / 2) chclk = ~chclk;

    logic [DATA_W / FACTOR - 1:0] chdata;
    logic chvalid;

    avmm_lvds_bridge_tx_fifo #(
        .DATA_W (DATA_W),
        .FACTOR (FACTOR),
        .SIZE   (SIZE)
    ) tx_fifo (
        .wrclk_i ,
        .data_i  ,
        .wrreq_i ,

        .rdclk_i (chclk),
        .q_o     (chdata),
        .valid_o (chvalid)
    );

    avmm_lvds_bridge_rx_fifo #(
        .DATA_W (DATA_W),
        .FACTOR (FACTOR),
        .SIZE   (SIZE)
    ) rx_fifo (
        .wrclk_i  (chclk),
        .data_i   (chdata),
        .wrreq_i  (chvalid),

        .rdclk_i   ,
        .rdreq_i   ,
        .q_o       ,
        .rdempty_o ,
        .rdusedw_o
    );

endmodule
