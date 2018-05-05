
module avmm_lvds_bridge_avm_if_tb #(
    parameter SEED = 0
);
    timeunit 1ns;
    timeprecision 1ps;

    parameter T_clk = 10ns;
    logic clk = 0;
    logic rst = 1;
    always  #(T_clk / 2) clk <= ~clk;
    initial #(T_clk * 2) rst <= 0;

    parameter T_sclk    = 10ns;
    parameter T_s2m_clk = 10ns;
    parameter T_m2s_clk = 10ns;

    logic sclk = '0;
    always #(T_sclk / 2) sclk = ~sclk;

    import avmm_lvds_bridge_pkg::*;
    import protocol_model_pkg::*;

    // ----------------------------------------------------------------
    // Test system
    // ----------------------------------------------------------------
    //           ----> REQ_CHANNEL  --->
    // SLAVE STUB                       AVALON MASTER DUT <-> SLAVE BFM
    //           <---- RESP_CHANNEL <---
    // ----------------------------------------------------------------

    localparam M2S_FACTOR = 1;
    localparam S2M_FACTOR = 16;

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


    avalon_slave_stub #(
        .MAX_BURST      ( MAX_BURST   )
    ) avs_stub (
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
        .rdclk_i   ( clk         ),
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
        // Slave rx
        .rdclk_i   ( sclk        ),
        .rdreq_i   ( m2s_rdreq   ),
        .q_o       ( m2s_q       ),
        .rdempty_o ( m2s_rdempty ),
        .rdusedw_o ( m2s_rdusedw ),
        // Master tx
        .wrclk_i   ( clk        ),
        .data_i    ( m2s_wrdata ),
        .wrreq_i   ( m2s_wrreq  )
    );

    avmm_lvds_bridge_avm_if dut (
        .clk_i              ( clk ),
        .rst_i              ( rst ),

        .req_rdreq_o        ( s2m_rdreq   ),
        .req_q_i            ( s2m_q       ),
        .req_rdempty_i      ( s2m_rdempty ),
        .req_rdusedw_i      ( s2m_rdusedw ),

        .resp_data_o        ( m2s_wrdata  ),
        .resp_valid_o       ( m2s_wrreq   ),

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
        .m1_burstcount_o    ( m1_burstcount    )
    );

    avalon_noburst_slave_bfm #(
        .ADDR_W     (ADDR_W),
        .NUMSYMBOLS (4)
    ) noburst_slave (
        .clk           ( clk ),
        .reset         ( rst ),

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
        .clk           ( clk ),
        .reset         ( rst ),

        .address       ( m1_address       ),
        .readdata      ( m1_readdata      ),
        .writedata     ( m1_writedata     ),
        .write         ( m1_write         ),
        .read          ( m1_read          ),
        .waitrequest   ( m1_waitrequest   ),
        .burstcount    ( m1_burstcount    ),
        .readdatavalid ( m1_readdatavalid )
    );

     // NOBURST slave API
    `define SLAVE noburst_slave.slave
    `define SLAVE_TP_INST noburst_slave_api_inst
    `include "../../tb/avmm_bfm/slave_bfm_simple_test_api.svh"
    `undef SLAVE
    `undef SLAVE_TP_INST

    // BURST slave API
    `define SLAVE burst_slave.slave
    `define SLAVE_TP_INST burst_slave_api_inst
    `include "../../tb/avmm_bfm/slave_bfm_simple_test_api.svh"
    `undef SLAVE
    `undef SLAVE_TP_INST

    // ----------------------------------------------------------------
    // Test program
    // ----------------------------------------------------------------

    initial begin : main
        void'($urandom(SEED));
        $display("\n%m: Start!\n");
        avs_stub.verbose = 0;

        wait(rst == 0);
        tick(10);

        // ------------------------------------------------------------
        // Random NOBURST test
        // ------------------------------------------------------------

        // Without backpressure
        noburst_slave_api_inst.set_backpressure_cycles(0, 0);
        noburst_slave_api_inst.randomize_backpressure = 0;
        noburst_slave_api_inst.const_backpressure = 0;
        test(NOBURST, 50);

        // With const backpressure
        noburst_slave_api_inst.set_backpressure_cycles(0, 1);
        noburst_slave_api_inst.const_backpressure = 1;
        test(NOBURST, 50);

        // With random backpressure
        noburst_slave_api_inst.set_backpressure_cycles(1);
        noburst_slave_api_inst.randomize_backpressure = 1;
        test(NOBURST, 50);

        // ------------------------------------------------------------
        // Check BURST boundary cases - payload size 1 и MAX_BURST
        // ------------------------------------------------------------

        repeat (3) begin
            // Without backpressure
            burst_slave_api_inst.set_backpressure_cycles(0, 0);
            burst_slave_api_inst.randomize_backpressure = 0;
            burst_slave_api_inst.const_backpressure = 0;
            test(BURST, 2);

            // With const backpressure
            burst_slave_api_inst.set_backpressure_cycles(0, 1);
            burst_slave_api_inst.const_backpressure = 1;
            test(BURST, 2);

            // With random backpressure
            burst_slave_api_inst.set_backpressure_cycles(1);
            burst_slave_api_inst.randomize_backpressure = 1;
            test(BURST, 2);
        end

        // ------------------------------------------------------------
        // BURST with random payload size
        // ------------------------------------------------------------

        burst_slave_api_inst.set_backpressure_cycles(0, 0);
        burst_slave_api_inst.randomize_backpressure = 0;
        burst_slave_api_inst.const_backpressure = 0;
        test(BURST, 50);

        burst_slave_api_inst.set_backpressure_cycles(1);
        burst_slave_api_inst.randomize_backpressure = 1;
        test(BURST, 50);

        $display("\n%m: Test passed!\n");
        $finish;
    end

    task tick(int n);
        #(n * T_clk);
    endtask


    `define AVS_STUB_INST avs_stub
    `include "../../tb/protocol_model/avalon_slave_stub_test_api.svh"
    `undef AVS_STUB_INST

endmodule
