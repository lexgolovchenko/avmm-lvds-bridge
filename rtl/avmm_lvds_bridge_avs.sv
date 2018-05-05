
module avmm_lvds_bridge_avs #(
    parameter REQ_FACTOR  = 1,
    parameter RESP_FACTOR = 1,

    parameter BURSTCNT_W = 11,
    parameter ADDR_W     = 19
)(
    input  logic                    clk_i              ,
    input  logic                    rst_i              ,

    // NOBURST Avalon-MM Slave
    input  logic     [ADDR_W - 1:0] s0_address_i       ,
    input  logic              [3:0] s0_byteenable_i    ,
    input  logic             [31:0] s0_writedata_i     ,
    output logic             [31:0] s0_readdata_o      ,
    input  logic                    s0_write_i         ,
    input  logic                    s0_read_i          ,
    output logic                    s0_waitrequest_o   ,

    // BURST Avalon-MM Slave
    input  logic     [ADDR_W - 1:0] s1_address_i       ,
    input  logic             [31:0] s1_writedata_i     ,
    output logic             [31:0] s1_readdata_o      ,
    input  logic                    s1_write_i         ,
    input  logic                    s1_read_i          ,
    output logic                    s1_waitrequest_o   ,
    output logic                    s1_readdatavalid_o ,
    input  logic [BURSTCNT_W - 1:0] s1_burstcount_i    ,

    // Send request packet (to LVDS TX)
    input  logic                          req_clk_i    ,
    output logic  [32 / REQ_FACTOR - 1:0] req_data_o   ,
    output logic                          req_valid_o  ,

    // Receive response packet (from LVDS RX)
    input  logic                          resp_clk_i   ,
    input  logic [32 / RESP_FACTOR - 1:0] resp_data_i  ,
    input  logic                          resp_valid_i
);

    logic             [31:0] req_data     ;
    logic                    req_valid    ;

    logic                    resp_rdreq   ;
    logic             [31:0] resp_q       ;
    logic                    resp_rdempty ;
    logic [BURSTCNT_W - 1:0] resp_rdusedw ;

    avmm_lvds_bridge_avs_if avs_if (
        .clk_i              ,
        .rst_i              ,

        .s0_address_i       ,
        .s0_byteenable_i    ,
        .s0_writedata_i     ,
        .s0_readdata_o      ,
        .s0_write_i         ,
        .s0_read_i          ,
        .s0_waitrequest_o   ,

        .s1_address_i       ,
        .s1_writedata_i     ,
        .s1_readdata_o      ,
        .s1_write_i         ,
        .s1_read_i          ,
        .s1_waitrequest_o   ,
        .s1_readdatavalid_o ,
        .s1_burstcount_i    ,

        .req_data_o         ( req_data     ),
        .req_valid_o        ( req_valid    ),

        .resp_rdreq_o       ( resp_rdreq   ),
        .resp_q_i           ( resp_q       ),
        .resp_rdempty_i     ( resp_rdempty ),
        .resp_rdusedw_i     ( resp_rdusedw )
    );

    avmm_lvds_bridge_tx_fifo #(
        .DATA_W ( 32        ),
        .FACTOR ( REQ_FACTOR ),
        .SIZE   ( avmm_lvds_bridge_pkg::MAX_BURST )
    ) req_tx_fifo (
        .wrclk_i ( clk_i     ),
        .data_i  ( req_data  ),
        .wrreq_i ( req_valid ),

        .rdclk_i ( req_clk_i   ),
        .q_o     ( req_data_o  ),
        .valid_o ( req_valid_o )
    );

    avmm_lvds_bridge_rx_fifo #(
        .DATA_W ( 32          ),
        .FACTOR ( RESP_FACTOR ),
        .SIZE   ( avmm_lvds_bridge_pkg::MAX_BURST   )
    ) resp_rx_fifo (
        .wrclk_i   ( resp_clk_i   ),
        .data_i    ( resp_data_i  ),
        .wrreq_i   ( resp_valid_i ),

        .rdclk_i   ( clk_i        ),
        .rdreq_i   ( resp_rdreq   ),
        .q_o       ( resp_q       ),
        .rdempty_o ( resp_rdempty ),
        .rdusedw_o ( resp_rdusedw )
    );

endmodule
