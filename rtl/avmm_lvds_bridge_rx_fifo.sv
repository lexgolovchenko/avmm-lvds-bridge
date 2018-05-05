
// FIFO for deserialize and buffer received packets, wrapper
// for Altera dcfifo_mixed_widths IP-core

// N.B. FIFO size must be equal or above max burst size,
// it is eliminates overflow

// DATA_W and FACTOR must be power of 2

module avmm_lvds_bridge_rx_fifo #(
	parameter DATA_W = 32  ,
	parameter FACTOR = 1   ,
	parameter SIZE   = 1024

)(
	input                            wrclk_i   ,
	input  [(DATA_W / FACTOR) - 1:0] data_i    ,
	input                            wrreq_i   ,

	input                            rdclk_i   ,
	input                            rdreq_i   ,
	output            [DATA_W - 1:0] q_o       ,
	output                           rdempty_o ,
	output          [$clog2(SIZE):0] rdusedw_o
);

	dcfifo_mixed_widths fifo_inst (
		.aclr    (1'b0),

		.wrclk   (wrclk_i),
		.wrreq   (wrreq_i),
		.data    (data_i),
		.wrfull  (),
		.wrempty (),
		.wrusedw (),

		.rdclk   (rdclk_i),
		.rdreq   (rdreq_i),
		.q       (q_o),
		.rdempty (rdempty_o),
		.rdfull  (),
		.rdusedw (rdusedw_o)
	);
	defparam
		fifo_inst.lpm_width    = DATA_W / FACTOR,			// width of data port
		fifo_inst.lpm_width_r  = DATA_W,         	       	// width of q port
		fifo_inst.lpm_numwords = SIZE * FACTOR,
		fifo_inst.lpm_widthu   = $clog2(SIZE * FACTOR) + 1,	// width of wrusedw
		fifo_inst.lpm_widthu_r = $clog2(SIZE) + 1,			// width of rdusedw

		fifo_inst.lpm_showahead = "OFF",					// Normal mode - q valid after rdreq
		fifo_inst.lpm_type = "dcfifo_mixed_widths",
		fifo_inst.overflow_checking = "OFF",
		fifo_inst.underflow_checking = "OFF",
		// fifo_inst.add_usedw_msb_bit = "OFF",
		fifo_inst.add_usedw_msb_bit = "ON",

		fifo_inst.clocks_are_synchronized = "FALSE",	// Clock sync settings
		fifo_inst.wrsync_delaypipe = 4,		// Number of sync stages in control logic
		fifo_inst.rdsync_delaypipe = 4,		// N.B. Internaly reduced by 2, i.e. 4 - 2 sync stages

		fifo_inst.use_eab = "ON",			// Constructed using RAM block

		fifo_inst.write_aclr_synch = "OFF",	// Internaly sync aclr signal
		fifo_inst.read_aclr_synch = "OFF"
`ifdef MODELSIM
		, fifo_inst.intended_device_family = `ALTERA_DEVICE_FAMILY;
`else
		;
`endif


endmodule