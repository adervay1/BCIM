set_global_assignment -entity "avalon_mm_sim_block" -library "lib_avalon_mm_sim_block" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "avalon_mm_sim_block" -library "lib_avalon_mm_sim_block" -name IP_TOOL_VERSION "15.0"
set_global_assignment -entity "avalon_mm_sim_block" -library "lib_avalon_mm_sim_block" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_avalon_mm_sim_block" -name SPD_FILE [file join $::quartus(sip_path) "../avalon_mm_sim_block.spd"]
set_global_assignment -library "lib_avalon_mm_sim_block" -name MISC_FILE [file join $::quartus(sip_path) "../../avalon_mm_sim_block.qsys"]

set_global_assignment -library "lib_avalon_mm_sim_block" -name MISC_FILE [file join $::quartus(sip_path) "avalon_mm_sim_block.v"]
set_global_assignment -library "lib_avalon_mm_sim_block" -name MISC_FILE [file join $::quartus(sip_path) "submodules/verbosity_pkg.sv"]
set_global_assignment -library "lib_avalon_mm_sim_block" -name MISC_FILE [file join $::quartus(sip_path) "submodules/avalon_mm_pkg.sv"]
set_global_assignment -library "lib_avalon_mm_sim_block" -name MISC_FILE [file join $::quartus(sip_path) "submodules/avalon_utilities_pkg.sv"]
set_global_assignment -library "lib_avalon_mm_sim_block" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_mm_master_bfm.sv"]
