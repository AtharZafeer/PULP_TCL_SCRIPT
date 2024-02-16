current_instance D_FLIPFLOP


set reg_count [llength [lindex [all_ffs]]]

set reg_list [lindex [all_ffs]]

set input_nets [get_nets -of_objects [get_pins -of_objects $reg_list -filter {REF_PIN_NAME=~D}]]

current_instance

for {set x 0} {$x< $reg_count} {incr x} { create_cell -reference FDRE [lindex $reg_list $x]_fdre }

for {set x 0} {$x< $reg_count} {incr x} { create_cell -reference MUXF7 [lindex $reg_list $x]_mux }

for {set x 0} {$x<$reg_count} {incr x} { create_cell -reference AND2B1L [lindex $reg_list $x]_and }

for {set x 0} {$x< $reg_count} {incr x} { create_net [lindex $reg_list $x]_mux_sel [lindex $reg_list $x]_muxO_Din [lindex $reg_list $x]_FDREQ_AND [lindex $reg_list $x]_ANDO_MUXI1 }

#connect net from output of and to DI of mux
for {set x 0} {$x< $reg_count} {incr x} { connect_net -hierarchical -net [get_nets [lindex $reg_list $x]_FDREQ_AND] -objects  [list [get_pins -of_objects [get_cells [lindex $reg_list $x]_fdre] -filter {REF_PIN_NAME =~Q}] [get_pins -of_objects [get_cells [lindex $reg_list $x]_and] -filter {REF_PIN_NAME =~DI}]] }

#connect net from output FDRE to AND_SRI
for {set x 0} {$x< $reg_count} {incr x} { connect_net -hierarchical -net [get_nets [lindex $reg_list $x]_FDREQ_AND] -objects  [list [get_pins -of_objects [get_cells [lindex $reg_list $x]_and] -filter {REF_PIN_NAME =~SRI}]] }

for {set x 0} {$x< $reg_count} {incr x} { connect_net -hierarchical -net [get_nets [lindex $reg_list $x]_ANDO_MUXI1] -objects  [list [get_pins -of_objects [get_cells [lindex $reg_list $x]_and] -filter {REF_PIN_NAME =~O}] [get_pins -of_objects [get_cells [lindex $reg_list $x]_mux] -filter {REF_PIN_NAME =~I1}]] }

#connect the data net to the input of fdre and i0 of mux
for {set x 0} {$x< $reg_count} {incr x} { connect_net -hierarchical -net [get_nets [lindex $input_nets $x]] -objects [list [get_pins -of_objects [get_cells [lindex $reg_list $x]_mux] -filter {REF_PIN_NAME=~I0}] [get_pins -of_objects [get_cells [lindex $reg_list $x]_fdre] -filter {REF_PIN_NAME =~D}]] }

#disconnect the data net to the input of the q_reg inorder to connect the output of mux/O to input of q_reg/D
for {set x 0} {$x< $reg_count} {incr x} { disconnect_net -net [get_nets [lindex $input_nets $x]]  -objects [list [get_pins -of_objects [lindex $reg_list $x] -filter {REF_PIN_NAME=~D}] ] }

#connect the output port of mux/O to the input port of q_reg/D
for {set x 0} {$x< $reg_count} {incr x} { connect_net -net [get_nets [lindex $reg_list $x]_muxO_Din]  -objects [list [get_pins -of_objects [lindex $reg_list $x] -filter {REF_PIN_NAME=~D}] [get_pins -of_objects [get_cells [lindex $reg_list $x]_mux] -filter {REF_PIN_NAME=~O}]] } 

#connect the clock to the fdre/C
for {set x 0} {$x< $reg_count} {incr x} {  connect_net -hierarchical -net [get_nets -of_objects [get_pins -of_objects [lindex $reg_list $x] -filter {REF_PIN_NAME=~C}]] -objects [list [get_pins -of_objects [get_cells [lindex $reg_list $x]_fdre] -filter {REF_PIN_NAME =~C}]] }

#connect rst pin to rst
for {set x 0} {$x< $reg_count} {incr x} { connect_net -hierarchical -net [get_nets -of_objects [get_pins -of_objects [lindex $reg_list $x] -filter {REF_PIN_NAME=~CLR || REF_PIN_NAME=~R}]] -objects [list [get_pins -of_objects [get_cells [lindex $reg_list $x]_fdre] -filter {REF_PIN_NAME =~R}]] }

#connect the mux_sel net to mux/S pin and FDRE/CE pin for data propagation purposes
for {set x 0} {$x< $reg_count} {incr x} { connect_net -hierarchical -net [get_nets [lindex $reg_list $x]_mux_sel] -objects [list [get_pins -of_objects [get_cells [lindex $reg_list $x]_mux] -filter {REF_PIN_NAME=~S}] [get_pins -of_objects [get_cells [lindex $reg_list $x]_fdre] -filter {REF_PIN_NAME =~CE}]] }

#make FDRE/D and FDRE/R inverted to make it work as per our logic
for {set x 0} {$x< $reg_count} {incr x} { set_property IS_INVERTED 1 [get_pins -of_objects [get_cells [lindex $reg_list $x]_and] -filter {REF_PIN_NAME =~DI}] }


for {set x 0} {$x< $reg_count} {incr x} { set_property IS_INVERTED 1 [get_pins -of_objects [get_cells [lindex $reg_list $x]_and] -filter {REF_PIN_NAME =~SRI}] }

