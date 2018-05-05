
TOP_ENTITY = protocol_model_tb

VLOG_OPT = -L altera_common_sv_packages \
           +define+ALTERA_DEVICE_FAMILY=\"Cyclone\ V\" \
           +define+MODELSIM
VSIM_OPT = -L altera_mf_ver

vpath %.sv ../../rtl
HDL_SRC += avmm_lvds_bridge_pkg.sv \
	       avmm_lvds_bridge_tx_fifo.sv \
	       avmm_lvds_bridge_rx_fifo.sv

vpath %.sv ../../tb/protocol_model
HDL_SRC += protocol_model_pkg.sv \
		   avalon_master_stub.sv \
		   avalon_slave_stub.sv \
		   channel_stub.sv \
           protocol_model_tb.sv

include ../../scripts/makefiles/modelsim/modelsim.mk
