
module avalon_burst_master_bfm #(
	parameter ADDR_W     = 16 ,
	parameter BURSTCNT_W = 11
)(
	input  logic                    clk           ,
	input  logic                    reset         ,
	output logic     [ADDR_W - 1:0] address       ,
	input  logic             [31:0] readdata      ,
	output logic             [31:0] writedata     ,
	output logic                    write         ,
	output logic                    read          ,
	input  logic                    waitrequest   ,
	output logic [BURSTCNT_W - 1:0] burstcount    ,
	input  logic                    readdatavalid
);

	altera_avalon_mm_master_bfm #(
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
		.AV_CONSTANT_BURST_BEHAVIOR (1),
		.AV_BURST_LINEWRAP          (1),
		.AV_BURST_BNDR_ONLY         (1),
		.AV_MAX_PENDING_READS       (0),
		.AV_MAX_PENDING_WRITES      (0),
		.AV_FIX_READ_LATENCY        (1),
		.AV_READ_WAIT_TIME          (1),
		.AV_WRITE_WAIT_TIME         (0),
		.REGISTER_WAITREQUEST       (0),
		.AV_REGISTERINCOMINGSIGNALS (0),
		.VHDL_ID                    (0),
		.PRINT_HELLO                (0)
	) master (
		.clk                      (clk),          //       clk.clk
		.reset                    (reset),   	   // clk_reset.reset
		.avm_address              (address),     //        m0.address
		.avm_readdata             (readdata),    //          .readdata
		.avm_writedata            (writedata),   //          .writedata
		.avm_waitrequest          (waitrequest), //          .waitrequest
		.avm_write                (write),       //          .write
		.avm_read                 (read),        //          .read
		.avm_byteenable           (),            //          .byteenable
		.avm_burstcount           (burstcount),              // (terminated)
		.avm_begintransfer        (),              // (terminated)
		.avm_beginbursttransfer   (),              // (terminated)
		.avm_readdatavalid        (readdatavalid),          // (terminated)
		.avm_arbiterlock          (),              // (terminated)
		.avm_lock                 (),              // (terminated)
		.avm_debugaccess          (),              // (terminated)
		.avm_transactionid        (),              // (terminated)
		.avm_readid               (8'b00000000),   // (terminated)
		.avm_writeid              (8'b00000000),   // (terminated)
		.avm_clken                (),              // (terminated)
		.avm_response             (2'b00),         // (terminated)
		.avm_writeresponsevalid   (1'b0),          // (terminated)
		.avm_writeresponserequest (),
		.avm_readresponse         (8'b00000000),   // (terminated)
		.avm_writeresponse        (8'b00000000)    // (terminated)
	);

endmodule
