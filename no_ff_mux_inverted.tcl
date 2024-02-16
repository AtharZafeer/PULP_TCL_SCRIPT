current_instance D_FLIPFLOP


set reg_count [llength [lindex [all_ffs]]]

set reg_list [lindex [all_ffs]]

set input_nets [get_nets -of_objects [get_pins -of_objects $reg_list -filter {REF_PIN_NAME=~D}]]

current_instance

for {set x 0} {$x< $reg_count} {incr x} { create_cell -reference MUXF7 [lindex $reg_list $x]_mux }

for {set x 0} {$x< $reg_count} {incr x} { create_net [lindex $reg_list $x]_mux_sel [lindex $reg_list $x]_muxO_Din }


#connect the data net to the input of fdre and i0 of mux
for {set x 0} {$x< $reg_count} {incr x} { connect_net -hierarchical -net [get_nets [lindex $input_nets $x]] -objects [list [get_pins -of_objects [get_cells [lindex $reg_list $x]_mux] -filter {REF_PIN_NAME=~I0}] [get_pins -of_objects [get_cells [lindex $reg_list $x]_mux] -filter {REF_PIN_NAME=~I1}] }

#disconnect the data net to the input of the q_reg inorder to connect the output of mux/O to input of q_reg/D
for {set x 0} {$x< $reg_count} {incr x} { disconnect_net -net [get_nets [lindex $input_nets $x]]  -objects [list [get_pins -of_objects [lindex $reg_list $x] -filter {REF_PIN_NAME=~D}] ] }

#connect the output port of mux/O to the input port of q_reg/D
for {set x 0} {$x< $reg_count} {incr x} { connect_net -net [get_nets [lindex $reg_list $x]_muxO_Din]  -objects [list [get_pins -of_objects [lindex $reg_list $x] -filter {REF_PIN_NAME=~D}] [get_pins -of_objects [get_cells [lindex $reg_list $x]_mux] -filter {REF_PIN_NAME=~O}]] } 

#connect the mux_sel net to mux/S pin
for {set x 0} {$x< $reg_count} {incr x} { connect_net -hierarchical -net [get_nets [lindex $reg_list $x]_mux_sel] -objects [list [get_pins -of_objects [get_cells [lindex $reg_list $x]_mux] -filter {REF_PIN_NAME=~S}] ] }

for {set x 0} {$x< $reg_count} {incr x} { set_property IS_INVERTED 1 [get_pins -of_objects [get_cells [lindex $reg_list $x]_mux] -filter {REF_PIN_NAME =~I1}] }

#disconnect the FI module's output port
remove_net [get_nets -of_objects [get_pins -of_objects [get_cells fault_injector] -filter {REF_PIN_NAME=~FI_out**}]]

#connect the output of FI module to the mux_sel_pin
for {set x 0} {$x< $reg_count} {incr x} {connect_net -hierarchical -net [get_nets [lindex $reg_list $x]_mux_sel] -objects [list [get_pins -of_objects [get_cells fault_injector] -filter {REF_PIN_NAME=~FI_out[**}]]  }

