onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group {S2M CH TX FIFO} -radix hexadecimal /protocol_model_tb/s2m_channel/tx_fifo/fifo_inst/aclr
add wave -noupdate -group {S2M CH TX FIFO} -divider <NULL>
add wave -noupdate -group {S2M CH TX FIFO} -radix hexadecimal /protocol_model_tb/s2m_channel/tx_fifo/fifo_inst/wrclk
add wave -noupdate -group {S2M CH TX FIFO} -radix hexadecimal /protocol_model_tb/s2m_channel/tx_fifo/fifo_inst/wrreq
add wave -noupdate -group {S2M CH TX FIFO} -radix hexadecimal /protocol_model_tb/s2m_channel/tx_fifo/fifo_inst/data
add wave -noupdate -group {S2M CH TX FIFO} -radix hexadecimal /protocol_model_tb/s2m_channel/tx_fifo/fifo_inst/wrfull
add wave -noupdate -group {S2M CH TX FIFO} -radix hexadecimal /protocol_model_tb/s2m_channel/tx_fifo/fifo_inst/wrusedw
add wave -noupdate -group {S2M CH TX FIFO} -radix hexadecimal /protocol_model_tb/s2m_channel/tx_fifo/fifo_inst/wrempty
add wave -noupdate -group {S2M CH TX FIFO} -divider <NULL>
add wave -noupdate -group {S2M CH TX FIFO} -radix hexadecimal /protocol_model_tb/s2m_channel/tx_fifo/fifo_inst/rdclk
add wave -noupdate -group {S2M CH TX FIFO} -radix hexadecimal /protocol_model_tb/s2m_channel/tx_fifo/fifo_inst/rdreq
add wave -noupdate -group {S2M CH TX FIFO} -radix hexadecimal /protocol_model_tb/s2m_channel/tx_fifo/fifo_inst/q
add wave -noupdate -group {S2M CH TX FIFO} -radix hexadecimal /protocol_model_tb/s2m_channel/tx_fifo/fifo_inst/rdempty
add wave -noupdate -group {S2M CH TX FIFO} -radix hexadecimal /protocol_model_tb/s2m_channel/tx_fifo/fifo_inst/rdusedw
add wave -noupdate -group {S2M CH TX FIFO} -radix hexadecimal /protocol_model_tb/s2m_channel/tx_fifo/fifo_inst/rdfull
add wave -noupdate -group {S2M CH RX FIFO} -radix hexadecimal /protocol_model_tb/s2m_channel/rx_fifo/fifo_inst/aclr
add wave -noupdate -group {S2M CH RX FIFO} -divider <NULL>
add wave -noupdate -group {S2M CH RX FIFO} -radix hexadecimal /protocol_model_tb/s2m_channel/rx_fifo/fifo_inst/wrclk
add wave -noupdate -group {S2M CH RX FIFO} -radix hexadecimal /protocol_model_tb/s2m_channel/rx_fifo/fifo_inst/wrreq
add wave -noupdate -group {S2M CH RX FIFO} -radix hexadecimal /protocol_model_tb/s2m_channel/rx_fifo/fifo_inst/data
add wave -noupdate -group {S2M CH RX FIFO} -radix hexadecimal /protocol_model_tb/s2m_channel/rx_fifo/fifo_inst/wrfull
add wave -noupdate -group {S2M CH RX FIFO} -radix hexadecimal /protocol_model_tb/s2m_channel/rx_fifo/fifo_inst/wrusedw
add wave -noupdate -group {S2M CH RX FIFO} -radix hexadecimal /protocol_model_tb/s2m_channel/rx_fifo/fifo_inst/wrempty
add wave -noupdate -group {S2M CH RX FIFO} -divider <NULL>
add wave -noupdate -group {S2M CH RX FIFO} -radix hexadecimal /protocol_model_tb/s2m_channel/rx_fifo/fifo_inst/rdclk
add wave -noupdate -group {S2M CH RX FIFO} -radix hexadecimal /protocol_model_tb/s2m_channel/rx_fifo/fifo_inst/rdreq
add wave -noupdate -group {S2M CH RX FIFO} -radix hexadecimal /protocol_model_tb/s2m_channel/rx_fifo/fifo_inst/q
add wave -noupdate -group {S2M CH RX FIFO} -radix hexadecimal /protocol_model_tb/s2m_channel/rx_fifo/fifo_inst/rdempty
add wave -noupdate -group {S2M CH RX FIFO} -radix hexadecimal /protocol_model_tb/s2m_channel/rx_fifo/fifo_inst/rdusedw
add wave -noupdate -group {S2M CH RX FIFO} -radix hexadecimal /protocol_model_tb/s2m_channel/rx_fifo/fifo_inst/rdfull
add wave -noupdate -expand -label sim:/protocol_model_tb/s2m_channel/Group1 -group {Region: sim:/protocol_model_tb/s2m_channel} -radix hexadecimal /protocol_model_tb/s2m_channel/wrclk_i
add wave -noupdate -expand -label sim:/protocol_model_tb/s2m_channel/Group1 -group {Region: sim:/protocol_model_tb/s2m_channel} -radix hexadecimal /protocol_model_tb/s2m_channel/data_i
add wave -noupdate -expand -label sim:/protocol_model_tb/s2m_channel/Group1 -group {Region: sim:/protocol_model_tb/s2m_channel} -radix hexadecimal /protocol_model_tb/s2m_channel/wrreq_i
add wave -noupdate -expand -label sim:/protocol_model_tb/s2m_channel/Group1 -group {Region: sim:/protocol_model_tb/s2m_channel} -divider <NULL>
add wave -noupdate -expand -label sim:/protocol_model_tb/s2m_channel/Group1 -group {Region: sim:/protocol_model_tb/s2m_channel} -radix hexadecimal /protocol_model_tb/s2m_channel/rdclk_i
add wave -noupdate -expand -label sim:/protocol_model_tb/s2m_channel/Group1 -group {Region: sim:/protocol_model_tb/s2m_channel} -radix hexadecimal /protocol_model_tb/s2m_channel/rdreq_i
add wave -noupdate -expand -label sim:/protocol_model_tb/s2m_channel/Group1 -group {Region: sim:/protocol_model_tb/s2m_channel} -radix hexadecimal /protocol_model_tb/s2m_channel/q_o
add wave -noupdate -expand -label sim:/protocol_model_tb/s2m_channel/Group1 -group {Region: sim:/protocol_model_tb/s2m_channel} -radix hexadecimal /protocol_model_tb/s2m_channel/rdempty_o
add wave -noupdate -expand -label sim:/protocol_model_tb/s2m_channel/Group1 -group {Region: sim:/protocol_model_tb/s2m_channel} -radix hexadecimal -childformat {{{/protocol_model_tb/s2m_channel/rdusedw_o[9]} -radix hexadecimal} {{/protocol_model_tb/s2m_channel/rdusedw_o[8]} -radix hexadecimal} {{/protocol_model_tb/s2m_channel/rdusedw_o[7]} -radix hexadecimal} {{/protocol_model_tb/s2m_channel/rdusedw_o[6]} -radix hexadecimal} {{/protocol_model_tb/s2m_channel/rdusedw_o[5]} -radix hexadecimal} {{/protocol_model_tb/s2m_channel/rdusedw_o[4]} -radix hexadecimal} {{/protocol_model_tb/s2m_channel/rdusedw_o[3]} -radix hexadecimal} {{/protocol_model_tb/s2m_channel/rdusedw_o[2]} -radix hexadecimal} {{/protocol_model_tb/s2m_channel/rdusedw_o[1]} -radix hexadecimal} {{/protocol_model_tb/s2m_channel/rdusedw_o[0]} -radix hexadecimal}} -subitemconfig {{/protocol_model_tb/s2m_channel/rdusedw_o[9]} {-height 15 -radix hexadecimal} {/protocol_model_tb/s2m_channel/rdusedw_o[8]} {-height 15 -radix hexadecimal} {/protocol_model_tb/s2m_channel/rdusedw_o[7]} {-height 15 -radix hexadecimal} {/protocol_model_tb/s2m_channel/rdusedw_o[6]} {-height 15 -radix hexadecimal} {/protocol_model_tb/s2m_channel/rdusedw_o[5]} {-height 15 -radix hexadecimal} {/protocol_model_tb/s2m_channel/rdusedw_o[4]} {-height 15 -radix hexadecimal} {/protocol_model_tb/s2m_channel/rdusedw_o[3]} {-height 15 -radix hexadecimal} {/protocol_model_tb/s2m_channel/rdusedw_o[2]} {-height 15 -radix hexadecimal} {/protocol_model_tb/s2m_channel/rdusedw_o[1]} {-height 15 -radix hexadecimal} {/protocol_model_tb/s2m_channel/rdusedw_o[0]} {-height 15 -radix hexadecimal}} /protocol_model_tb/s2m_channel/rdusedw_o
add wave -noupdate -expand -label sim:/protocol_model_tb/m2s_channel/Group1 -group {Region: sim:/protocol_model_tb/m2s_channel} -radix hexadecimal /protocol_model_tb/m2s_channel/wrclk_i
add wave -noupdate -expand -label sim:/protocol_model_tb/m2s_channel/Group1 -group {Region: sim:/protocol_model_tb/m2s_channel} -radix hexadecimal -childformat {{{/protocol_model_tb/m2s_channel/data_i[31]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[30]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[29]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[28]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[27]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[26]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[25]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[24]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[23]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[22]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[21]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[20]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[19]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[18]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[17]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[16]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[15]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[14]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[13]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[12]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[11]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[10]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[9]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[8]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[7]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[6]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[5]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[4]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[3]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[2]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[1]} -radix hexadecimal} {{/protocol_model_tb/m2s_channel/data_i[0]} -radix hexadecimal}} -subitemconfig {{/protocol_model_tb/m2s_channel/data_i[31]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[30]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[29]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[28]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[27]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[26]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[25]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[24]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[23]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[22]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[21]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[20]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[19]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[18]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[17]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[16]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[15]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[14]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[13]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[12]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[11]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[10]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[9]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[8]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[7]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[6]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[5]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[4]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[3]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[2]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[1]} {-radix hexadecimal} {/protocol_model_tb/m2s_channel/data_i[0]} {-radix hexadecimal}} /protocol_model_tb/m2s_channel/data_i
add wave -noupdate -expand -label sim:/protocol_model_tb/m2s_channel/Group1 -group {Region: sim:/protocol_model_tb/m2s_channel} -radix hexadecimal /protocol_model_tb/m2s_channel/wrreq_i
add wave -noupdate -expand -label sim:/protocol_model_tb/m2s_channel/Group1 -group {Region: sim:/protocol_model_tb/m2s_channel} -divider <NULL>
add wave -noupdate -expand -label sim:/protocol_model_tb/m2s_channel/Group1 -group {Region: sim:/protocol_model_tb/m2s_channel} -radix hexadecimal /protocol_model_tb/m2s_channel/rdclk_i
add wave -noupdate -expand -label sim:/protocol_model_tb/m2s_channel/Group1 -group {Region: sim:/protocol_model_tb/m2s_channel} -radix hexadecimal /protocol_model_tb/m2s_channel/rdreq_i
add wave -noupdate -expand -label sim:/protocol_model_tb/m2s_channel/Group1 -group {Region: sim:/protocol_model_tb/m2s_channel} -radix hexadecimal /protocol_model_tb/m2s_channel/q_o
add wave -noupdate -expand -label sim:/protocol_model_tb/m2s_channel/Group1 -group {Region: sim:/protocol_model_tb/m2s_channel} -radix hexadecimal /protocol_model_tb/m2s_channel/rdempty_o
add wave -noupdate -expand -label sim:/protocol_model_tb/m2s_channel/Group1 -group {Region: sim:/protocol_model_tb/m2s_channel} -radix hexadecimal /protocol_model_tb/m2s_channel/rdusedw_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3833214 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 375
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
WaveRestoreZoom {0 ps} {21 us}
