
# QUARTUS_PATH = c:/altera/15.1/quartus
# PYTHON3 = c:/Anaconda3/python

TOP_ENTITY = avmm_lvds_bridge_qsys_tb

VSIM_OPT += -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver \
		    -L altera_lnsim_ver -L cycloneiv_hssi_ver \
		    -L cycloneiv_pcie_hip_ver -L cycloneiv_ver

VLOG_OPT += +define+ALTERA_DEVICE_FAMILY=\"Cyclone\ V\" \
            +define+MODELSIM #-L altera_common_sv_packages

QSYS_LIB_PATH = ../../rtl,../../tb
vpath %.qsys ../../tb
QSYS_SRC = avmm_lvds_bridge_test_sys.qsys

vpath %.sv ../../tb/protocol_model
HDL_SRC  += protocol_model_pkg.sv

vpath %.sv ../../tb
HDL_SRC  += avmm_lvds_bridge_qsys_tb.sv

include ../../scripts/makefiles/modelsim/modelsim.mk
