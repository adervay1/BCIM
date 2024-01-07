#sim.do
vlib work

vlog altera_mf.v
vlog ram_model.sv


#Source
vlog ../../CIMulator/src/arithmetic/parallel_gf_mult.sv
vlog ../../CIMulator/src/arithmetic/serial_add.sv
vlog ../../CIMulator/src/arithmetic/serial_gf_mult.sv

vlog ../../CIMulator/ip/SRAM_emu/SRAM_emu.v

vlog ../../CIMulator/src/prime_datapath/prime_datapath.sv
vlog ../../CIMulator/src/prime_datapath/rw_control.sv

#Altera MM Sim Files
vlog ../Avalon_MM_BFM/avalon_mm_sim_block/simulation/submodules/verbosity_pkg.sv
vlog ../Avalon_MM_BFM/avalon_mm_sim_block/simulation/submodules/avalon_mm_pkg.sv
vlog ../Avalon_MM_BFM/avalon_mm_sim_block/simulation/submodules/avalon_utilities_pkg.sv
vlog ../Avalon_MM_BFM/avalon_mm_sim_block/simulation/submodules/altera_avalon_mm_master_bfm.sv
vlog ../Avalon_MM_BFM/avalon_mm_sim_block/simulation/avalon_mm_sim_block.v
  

#Top Level
vlog BCIM_tb.sv

view structure
vsim -t 1ps -voptargs=+acc -L work BCIM_tb

do wave.do
run -all 