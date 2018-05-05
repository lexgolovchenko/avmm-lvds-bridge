
module avmm_lvds_bridge_avs_if_tb #(
    parameter SEED
);
    timeunit 1ns;
    timeprecision 1ps;

    parameter T_clk = 10ns;
    logic clk = 0;
    logic rst = 1;
    always  #(T_clk / 2) clk <= ~clk;
    initial #(T_clk * 2) rst <= 0;

    parameter T_mclk    = 10ns;
    parameter T_s2m_clk = 10ns;
    parameter T_m2s_clk = 10ns;

    logic mclk = '0;
    always #(T_mclk / 2) mclk = ~mclk;

    import avmm_lvds_bridge_pkg::*;
    import protocol_model_pkg::*;

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
        .clk         ( clk ),
        .reset       ( rst ),

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
        .clk           ( clk ),
        .reset         ( rst ),

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
    // Test system
    // ----------------------------------------------------------------
    //                  ----> REQ_CHANNEL  ---->
    // AVALON SLAVE DUT                          AVALON MASTER MODEL
    //                  <---- RESP_CHANNEL <----
    // ----------------------------------------------------------------

    localparam M2S_FACTOR = 8;
    localparam S2M_FACTOR = 8;

    logic             [31:0] s2m_wrdata  ;
    logic                    s2m_wrreq   ;
    logic                    s2m_rdreq   ;
    logic             [31:0] s2m_q       ;
    logic                    s2m_rdempty ;
    logic [BURSTCNT_W - 1:0] s2m_rdusedw ;

    logic             [31:0] m2s_wrdata  ;
    logic                    m2s_wrreq   ;
    logic                    m2s_rdreq   ;
    logic             [31:0] m2s_q       ;
    logic                    m2s_rdempty ;
    logic [BURSTCNT_W - 1:0] m2s_rdusedw ;

    avmm_lvds_bridge_avs_if dut (
        .clk_i              ( clk ),
        .rst_i              ( rst ),

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

        .req_data_o         ( s2m_wrdata  ),
        .req_valid_o        ( s2m_wrreq   ),

        .resp_rdreq_o       ( m2s_rdreq   ),
        .resp_q_i           ( m2s_q       ),
        .resp_rdempty_i     ( m2s_rdempty ),
        .resp_rdusedw_i     ( m2s_rdusedw )
    );

    channel_stub #(
        .FACTOR    ( S2M_FACTOR  ),
        .SIZE      ( MAX_BURST   ),
        .TCLK      ( T_s2m_clk   )
    ) s2m_channel (
        // Slave send request
        .wrclk_i   ( clk         ),
        .data_i    ( s2m_wrdata  ),
        .wrreq_i   ( s2m_wrreq   ),
        // Master receive request
        .rdclk_i   ( mclk        ),
        .rdreq_i   ( s2m_rdreq   ),
        .q_o       ( s2m_q       ),
        .rdempty_o ( s2m_rdempty ),
        .rdusedw_o ( s2m_rdusedw )
    );

    channel_stub #(
        .FACTOR    ( M2S_FACTOR  ),
        .SIZE      ( MAX_BURST   ),
        .TCLK      ( T_m2s_clk   )
    ) m2s_channel (
        // Slave receive responce
        .rdclk_i   ( clk        ),
        .rdreq_i   ( m2s_rdreq   ),
        .q_o       ( m2s_q       ),
        .rdempty_o ( m2s_rdempty ),
        .rdusedw_o ( m2s_rdusedw ),
        // Master send request
        .wrclk_i   ( mclk        ),
        .data_i    ( m2s_wrdata  ),
        .wrreq_i   ( m2s_wrreq   )
    );

    avalon_master_stub #(
        .MAX_BURST      ( MAX_BURST   )
    ) master_stub (
        .clk_i          ( mclk        ),
        // Receive request
        .req_rdreq_o    ( s2m_rdreq   ),
        .req_q_i        ( s2m_q       ),
        .req_rdempty_i  ( s2m_rdempty ),
        .req_rdusedw_i  ( s2m_rdusedw ),
        // Send response
        .resp_data_o    ( m2s_wrdata  ),
        .resp_valid_o   ( m2s_wrreq   )
    );

    // ----------------------------------------------------------------
    // Master BFM API
    // ----------------------------------------------------------------

    // NOBURST master API
    `define MASTER noburst_master.master
    `define MASTER_TP_INST noburst
    `include "../../tb/avmm_bfm/master_bfm_simple_test_api.svh"
    `undef MASTER
    `undef MASTER_TP_INST

    // BURST master API
    `define MASTER burst_master.master
    `define MASTER_TP_INST burst
    `include "../../tb/avmm_bfm/master_bfm_simple_test_api.svh"
    `undef MASTER
    `undef MASTER_TP_INST

    // ----------------------------------------------------------------
    // Test program
    // ----------------------------------------------------------------

    `define BURST_API_INST   burst
    `define NOBURST_API_INST noburst
    `define CLK clk
    `include "../../tb/avmm_lvds_bridge_avs_if_tp.svh"
    `undef BURST_API_INST
    `undef NOBURST_API_INST
    `undef CLK

    initial begin : main
        // master_stub.verbose = 1;
        void'($urandom(SEED));
        $display("\n%m : Start!\n");

        wait(rst == 0);
        tick(10);

        avs_if_test(100, 0);
        avs_if_test(0, 10);

        tick(100);

        $display("\n%m : Finish!\n");

        $finish;
    end

    task tick(int n);
        repeat(n) @(posedge clk);
    endtask

endmodule

