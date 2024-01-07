onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /compact_AES_tb/prime_datapath_inst/ram_model_inst/mem
add wave -noupdate /compact_AES_tb/prime_datapath_inst/rw_control_inst/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {42126000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 556
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {16739149245 ps} {41843912145 ps}
