onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group {LVDS Brige Slave} -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/m/avmm_lvds_bridge_slave/avs_if/clk_i
add wave -noupdate -group {LVDS Brige Slave} -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/m/avmm_lvds_bridge_slave/avs_if/rst_i
add wave -noupdate -group {LVDS Brige Slave} -expand -group noburst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/m/avmm_lvds_bridge_slave/avs_if/s0_address_i
add wave -noupdate -group {LVDS Brige Slave} -expand -group noburst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/m/avmm_lvds_bridge_slave/avs_if/s0_byteenable_i
add wave -noupdate -group {LVDS Brige Slave} -expand -group noburst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/m/avmm_lvds_bridge_slave/avs_if/s0_writedata_i
add wave -noupdate -group {LVDS Brige Slave} -expand -group noburst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/m/avmm_lvds_bridge_slave/avs_if/s0_readdata_o
add wave -noupdate -group {LVDS Brige Slave} -expand -group noburst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/m/avmm_lvds_bridge_slave/avs_if/s0_write_i
add wave -noupdate -group {LVDS Brige Slave} -expand -group noburst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/m/avmm_lvds_bridge_slave/avs_if/s0_read_i
add wave -noupdate -group {LVDS Brige Slave} -expand -group noburst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/m/avmm_lvds_bridge_slave/avs_if/s0_waitrequest_o
add wave -noupdate -group {LVDS Brige Slave} -expand -group burst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/m/avmm_lvds_bridge_slave/avs_if/s1_address_i
add wave -noupdate -group {LVDS Brige Slave} -expand -group burst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/m/avmm_lvds_bridge_slave/avs_if/s1_writedata_i
add wave -noupdate -group {LVDS Brige Slave} -expand -group burst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/m/avmm_lvds_bridge_slave/avs_if/s1_readdata_o
add wave -noupdate -group {LVDS Brige Slave} -expand -group burst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/m/avmm_lvds_bridge_slave/avs_if/s1_write_i
add wave -noupdate -group {LVDS Brige Slave} -expand -group burst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/m/avmm_lvds_bridge_slave/avs_if/s1_read_i
add wave -noupdate -group {LVDS Brige Slave} -expand -group burst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/m/avmm_lvds_bridge_slave/avs_if/s1_waitrequest_o
add wave -noupdate -group {LVDS Brige Slave} -expand -group burst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/m/avmm_lvds_bridge_slave/avs_if/s1_readdatavalid_o
add wave -noupdate -group {LVDS Brige Slave} -expand -group burst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/m/avmm_lvds_bridge_slave/avs_if/s1_burstcount_i
add wave -noupdate -group {LVDS Brige Slave} -expand -group req -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/m/avmm_lvds_bridge_slave/avs_if/req_data_o
add wave -noupdate -group {LVDS Brige Slave} -expand -group req -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/m/avmm_lvds_bridge_slave/avs_if/req_valid_o
add wave -noupdate -group {LVDS Brige Slave} -expand -group req -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/m/avmm_lvds_bridge_slave/avs_if/resp_rdreq_o
add wave -noupdate -group {LVDS Brige Slave} -expand -group resp -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/m/avmm_lvds_bridge_slave/avs_if/resp_q_i
add wave -noupdate -group {LVDS Brige Slave} -expand -group resp -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/m/avmm_lvds_bridge_slave/avs_if/resp_rdempty_i
add wave -noupdate -group {LVDS Brige Slave} -expand -group resp -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/m/avmm_lvds_bridge_slave/avs_if/resp_rdusedw_i
add wave -noupdate -expand -group {LVDS Bridge Master} -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/avmm_lvds_bridge_master/clk_i
add wave -noupdate -expand -group {LVDS Bridge Master} -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/avmm_lvds_bridge_master/rst_i
add wave -noupdate -expand -group {LVDS Bridge Master} -expand -group noburst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/avmm_lvds_bridge_master/m0_address_o
add wave -noupdate -expand -group {LVDS Bridge Master} -expand -group noburst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/avmm_lvds_bridge_master/m0_byteenable_o
add wave -noupdate -expand -group {LVDS Bridge Master} -expand -group noburst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/avmm_lvds_bridge_master/m0_writedata_o
add wave -noupdate -expand -group {LVDS Bridge Master} -expand -group noburst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/avmm_lvds_bridge_master/m0_readdata_i
add wave -noupdate -expand -group {LVDS Bridge Master} -expand -group noburst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/avmm_lvds_bridge_master/m0_write_o
add wave -noupdate -expand -group {LVDS Bridge Master} -expand -group noburst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/avmm_lvds_bridge_master/m0_read_o
add wave -noupdate -expand -group {LVDS Bridge Master} -expand -group noburst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/avmm_lvds_bridge_master/m0_waitrequest_i
add wave -noupdate -expand -group {LVDS Bridge Master} -expand -group burst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/avmm_lvds_bridge_master/m1_address_o
add wave -noupdate -expand -group {LVDS Bridge Master} -expand -group burst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/avmm_lvds_bridge_master/m1_writedata_o
add wave -noupdate -expand -group {LVDS Bridge Master} -expand -group burst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/avmm_lvds_bridge_master/m1_readdata_i
add wave -noupdate -expand -group {LVDS Bridge Master} -expand -group burst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/avmm_lvds_bridge_master/m1_write_o
add wave -noupdate -expand -group {LVDS Bridge Master} -expand -group burst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/avmm_lvds_bridge_master/m1_read_o
add wave -noupdate -expand -group {LVDS Bridge Master} -expand -group burst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/avmm_lvds_bridge_master/m1_waitrequest_i
add wave -noupdate -expand -group {LVDS Bridge Master} -expand -group burst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/avmm_lvds_bridge_master/m1_readdatavalid_i
add wave -noupdate -expand -group {LVDS Bridge Master} -expand -group burst -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/avmm_lvds_bridge_master/m1_burstcount_o
add wave -noupdate -expand -group {LVDS Bridge Master} -expand -group req -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/avmm_lvds_bridge_master/req_clk_i
add wave -noupdate -expand -group {LVDS Bridge Master} -expand -group req -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/avmm_lvds_bridge_master/req_data_i
add wave -noupdate -expand -group {LVDS Bridge Master} -expand -group req -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/avmm_lvds_bridge_master/req_valid_i
add wave -noupdate -expand -group {LVDS Bridge Master} -expand -group resp -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/avmm_lvds_bridge_master/resp_clk_i
add wave -noupdate -expand -group {LVDS Bridge Master} -expand -group resp -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/avmm_lvds_bridge_master/resp_data_o
add wave -noupdate -expand -group {LVDS Bridge Master} -expand -group resp -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/avmm_lvds_bridge_master/resp_valid_o
add wave -noupdate -group ram_8bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/readdata
add wave -noupdate -group ram_8bit -radix hexadecimal -childformat {{{/avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/address[11]} -radix hexadecimal} {{/avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/address[10]} -radix hexadecimal} {{/avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/address[9]} -radix hexadecimal} {{/avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/address[8]} -radix hexadecimal} {{/avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/address[7]} -radix hexadecimal} {{/avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/address[6]} -radix hexadecimal} {{/avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/address[5]} -radix hexadecimal} {{/avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/address[4]} -radix hexadecimal} {{/avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/address[3]} -radix hexadecimal} {{/avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/address[2]} -radix hexadecimal} {{/avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/address[1]} -radix hexadecimal} {{/avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/address[0]} -radix hexadecimal}} -subitemconfig {{/avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/address[11]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/address[10]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/address[9]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/address[8]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/address[7]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/address[6]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/address[5]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/address[4]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/address[3]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/address[2]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/address[1]} {-height 15 -radix hexadecimal} {/avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/address[0]} {-height 15 -radix hexadecimal}} /avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/address
add wave -noupdate -group ram_8bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/chipselect
add wave -noupdate -group ram_8bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/clk
add wave -noupdate -group ram_8bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/clken
add wave -noupdate -group ram_8bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/reset
add wave -noupdate -group ram_8bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/reset_req
add wave -noupdate -group ram_8bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/write
add wave -noupdate -group ram_8bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_8bit/writedata
add wave -noupdate -group ram_16bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_16bit/readdata
add wave -noupdate -group ram_16bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_16bit/address
add wave -noupdate -group ram_16bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_16bit/byteenable
add wave -noupdate -group ram_16bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_16bit/chipselect
add wave -noupdate -group ram_16bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_16bit/clk
add wave -noupdate -group ram_16bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_16bit/clken
add wave -noupdate -group ram_16bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_16bit/reset
add wave -noupdate -group ram_16bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_16bit/reset_req
add wave -noupdate -group ram_16bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_16bit/write
add wave -noupdate -group ram_16bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_16bit/writedata
add wave -noupdate -group ram_32bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_32bit/readdata
add wave -noupdate -group ram_32bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_32bit/address
add wave -noupdate -group ram_32bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_32bit/byteenable
add wave -noupdate -group ram_32bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_32bit/chipselect
add wave -noupdate -group ram_32bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_32bit/clk
add wave -noupdate -group ram_32bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_32bit/clken
add wave -noupdate -group ram_32bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_32bit/reset
add wave -noupdate -group ram_32bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_32bit/reset_req
add wave -noupdate -group ram_32bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_32bit/write
add wave -noupdate -group ram_32bit -radix hexadecimal /avmm_lvds_bridge_qsys_tb/dut/s/ram_32bit/writedata
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2849716 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 188
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
WaveRestoreZoom {0 ps} {22569750 ps}
