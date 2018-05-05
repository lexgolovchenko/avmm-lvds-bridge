
TOP_ENTITY = avmm_lvds_bridge_avm_if_tb

VLOG_OPT = +define+ALTERA_DEVICE_FAMILY=\"Cyclone\ V\" \
           -L altera_common_sv_packages \
           +define+MODELSIM
VSIM_OPT = -L altera_mf_ver

vpath %.sv ../../rtl
HDL_SRC += avmm_lvds_bridge_tx_fifo.sv \
	       avmm_lvds_bridge_rx_fifo.sv \
           avmm_lvds_bridge_pkg.sv \
           avmm_lvds_bridge_avm_if.sv

vpath %.sv ../../tb/protocol_model
HDL_SRC += protocol_model_pkg.sv \
		   avalon_master_stub.sv \
		   avalon_slave_stub.sv \
		   channel_stub.sv

vpath %.sv ../../tb/avmm_bfm
HDL_SRC += verbosity_pkg.sv \
		   avalon_mm_pkg.sv \
           avalon_utilities_pkg.sv \
           altera_avalon_mm_slave_bfm.sv \
           avalon_noburst_slave_bfm.sv \
           avalon_burst_slave_bfm.sv

vpath %.sv ../../tb
HDL_SRC += avmm_lvds_bridge_avm_if_tb.sv

include ../../scripts/makefiles/modelsim/modelsim.mk
