
module avmm_lvds_bridge_qsys_tb #(
    parameter SEED = 0
);
    timeunit 1ns;
    timeprecision 1ps;

    parameter T_req_clk = 10ns;
    parameter T_resp_clk = 10ns;

    logic req_clk = 0;
    always  #(T_req_clk / 2) req_clk <= ~req_clk;

    logic resp_clk = 0;
    always  #(T_resp_clk / 2) resp_clk <= ~resp_clk;

    // ----------------------------------------------------------------
    // DUT
    // ----------------------------------------------------------------

    logic [31:0] req_data;
    logic req_valid;

    logic [31:0] resp_data;
    logic resp_valid;

     avmm_lvds_bridge_test_sys dut (
        .m_req_tx_clk_i    (req_clk),
        .m_req_tx_data_o   (req_data),
        .m_req_tx_valid_o  (req_valid),

        .m_resp_rx_clk_i   (resp_clk),
        .m_resp_rx_data_i  (resp_data),
        .m_resp_rx_valid_i (resp_valid),

        .s_req_rx_clk_i    (req_clk),
        .s_req_rx_data_i   (req_data),
        .s_req_rx_valid_i  (req_valid),

        .s_resp_tx_clk_i   (resp_clk),
        .s_resp_tx_data_o  (resp_data),
        .s_resp_tx_valid_o (resp_valid)
    );

    // ----------------------------------------------------------------
    // Avalon Slave BFM API
    // ----------------------------------------------------------------

    `define SLAVE dut.s.slave_0
    `define SLAVE_TP_INST slave0
    `include "../../tb/avmm_bfm/slave_bfm_simple_test_api.svh"
    `undef SLAVE
    `undef SLAVE_TP_INST

    `define SLAVE dut.s.slave_1
    `define SLAVE_TP_INST slave1
    `include "../../tb/avmm_bfm/slave_bfm_simple_test_api.svh"
    `undef SLAVE
    `undef SLAVE_TP_INST

    `define SLAVE dut.s.slave_2
    `define SLAVE_TP_INST slave2
    `include "../../tb/avmm_bfm/slave_bfm_simple_test_api.svh"
    `undef SLAVE
    `undef SLAVE_TP_INST

    `define SLAVE dut.s.slave_3
    `define SLAVE_TP_INST slave3
    `include "../../tb/avmm_bfm/slave_bfm_simple_test_api.svh"
    `undef SLAVE
    `undef SLAVE_TP_INST

    // ----------------------------------------------------------------
    // Avalon Master BFM API
    // ----------------------------------------------------------------

    // slave ports of lvds bridge
    localparam NOBURST_ADDR = 32'h0000_0000;
    localparam   BURST_ADDR = 32'h0020_0000;

    // master ports of lvds bridge
    localparam RAM_8BIT_ADDR = 32'h0000_0000;
    localparam RAM_8BIT_SPAN = 32'h0000_1000;

    localparam RAM_16BIT_ADDR = 32'h0001_0000;
    localparam RAM_16BIT_SPAN = 32'h0001_1000;

    localparam RAM_32BIT_ADDR = 32'h0002_0000;
    localparam RAM_32BIT_SPAN = 32'h0001_0000;

    localparam SLAVE0_ADDR = 32'h0003_1000;
    localparam SLAVE0_SPAN = 32'h0000_1000;

    localparam SLAVE1_ADDR = 32'h0003_0000;
    localparam SLAVE1_SPAN = 32'h0000_1000;

    localparam SLAVE2_ADDR = 32'h0000_4000;
    localparam SLAVE2_SPAN = 32'h0000_4000;

    localparam SLAVE3_ADDR = 32'h0000_0000;
    localparam SLAVE3_SPAN = 32'h0000_4000;

    `define MASTER dut.m.master_0
    `define MASTER_TP_INST master0
    `include "../../tb/avmm_bfm/master_bfm_simple_test_api.svh"
    `undef MASTER
    `undef MASTER_TP_INST

    `define MASTER dut.m.master_1
    `define MASTER_TP_INST master1
    `include "../../tb/avmm_bfm/master_bfm_simple_test_api.svh"
    `undef MASTER
    `undef MASTER_TP_INST

    // ----------------------------------------------------------------
    // Test program
    // ----------------------------------------------------------------

    `define MASTER_API_INST master0
    `define NOBURST_TASK master0_noburst_test
    `define BURST_TASK master0_burst_test
    `include "../../tb/avmm_lvds_bridge_qsys_tp.svh"
    `undef MASTER_API_INST
    `undef NOBURST_TASK
    `undef BURST_TASK

    `define MASTER_API_INST master1
    `define NOBURST_TASK master1_noburst_test
    `define BURST_TASK master1_burst_test
    `include "../../tb/avmm_lvds_bridge_qsys_tp.svh"
    `undef MASTER_API_INST
    `undef NOBURST_TASK
    `undef BURST_TASK

    logic [31:0] rd;

    initial begin
        void'($urandom(SEED));
        $display("\n%m : Start!\n");

        wait(dut.m.master_0.reset == 0);
        #(100);

        master0_noburst_test( NOBURST_ADDR | RAM_8BIT_ADDR  , RAM_8BIT_SPAN / 4  , 10);
        master0_noburst_test( NOBURST_ADDR | RAM_16BIT_ADDR , RAM_16BIT_SPAN / 4 , 10);
        master0_noburst_test( NOBURST_ADDR | RAM_32BIT_ADDR , RAM_32BIT_SPAN / 4 , 10);
        master0_noburst_test( NOBURST_ADDR | SLAVE0_ADDR    , SLAVE0_SPAN / 4    , 10);
        master0_noburst_test( NOBURST_ADDR | SLAVE1_ADDR    , SLAVE1_SPAN / 4    , 10);
        master0_burst_test(   BURST_ADDR   | RAM_32BIT_ADDR , RAM_32BIT_SPAN / 4 , 5,  -1);
        master0_burst_test(   BURST_ADDR   | SLAVE2_ADDR    , SLAVE2_SPAN / 4    , 5, 100);
        master0_burst_test(   BURST_ADDR   | SLAVE3_ADDR    , SLAVE3_SPAN / 4    , 5, 100);

        master1_noburst_test( NOBURST_ADDR | RAM_8BIT_ADDR  , RAM_8BIT_SPAN / 4  , 10);
        master1_noburst_test( NOBURST_ADDR | RAM_16BIT_ADDR , RAM_16BIT_SPAN / 4 , 10);
        master1_noburst_test( NOBURST_ADDR | RAM_32BIT_ADDR , RAM_32BIT_SPAN / 4 , 10);
        master1_noburst_test( NOBURST_ADDR | SLAVE0_ADDR    , SLAVE0_SPAN / 4    , 10);
        master1_noburst_test( NOBURST_ADDR | SLAVE1_ADDR    , SLAVE1_SPAN / 4    , 10);
        master1_burst_test(   BURST_ADDR   | RAM_32BIT_ADDR , RAM_32BIT_SPAN / 4 , 10,  -1);
        master1_burst_test(   BURST_ADDR   | SLAVE2_ADDR    , SLAVE2_SPAN / 4    , 10, 100);
        master1_burst_test(   BURST_ADDR   | SLAVE3_ADDR    , SLAVE3_SPAN / 4    , 10, 100);

        $display("\n%m : Test passed!\n");
        $finish;
    end



endmodule
