
module avalon_burst_slave_bfm #(
    parameter ADDR_W     = 16 ,
    parameter BURSTCNT_W = 11
)(
    input  logic                    clk           ,
    input  logic                    reset         ,
    input  logic     [ADDR_W - 1:0] address       ,
    output logic             [31:0] readdata      ,
    input  logic             [31:0] writedata     ,
    input  logic                    write         ,
    input  logic                    read          ,
    output logic                    waitrequest   ,
    input  logic [BURSTCNT_W - 1:0] burstcount    ,
    output logic                    readdatavalid
);

    altera_avalon_mm_slave_bfm #(
        .AV_ADDRESS_W               (ADDR_W),
        .AV_SYMBOL_W                (8),
        .AV_NUMSYMBOLS              (4),
        .AV_BURSTCOUNT_W            (BURSTCNT_W),
        .AV_READRESPONSE_W          (8),
        .AV_WRITERESPONSE_W         (8),
        .USE_READ                   (1),
        .USE_WRITE                  (1),
        .USE_ADDRESS                (1),
        .USE_BYTE_ENABLE            (0),
        .USE_BURSTCOUNT             (1),
        .USE_READ_DATA              (1),
        .USE_READ_DATA_VALID        (1),
        .USE_WRITE_DATA             (1),
        .USE_BEGIN_TRANSFER         (0),
        .USE_BEGIN_BURST_TRANSFER   (0),
        .USE_WAIT_REQUEST           (1),
        .USE_TRANSACTIONID          (0),
        .USE_WRITERESPONSE          (0),
        .USE_READRESPONSE           (0),
        .USE_CLKEN                  (0),
        .AV_BURST_LINEWRAP          (0),
        .AV_BURST_BNDR_ONLY         (0),
        .AV_MAX_PENDING_READS       (8),
        .AV_MAX_PENDING_WRITES      (0),
        .AV_FIX_READ_LATENCY        (0),
        .AV_READ_WAIT_TIME          (1),
        .AV_WRITE_WAIT_TIME         (0),
        .REGISTER_WAITREQUEST       (0),
        .AV_REGISTERINCOMINGSIGNALS (0),
        .VHDL_ID                    (0),
        .PRINT_HELLO                (0)
    ) slave (
        .clk                      (clk),                   //       clk.clk
        .reset                    (reset),            // clk_reset.reset
        .avs_writedata            (writedata),     //        s0.writedata
        .avs_burstcount           (burstcount),    //          .burstcount
        .avs_readdata             (readdata),      //          .readdata
        .avs_address              (address),       //          .address
        .avs_waitrequest          (waitrequest),   //          .waitrequest
        .avs_write                (write),         //          .write
        .avs_read                 (read),          //          .read
        .avs_byteenable           ('1),    //          .byteenable
        .avs_readdatavalid        (readdatavalid), //          .readdatavalid
        .avs_begintransfer        (1'b0),                      // (terminated)
        .avs_beginbursttransfer   (1'b0),                      // (terminated)
        .avs_arbiterlock          (1'b0),                      // (terminated)
        .avs_lock                 (1'b0),                      // (terminated)
        .avs_debugaccess          (1'b0),                      // (terminated)
        .avs_transactionid        (8'b00000000),               // (terminated)
        .avs_readid               (),                          // (terminated)
        .avs_writeid              (),                          // (terminated)
        .avs_clken                (1'b1),                      // (terminated)
        .avs_response             (),                          // (terminated)
        .avs_writeresponserequest (1'b0),                      // (terminated)
        .avs_writeresponsevalid   (),                          // (terminated)
        .avs_readresponse         (),                          // (terminated)
        .avs_writeresponse        ()                           // (terminated)
    );

endmodule
