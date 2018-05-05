
module protocol_model_tb #(
    parameter SEED = 0
);
    timeunit 1ns;
    timeprecision 1ps;

    parameter T_sclk    = 10ns;
    parameter T_mclk    = 10ns;
    parameter T_s2m_clk = 10ns;
    parameter T_m2s_clk = 10ns;

    logic sclk = '0;
    logic mclk = '0;
    always #(T_sclk / 2) sclk = ~sclk;
    always #(T_mclk / 2) mclk = ~mclk;

    // ----------------------------------------------------------------
    // Test system
    // ----------------------------------------------------------------
    //              ----> REQ_CHANNEL  ---->
    // AVALON SLAVE                          AVALON MASTER
    //              <---- RESP_CHANNEL <----
    // ----------------------------------------------------------------

    localparam MAX_BURST  = avmm_lvds_bridge_pkg::MAX_BURST;
    localparam M2S_FACTOR = 1;
    localparam S2M_FACTOR = 1;


    logic                [31:0] s2m_wrdata  ;
    logic                       s2m_wrreq   ;
    logic                       s2m_rdreq   ;
    logic                [31:0] s2m_q       ;
    logic                       s2m_rdempty ;
    logic [$clog2(MAX_BURST):0] s2m_rdusedw ;


    channel_stub #(
        .FACTOR    ( S2M_FACTOR  ),
        .SIZE      ( MAX_BURST   ),
        .TCLK      ( T_s2m_clk   )
    ) s2m_channel (
        // Slave tx
        .wrclk_i   ( sclk        ),
        .data_i    ( s2m_wrdata  ),
        .wrreq_i   ( s2m_wrreq   ),
        // Master rx
        .rdclk_i   ( mclk        ),
        .rdreq_i   ( s2m_rdreq   ),
        .q_o       ( s2m_q       ),
        .rdempty_o ( s2m_rdempty ),
        .rdusedw_o ( s2m_rdusedw )
    );


    logic                [31:0] m2s_wrdata  ;
    logic                       m2s_wrreq   ;
    logic                       m2s_rdreq   ;
    logic                [31:0] m2s_q       ;
    logic                       m2s_rdempty ;
    logic [$clog2(MAX_BURST):0] m2s_rdusedw ;


    channel_stub #(
        .FACTOR    ( M2S_FACTOR  ),
        .SIZE      ( MAX_BURST   ),
        .TCLK      ( T_m2s_clk   )
    ) m2s_channel (
        // Slave rx
        .rdclk_i   ( sclk        ),
        .rdreq_i   ( m2s_rdreq   ),
        .q_o       ( m2s_q       ),
        .rdempty_o ( m2s_rdempty ),
        .rdusedw_o ( m2s_rdusedw ),
        // Master tx
        .wrclk_i   ( mclk       ),
        .data_i    ( m2s_wrdata ),
        .wrreq_i   ( m2s_wrreq  )
    );


    avalon_slave_stub #(
        .MAX_BURST      ( MAX_BURST   )
    ) slave_inst (
        .clk_i          ( sclk        ),
        // tx request
        .req_data_o     ( s2m_wrdata  ),
        .req_valid_o    ( s2m_wrreq   ),
        // rx response
        .resp_rdreq_o   ( m2s_rdreq   ),
        .resp_q_i       ( m2s_q       ),
        .resp_rdempty_i ( m2s_rdempty ),
        .resp_rdusedw_i ( m2s_rdusedw )
    );


    avalon_master_stub #(
        .MAX_BURST      ( MAX_BURST   )
    ) master_inst (
        .clk_i          ( mclk        ),
        // rx request
        .req_rdreq_o    ( s2m_rdreq   ),
        .req_q_i        ( s2m_q       ),
        .req_rdempty_i  ( s2m_rdempty ),
        .req_rdusedw_i  ( s2m_rdusedw ),
        // tx response
        .resp_data_o    ( m2s_wrdata  ),
        .resp_valid_o   ( m2s_wrreq   )
    );

    // ----------------------------------------------------------------
    // Test program
    // ----------------------------------------------------------------

    import avmm_lvds_bridge_pkg::*;
    import protocol_model_pkg::*;

    initial begin : main
        void'($urandom(SEED));
        $display("\n%m: Start!\n");

        // slave_inst.verbose = 1;
        // check_test_result.verbose = 1;

        test(NOBURST, 1000);
        test(BURST, 100);

        #(100);

        $display("\n%m: Test passed!\n");
        $finish;
    end

    `define AVS_STUB_INST slave_inst
    `include "../../tb/protocol_model/avalon_slave_stub_test_api.svh"
    `undef AVS_STUB_INST

endmodule
