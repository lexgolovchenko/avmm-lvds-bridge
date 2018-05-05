
module avmm_lvds_bridge_avs_avm_tb #(
    parameter SEED = 0
);
    timeunit 1ns;
    timeprecision 1ps;

    parameter T_sclk = 10ns;
    parameter T_mclk = 10ns;
    parameter T_s2m_clk = 10ns;
    parameter T_m2s_clk = 10ns;

    localparam REQ_FACTOR  = 8;
    localparam RESP_FACTOR = 8;

    logic s_clk = 0;
    logic s_rst = 1;
    always  #(T_sclk / 2) s_clk <= ~s_clk;
    initial #(T_sclk * 2) s_rst <= 0;

    logic m_clk = 0;
    logic m_rst = 1;
    always  #(T_mclk / 2) m_clk <= ~m_clk;
    initial #(T_mclk * 2) m_rst <= 0;

    logic s2m_clk = 0;
    always  #(T_s2m_clk / 2) s2m_clk <= ~s2m_clk;

    logic m2s_clk = 0;
    always  #(T_m2s_clk / 2) m2s_clk <= ~m2s_clk;

    import avmm_lvds_bridge_pkg::*;

    // ----------------------------------------------------------------
    // Avalon Master BFM
    // ----------------------------------------------------------------

    logic [ADDR_W - 1:0] s0_address     ;
    logic          [3:0] s0_byteenable  ;
    logic         [31:0] s0_writedata   ;
    logic         [31:0] s0_readdata    ;
    logic                s0_write       ;
    logic                s0_read        ;
    logic                s0_waitrequest ;

    avalon_noburst_master_bfm #(
        .ADDR_W     (ADDR_W),
        .NUMSYMBOLS (4)
    ) noburst_master (
        .clk         ( s_clk ),
        .reset       ( s_rst ),

        .address     ( s0_address     ),
        .byteenable  ( s0_byteenable  ),
        .writedata   ( s0_writedata   ),
        .readdata    ( s0_readdata    ),
        .write       ( s0_write       ),
        .read        ( s0_read        ),
        .waitrequest ( s0_waitrequest )
    );

    logic     [ADDR_W - 1:0] s1_address       ;
    logic             [31:0] s1_writedata     ;
    logic             [31:0] s1_readdata      ;
    logic                    s1_write         ;
    logic                    s1_read          ;
    logic                    s1_waitrequest   ;
    logic [BURSTCNT_W - 1:0] s1_burstcount    ;
    logic                    s1_readdatavalid ;

    avalon_burst_master_bfm #(
        .ADDR_W     (ADDR_W),
        .BURSTCNT_W (BURSTCNT_W)
    ) burst_master (
        .clk           ( s_clk ),
        .reset         ( s_rst ),

        .address       ( s1_address       ),
        .writedata     ( s1_writedata     ),
        .readdata      ( s1_readdata      ),
        .write         ( s1_write         ),
        .read          ( s1_read          ),
        .waitrequest   ( s1_waitrequest   ),
        .burstcount    ( s1_burstcount    ),
        .readdatavalid ( s1_readdatavalid )
    );

    // ----------------------------------------------------------------
    // DUT Avalon Slave interface
    // ----------------------------------------------------------------

    logic  [32 / REQ_FACTOR - 1:0] req_data ;
    logic                          req_valid;

    logic [32 / RESP_FACTOR - 1:0] resp_data;
    logic                          resp_valid;

    avmm_lvds_bridge_avs #(
        .REQ_FACTOR  ( REQ_FACTOR  ),
        .RESP_FACTOR ( RESP_FACTOR )
    ) avs (
        .clk_i              ( s_clk ),
        .rst_i              ( s_rst ),

        .s0_address_i       ( s0_address     ),
        .s0_byteenable_i    ( s0_byteenable  ),
        .s0_writedata_i     ( s0_writedata   ),
        .s0_readdata_o      ( s0_readdata    ),
        .s0_write_i         ( s0_write       ),
        .s0_read_i          ( s0_read        ),
        .s0_waitrequest_o   ( s0_waitrequest ),

        .s1_address_i       ( s1_address       ),
        .s1_writedata_i     ( s1_writedata     ),
        .s1_readdata_o      ( s1_readdata      ),
        .s1_write_i         ( s1_write         ),
        .s1_read_i          ( s1_read          ),
        .s1_waitrequest_o   ( s1_waitrequest   ),
        .s1_burstcount_i    ( s1_burstcount    ),
        .s1_readdatavalid_o ( s1_readdatavalid ),

        .req_clk_i          ( s2m_clk   ),
        .req_data_o         ( req_data  ),
        .req_valid_o        ( req_valid ),

        .resp_clk_i         ( m2s_clk    ),
        .resp_data_i        ( resp_data  ),
        .resp_valid_i       ( resp_valid )
    );

    // ----------------------------------------------------------------
    // DUT Avalon Master interface
    // ----------------------------------------------------------------

    logic     [ADDR_W - 1:0] m0_address     ;
    logic              [3:0] m0_byteenable  ;
    logic             [31:0] m0_writedata   ;
    logic             [31:0] m0_readdata    ;
    logic                    m0_write       ;
    logic                    m0_read        ;
    logic                    m0_waitrequest ;

    logic     [ADDR_W - 1:0] m1_address       ;
    logic             [31:0] m1_writedata     ;
    logic             [31:0] m1_readdata      ;
    logic                    m1_write         ;
    logic                    m1_read          ;
    logic                    m1_waitrequest   ;
    logic                    m1_readdatavalid ;
    logic [BURSTCNT_W - 1:0] m1_burstcount    ;

    avmm_lvds_bridge_avm #(
        .REQ_FACTOR  ( REQ_FACTOR  ),
        .RESP_FACTOR ( RESP_FACTOR )
    ) avm (
        .clk_i              ( m_clk ),
        .rst_i              ( m_rst ),

        .m0_address_o       ( m0_address     ),
        .m0_byteenable_o    ( m0_byteenable  ),
        .m0_writedata_o     ( m0_writedata   ),
        .m0_readdata_i      ( m0_readdata    ),
        .m0_write_o         ( m0_write       ),
        .m0_read_o          ( m0_read        ),
        .m0_waitrequest_i   ( m0_waitrequest ),

        .m1_address_o       ( m1_address       ),
        .m1_writedata_o     ( m1_writedata     ),
        .m1_readdata_i      ( m1_readdata      ),
        .m1_write_o         ( m1_write         ),
        .m1_read_o          ( m1_read          ),
        .m1_waitrequest_i   ( m1_waitrequest   ),
        .m1_readdatavalid_i ( m1_readdatavalid ),
        .m1_burstcount_o    ( m1_burstcount    ),

        .req_clk_i          ( s2m_clk   ),
        .req_data_i         ( req_data  ),
        .req_valid_i        ( req_valid ),

        .resp_clk_i         ( m2s_clk    ),
        .resp_data_o        ( resp_data  ),
        .resp_valid_o       ( resp_valid )
    );

    // ----------------------------------------------------------------
    // Avalon Slave BFM
    // ----------------------------------------------------------------

    avalon_noburst_slave_bfm #(
        .ADDR_W     (ADDR_W),
        .NUMSYMBOLS (4)
    ) noburst_slave (
        .clk           ( m_clk ),
        .reset         ( m_rst ),

        .address       ( m0_address     ),
        .byteenable    ( m0_byteenable  ),
        .readdata      ( m0_readdata    ),
        .writedata     ( m0_writedata   ),
        .write         ( m0_write       ),
        .read          ( m0_read        ),
        .waitrequest   ( m0_waitrequest )
    );

    avalon_burst_slave_bfm #(
        .ADDR_W     (ADDR_W),
        .BURSTCNT_W (BURSTCNT_W)
    ) burst_slave (
        .clk           ( m_clk ),
        .reset         ( m_rst ),

        .address       ( m1_address       ),
        .readdata      ( m1_readdata      ),
        .writedata     ( m1_writedata     ),
        .write         ( m1_write         ),
        .read          ( m1_read          ),
        .waitrequest   ( m1_waitrequest   ),
        .burstcount    ( m1_burstcount    ),
        .readdatavalid ( m1_readdatavalid )
    );

    // ----------------------------------------------------------------
    // BFM API
    // ----------------------------------------------------------------

    // NOBURST master API
    `define MASTER noburst_master.master
    `define MASTER_TP_INST noburst_master_api
    `include "../../tb/avmm_bfm/master_bfm_simple_test_api.svh"
    `undef MASTER
    `undef MASTER_TP_INST

    // BURST master API
    `define MASTER burst_master.master
    `define MASTER_TP_INST burst_master_api
    `include "../../tb/avmm_bfm/master_bfm_simple_test_api.svh"
    `undef MASTER
    `undef MASTER_TP_INST

     // NOBURST slave API
    `define SLAVE noburst_slave.slave
    `define SLAVE_TP_INST noburst_slave_api
    `include "../../tb/avmm_bfm/slave_bfm_simple_test_api.svh"
    `undef SLAVE
    `undef SLAVE_TP_INST

    // BURST slave API
    `define SLAVE burst_slave.slave
    `define SLAVE_TP_INST burst_slave_api
    `include "../../tb/avmm_bfm/slave_bfm_simple_test_api.svh"
    `undef SLAVE
    `undef SLAVE_TP_INST

    // ----------------------------------------------------------------
    // Test program
    // ----------------------------------------------------------------

    `define BURST_API_INST   burst_master_api
    `define NOBURST_API_INST noburst_master_api
    `define CLK s_clk
    `include "../../tb/avmm_lvds_bridge_avs_if_tp.svh"
    `undef BURST_API_INST
    `undef NOBURST_API_INST
    `undef CLK

    initial begin : main
        void'($urandom(SEED));
        $display("\n%m : Start!\n");

        #(10 * T_sclk);

        // Slave bfm without backpressure
        noburst_slave_api.set_backpressure_cycles(0, 0);
        noburst_slave_api.randomize_backpressure = 0;
        noburst_slave_api.const_backpressure = 0;
        burst_slave_api.set_backpressure_cycles(0, 0);
        burst_slave_api.randomize_backpressure = 0;
        burst_slave_api.const_backpressure = 0;
        avs_if_test(50, 0);
        avs_if_test(0, 8);

        // slave bfm with cosnt backpressure
        noburst_slave_api.set_backpressure_cycles(0, 1);
        noburst_slave_api.const_backpressure = 1;
        burst_slave_api.set_backpressure_cycles(0, 1);
        burst_slave_api.const_backpressure = 1;
        avs_if_test(50, 0);
        avs_if_test(0, 8);

        // slave bfm with random backpressure
        noburst_slave_api.set_backpressure_cycles(1);
        noburst_slave_api.randomize_backpressure = 1;
        burst_slave_api.set_backpressure_cycles(1);
        burst_slave_api.randomize_backpressure = 1;
        avs_if_test(50, 0);
        avs_if_test(0, 8);

        $display("\n%m : Finish!\n");
        $finish;
    end

endmodule
