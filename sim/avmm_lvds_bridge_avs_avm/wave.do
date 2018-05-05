onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {AVS IF} -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avs/avs_if/clk_i
add wave -noupdate -expand -group {AVS IF} -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avs/avs_if/rst_i
add wave -noupdate -expand -group {AVS IF} -group s0 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avs/avs_if/s0_address_i
add wave -noupdate -expand -group {AVS IF} -group s0 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avs/avs_if/s0_byteenable_i
add wave -noupdate -expand -group {AVS IF} -group s0 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avs/avs_if/s0_writedata_i
add wave -noupdate -expand -group {AVS IF} -group s0 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avs/avs_if/s0_readdata_o
add wave -noupdate -expand -group {AVS IF} -group s0 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avs/avs_if/s0_write_i
add wave -noupdate -expand -group {AVS IF} -group s0 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avs/avs_if/s0_read_i
add wave -noupdate -expand -group {AVS IF} -group s0 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avs/avs_if/s0_waitrequest_o
add wave -noupdate -expand -group {AVS IF} -expand -group s1 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avs/avs_if/s1_address_i
add wave -noupdate -expand -group {AVS IF} -expand -group s1 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avs/avs_if/s1_writedata_i
add wave -noupdate -expand -group {AVS IF} -expand -group s1 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avs/avs_if/s1_readdata_o
add wave -noupdate -expand -group {AVS IF} -expand -group s1 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avs/avs_if/s1_write_i
add wave -noupdate -expand -group {AVS IF} -expand -group s1 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avs/avs_if/s1_read_i
add wave -noupdate -expand -group {AVS IF} -expand -group s1 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avs/avs_if/s1_waitrequest_o
add wave -noupdate -expand -group {AVS IF} -expand -group s1 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avs/avs_if/s1_readdatavalid_o
add wave -noupdate -expand -group {AVS IF} -expand -group s1 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avs/avs_if/s1_burstcount_i
add wave -noupdate -expand -group {AVS IF} -group req -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avs/avs_if/req_data_o
add wave -noupdate -expand -group {AVS IF} -group req -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avs/avs_if/req_valid_o
add wave -noupdate -expand -group {AVS IF} -group resp -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avs/avs_if/resp_rdreq_o
add wave -noupdate -expand -group {AVS IF} -group resp -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avs/avs_if/resp_q_i
add wave -noupdate -expand -group {AVS IF} -group resp -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avs/avs_if/resp_rdempty_i
add wave -noupdate -expand -group {AVS IF} -group resp -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avs/avs_if/resp_rdusedw_i
add wave -noupdate -expand -group {AVM IF} -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avm/avm_if/clk_i
add wave -noupdate -expand -group {AVM IF} -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avm/avm_if/rst_i
add wave -noupdate -expand -group {AVM IF} -group m0 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_address_o
add wave -noupdate -expand -group {AVM IF} -group m0 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_byteenable_o
add wave -noupdate -expand -group {AVM IF} -group m0 -radix hexadecimal -childformat {{{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[31]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[30]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[29]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[28]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[27]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[26]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[25]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[24]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[23]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[22]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[21]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[20]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[19]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[18]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[17]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[16]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[15]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[14]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[13]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[12]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[11]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[10]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[9]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[8]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[7]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[6]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[5]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[4]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[3]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[2]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[1]} -radix hexadecimal} {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[0]} -radix hexadecimal}} -subitemconfig {{/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[31]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[30]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[29]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[28]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[27]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[26]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[25]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[24]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[23]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[22]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[21]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[20]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[19]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[18]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[17]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[16]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[15]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[14]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[13]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[12]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[11]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[10]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[9]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[8]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[7]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[6]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[5]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[4]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[3]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[2]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[1]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o[0]} {-height 15 -radix hexadecimal}} /avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_writedata_o
add wave -noupdate -expand -group {AVM IF} -group m0 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_readdata_i
add wave -noupdate -expand -group {AVM IF} -group m0 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_write_o
add wave -noupdate -expand -group {AVM IF} -group m0 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_read_o
add wave -noupdate -expand -group {AVM IF} -group m0 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m0_waitrequest_i
add wave -noupdate -expand -group {AVM IF} -expand -group m1 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m1_address_o
add wave -noupdate -expand -group {AVM IF} -expand -group m1 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m1_writedata_o
add wave -noupdate -expand -group {AVM IF} -expand -group m1 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m1_readdata_i
add wave -noupdate -expand -group {AVM IF} -expand -group m1 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m1_write_o
add wave -noupdate -expand -group {AVM IF} -expand -group m1 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m1_read_o
add wave -noupdate -expand -group {AVM IF} -expand -group m1 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m1_waitrequest_i
add wave -noupdate -expand -group {AVM IF} -expand -group m1 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m1_readdatavalid_i
add wave -noupdate -expand -group {AVM IF} -expand -group m1 -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avm/avm_if/m1_burstcount_o
add wave -noupdate -expand -group {AVM IF} -group req -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avm/avm_if/req_rdreq_o
add wave -noupdate -expand -group {AVM IF} -group req -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avm/avm_if/req_q_i
add wave -noupdate -expand -group {AVM IF} -group req -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avm/avm_if/req_rdempty_i
add wave -noupdate -expand -group {AVM IF} -group req -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avm/avm_if/req_rdusedw_i
add wave -noupdate -expand -group {AVM IF} -group resp -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avm/avm_if/resp_data_o
add wave -noupdate -expand -group {AVM IF} -group resp -radix hexadecimal /avmm_lvds_bridge_avs_avm_tb/avm/avm_if/resp_valid_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {17570000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ps} {24197250 ps}
