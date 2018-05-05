onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group DUT /avmm_lvds_bridge_avm_if_tb/dut/clk_i
add wave -noupdate -expand -group DUT /avmm_lvds_bridge_avm_if_tb/dut/rst_i
add wave -noupdate -expand -group DUT -group m0 -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/dut/m0_address_o
add wave -noupdate -expand -group DUT -group m0 -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/dut/m0_byteenable_o
add wave -noupdate -expand -group DUT -group m0 -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/dut/m0_writedata_o
add wave -noupdate -expand -group DUT -group m0 -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/dut/m0_readdata_i
add wave -noupdate -expand -group DUT -group m0 -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/dut/m0_write_o
add wave -noupdate -expand -group DUT -group m0 -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/dut/m0_read_o
add wave -noupdate -expand -group DUT -group m0 -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/dut/m0_waitrequest_i
add wave -noupdate -expand -group DUT -expand -group m1 -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/dut/m1_address_o
add wave -noupdate -expand -group DUT -expand -group m1 -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/dut/m1_writedata_o
add wave -noupdate -expand -group DUT -expand -group m1 -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/dut/m1_readdata_i
add wave -noupdate -expand -group DUT -expand -group m1 -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/dut/m1_write_o
add wave -noupdate -expand -group DUT -expand -group m1 -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/dut/m1_read_o
add wave -noupdate -expand -group DUT -expand -group m1 -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/dut/m1_waitrequest_i
add wave -noupdate -expand -group DUT -expand -group m1 -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/dut/m1_readdatavalid_i
add wave -noupdate -expand -group DUT -expand -group m1 -radix hexadecimal -childformat {{{/avmm_lvds_bridge_avm_if_tb/dut/m1_burstcount_o[10]} -radix hexadecimal} {{/avmm_lvds_bridge_avm_if_tb/dut/m1_burstcount_o[9]} -radix hexadecimal} {{/avmm_lvds_bridge_avm_if_tb/dut/m1_burstcount_o[8]} -radix hexadecimal} {{/avmm_lvds_bridge_avm_if_tb/dut/m1_burstcount_o[7]} -radix hexadecimal} {{/avmm_lvds_bridge_avm_if_tb/dut/m1_burstcount_o[6]} -radix hexadecimal} {{/avmm_lvds_bridge_avm_if_tb/dut/m1_burstcount_o[5]} -radix hexadecimal} {{/avmm_lvds_bridge_avm_if_tb/dut/m1_burstcount_o[4]} -radix hexadecimal} {{/avmm_lvds_bridge_avm_if_tb/dut/m1_burstcount_o[3]} -radix hexadecimal} {{/avmm_lvds_bridge_avm_if_tb/dut/m1_burstcount_o[2]} -radix hexadecimal} {{/avmm_lvds_bridge_avm_if_tb/dut/m1_burstcount_o[1]} -radix hexadecimal} {{/avmm_lvds_bridge_avm_if_tb/dut/m1_burstcount_o[0]} -radix hexadecimal}} -subitemconfig {{/avmm_lvds_bridge_avm_if_tb/dut/m1_burstcount_o[10]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avm_if_tb/dut/m1_burstcount_o[9]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avm_if_tb/dut/m1_burstcount_o[8]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avm_if_tb/dut/m1_burstcount_o[7]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avm_if_tb/dut/m1_burstcount_o[6]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avm_if_tb/dut/m1_burstcount_o[5]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avm_if_tb/dut/m1_burstcount_o[4]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avm_if_tb/dut/m1_burstcount_o[3]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avm_if_tb/dut/m1_burstcount_o[2]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avm_if_tb/dut/m1_burstcount_o[1]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avm_if_tb/dut/m1_burstcount_o[0]} {-height 15 -radix hexadecimal}} /avmm_lvds_bridge_avm_if_tb/dut/m1_burstcount_o
add wave -noupdate -expand -group DUT -expand -group req -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/dut/req_rdreq_o
add wave -noupdate -expand -group DUT -expand -group req -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/dut/req_q_i
add wave -noupdate -expand -group DUT -expand -group req -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/dut/req_rdempty_i
add wave -noupdate -expand -group DUT -expand -group req -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/dut/req_rdusedw_i
add wave -noupdate -expand -group DUT -group resp -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/dut/resp_data_o
add wave -noupdate -expand -group DUT -group resp -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/dut/resp_valid_o
add wave -noupdate -expand -group DUT -radix hexadecimal -childformat {{/avmm_lvds_bridge_avm_if_tb/dut/req_hdr_r.tr -radix hexadecimal} {/avmm_lvds_bridge_avm_if_tb/dut/req_hdr_r.burst -radix hexadecimal} {/avmm_lvds_bridge_avm_if_tb/dut/req_hdr_r.address -radix hexadecimal} {/avmm_lvds_bridge_avm_if_tb/dut/req_hdr_r.burstcnt_byteena -radix hexadecimal}} -subitemconfig {/avmm_lvds_bridge_avm_if_tb/dut/req_hdr_r.tr {-height 15 -radix hexadecimal} /avmm_lvds_bridge_avm_if_tb/dut/req_hdr_r.burst {-height 15 -radix hexadecimal} /avmm_lvds_bridge_avm_if_tb/dut/req_hdr_r.address {-height 15 -radix hexadecimal} /avmm_lvds_bridge_avm_if_tb/dut/req_hdr_r.burstcnt_byteena {-height 15 -radix hexadecimal}} /avmm_lvds_bridge_avm_if_tb/dut/req_hdr_r
add wave -noupdate -expand -group DUT -radix unsigned /avmm_lvds_bridge_avm_if_tb/dut/wrcnt
add wave -noupdate -expand -group DUT -radix unsigned /avmm_lvds_bridge_avm_if_tb/dut/rdcnt
add wave -noupdate -expand -group DUT -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/dut/state
add wave -noupdate -group {Noburst Slave} -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/noburst_slave/slave/clk
add wave -noupdate -group {Noburst Slave} -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/noburst_slave/slave/reset
add wave -noupdate -group {Noburst Slave} -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/noburst_slave/slave/avs_waitrequest
add wave -noupdate -group {Noburst Slave} -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/noburst_slave/slave/avs_readdata
add wave -noupdate -group {Noburst Slave} -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/noburst_slave/slave/avs_write
add wave -noupdate -group {Noburst Slave} -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/noburst_slave/slave/avs_read
add wave -noupdate -group {Noburst Slave} -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/noburst_slave/slave/avs_address
add wave -noupdate -group {Noburst Slave} -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/noburst_slave/slave/avs_byteenable
add wave -noupdate -group {Noburst Slave} -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/noburst_slave/slave/avs_writedata
add wave -noupdate -group {Burst Slave} -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/burst_slave/slave/clk
add wave -noupdate -group {Burst Slave} -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/burst_slave/slave/reset
add wave -noupdate -group {Burst Slave} -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/burst_slave/slave/avs_waitrequest
add wave -noupdate -group {Burst Slave} -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/burst_slave/slave/avs_readdatavalid
add wave -noupdate -group {Burst Slave} -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/burst_slave/slave/avs_readdata
add wave -noupdate -group {Burst Slave} -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/burst_slave/slave/avs_write
add wave -noupdate -group {Burst Slave} -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/burst_slave/slave/avs_read
add wave -noupdate -group {Burst Slave} -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/burst_slave/slave/avs_address
add wave -noupdate -group {Burst Slave} -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/burst_slave/slave/avs_burstcount
add wave -noupdate -group {Burst Slave} -radix hexadecimal /avmm_lvds_bridge_avm_if_tb/burst_slave/slave/avs_writedata
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {569783 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 248
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1050 ns}
