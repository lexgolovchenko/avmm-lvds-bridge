
module avmm_lvds_bridge_avm #(
    parameter REQ_FACTOR  = 1,
    parameter RESP_FACTOR = 1,

    parameter BURSTCNT_W = 11,
    parameter ADDR_W     = 19
)(
    input  logic                    clk_i              ,
    input  logic                    rst_i              ,

    // NO BURST Avalon-MM Master
    output logic     [ADDR_W - 1:0] m0_address_o       ,
    output logic              [3:0] m0_byteenable_o    ,
    output logic             [31:0] m0_writedata_o     ,
    input  logic             [31:0] m0_readdata_i      ,
    output logic                    m0_write_o         ,
    output logic                    m0_read_o          ,
    input  logic                    m0_waitrequest_i   ,

    // BURST Avalon-MM Master
    output logic     [ADDR_W - 1:0] m1_address_o       ,
    output logic             [31:0] m1_writedata_o     ,
    input  logic             [31:0] m1_readdata_i      ,
    output logic                    m1_write_o         ,
    output logic                    m1_read_o          ,
    input  logic                    m1_waitrequest_i   ,
    input  logic                    m1_readdatavalid_i ,
    output logic [BURSTCNT_W - 1:0] m1_burstcount_o    ,

    // Receive request packet (from LVDS RX)
    input  logic                          req_clk_i    ,
    input  logic  [32 / REQ_FACTOR - 1:0] req_data_i   ,
    input  logic                          req_valid_i  ,

    // Send response packet (to LVDS TX)
    input  logic                          resp_clk_i   ,
    output logic [32 / RESP_FACTOR - 1:0] resp_data_o  ,
    output logic                          resp_valid_o

);

    logic                    req_rdreq   ;
    logic             [31:0] req_q       ;
    logic                    req_rdempty ;
    logic [BURSTCNT_W - 1:0] req_rdusedw ;

    logic             [31:0] resp_data   ;
    logic                    resp_valid  ;

   avmm_lvds_bridge_avm_if avm_if (
        .clk_i              ,
        .rst_i              ,

        .m0_address_o       ,
        .m0_byteenable_o    ,
        .m0_writedata_o     ,
        .m0_readdata_i      ,
        .m0_write_o         ,
        .m0_read_o          ,
        .m0_waitrequest_i   ,

        .m1_address_o       ,
        .m1_writedata_o     ,
        .m1_readdata_i      ,
        .m1_write_o         ,
        .m1_read_o          ,
        .m1_waitrequest_i   ,
        .m1_readdatavalid_i ,
        .m1_burstcount_o    ,

        .req_rdreq_o        ( req_rdreq   ),
        .req_q_i            ( req_q       ),
        .req_rdempty_i      ( req_rdempty ),
        .req_rdusedw_i      ( req_rdusedw ),

        .resp_data_o        ( resp_data   ),
        .resp_valid_o       ( resp_valid  )
    );

    avmm_lvds_bridge_rx_fifo #(
        .DATA_W ( 32         ),
        .FACTOR ( REQ_FACTOR ),
        .SIZE   ( avmm_lvds_bridge_pkg::MAX_BURST )
    ) req_rx_fifo (
        .wrclk_i   ( req_clk_i   ),
        .data_i    ( req_data_i  ),
        .wrreq_i   ( req_valid_i ),

        .rdclk_i   ( clk_i       ),
        .rdreq_i   ( req_rdreq   ),
        .q_o       ( req_q       ),
        .rdempty_o ( req_rdempty ),
        .rdusedw_o ( req_rdusedw )
    );

    avmm_lvds_bridge_tx_fifo #(
        .DATA_W ( 32          ),
        .FACTOR ( RESP_FACTOR ),
        .SIZE   ( avmm_lvds_bridge_pkg::MAX_BURST )
    ) avmm_lvds_bridge_tx_fifo_inst (
        .wrclk_i ( clk_i      ),
        .data_i  ( resp_data  ),
        .wrreq_i ( resp_valid ),

        .rdclk_i ( resp_clk_i   ),
        .q_o     ( resp_data_o  ),
        .valid_o ( resp_valid_o )
    );

endmodule
