#step 1: get the number of registers and save it in a variable
#step 2: get the nets that are connected to the input and ouput of each registers
#step 3: create 1 mux for each register named after the register's name_mux
#step 4: create 2 and gate for each register named after register's name and1 and and2
#step 5: create 1 OR gate for each register named after register's name_or
#step 6: create 5 nets for each register named: reg_name_net_1,2,3,4,5. each name specifying a point it is connected (will create documentation0
#step 7: connect the 5 created nets to their respective generated logic gates. 
#step 8: connect the input to the respective logic gates
#step 9: disconnect the input date from the register.
#step 10: ground the input of S to the and gate to make it work like a normal register for now.    
#get_nets -of_objects [get_pins -of_objects [lindex [all_registers -cells] 0] -filter {REF_PIN_NAME=~Q}]
#set registers [llength [all_registers -output_pins ]]

set reg_count [llength [lindex [all_ffs]]]

set reg_list [lindex [all_ffs]]

for {set x 0} {$x<$reg_count} {incr x} { create_cell -reference MUXF7 [lindex $reg_list $x]_mux }

set input_nets [get_nets -of_objects [get_pins -of_objects $reg_list -filter {REF_PIN_NAME=~D}]]

for {set x 0} {$x<$reg_count} {incr x} { create_cell -reference AND2B1L [lindex $reg_list $x]_and1 [lindex $reg_list $x]_and2 }


for {set x 0} {$x<$reg_count} {incr x} { create_net  [lindex $reg_list $x]_and1or_net [lindex $reg_list $x]_and2or_net [lindex $reg_list $x]_muxo2d_net [lindex $reg_list $x]_mux_sel_net [lindex $reg_list $x]_or2mux_net}

for {set x 0} {$x<$reg_count} {incr x} { create_cell -reference OR2L [lindex $reg_list $x]_OR }

##for {set x 0} {$x< $reg_count} {incr x} { connect_net -net [get_nets [lindex $reg_list 1]_muxo2d_net] -objects  [list [get_pins -of_objects [lindex $reg_list $x] -filter {REF_PIN_NAME=~D}] [get_pins -of_objects [get_cells [lindex $reg_list $x]_mux] -filter {REF_PIN_NAME =~O}] ]}

#connect the output of OR gate to the input I1 of MUX
for {set x 0} {$x< $reg_count} {incr x} { connect_net -hierarchical -net [get_nets [lindex $reg_list $x]_or2mux_net] -objects  [list [get_pins -of_objects [get_cells [lindex $reg_list $x]_OR] -filter {REF_PIN_NAME =~O}] [get_pins -of_objects [get_cells [lindex $reg_list $x]_mux] -filter {REF_PIN_NAME =~I1}]]}

##connect the output of AND gate 1 to the input DI of ORGATE
for {set x 0} {$x< $reg_count} {incr x} { connect_net -net [get_nets [lindex $reg_list $x]_and1or_net] -objects  [list [get_pins -of_objects [get_cells [lindex $reg_list $x]_and1] -filter {REF_PIN_NAME =~O}] [get_pins -of_objects [get_cells [lindex $reg_list $x]_OR] -filter {REF_PIN_NAME =~DI}]]}

##connect the output of AND gate 2 to the input SRI of ORGATE
for {set x 0} {$x< $reg_count} {incr x} { connect_net -net [get_nets [lindex $reg_list $x]_and2or_net] -objects  [list [get_pins -of_objects [get_cells [lindex $reg_list $x]_and2] -filter {REF_PIN_NAME =~O}] [get_pins -of_objects [get_cells [lindex $reg_list $x]_OR] -filter {REF_PIN_NAME =~SRI}]]}

#change the below to use mux_sel_net connect the DI and SRI of both and gates together, along witth mux
for {set x 0} {$x< $reg_count} {incr x} { connect_net -net [get_nets [lindex $reg_list $x]_mux_sel_net] -objects  [list [get_pins -of_objects [get_cells [lindex $reg_list $x]_and1] -filter {REF_PIN_NAME =~SRI}] [get_pins -of_objects [get_cells [lindex $reg_list $x]_and2] -filter {REF_PIN_NAME =~DI}] [get_pins -of_objects [get_cells [lindex $reg_list $x]_mux] -filter {REF_PIN_NAME =~S}]]}


#connect the data_net to the inputs of AND_gates and also to mux
for {set x 0} {$x< $reg_count} {incr x} { connect_net -net [get_nets [lindex $input_nets $x]] -objects [list [get_pins -of_objects [get_cells [lindex $reg_list $x]_mux] -filter {REF_PIN_NAME=~I0}] [get_pins -of_objects [get_cells [lindex $reg_list $x]_and1] -filter {REF_PIN_NAME=~DI}] [get_pins -of_objects [get_cells [lindex $reg_list $x]_and2] -filter {REF_PIN_NAME=~SRI}]]}

#disconnect the input to the FDCE
for {set x 0} {$x< $reg_count} {incr x} { disconnect_net -net [get_nets [lindex $input_nets $x]]  -objects [list [get_pins -of_objects [lindex $reg_list $x] -filter {REF_PIN_NAME=~D}]] }

#connect the output of the mux to the input of the FDCE
for {set x 0} {$x< $reg_count} {incr x} { connect_net -net [get_nets [lindex $reg_list $x]_muxo2d_net]  -objects [list [get_pins -of_objects [lindex $reg_list $x] -filter {REF_PIN_NAME=~D}] [get_pins -of_objects [get_cells [lindex $reg_list $x]_mux] -filter {REF_PIN_NAME=~O}] ] }

#create a port
create_port -direction INOUT  -from 0 -to $reg_count made_up_gnd_port
#connect net to the port
for {set x 0} {$x< $reg_count} {incr x} { connect_net -hierarchical -net [get_nets [lindex $reg_list $x]_mux_sel_net] -objects [get_ports made_up_gnd_port[$x]]}

for {set x 0} {$x< $reg_count} {incr x} { set_property PULLDOWN TRUE [get_ports made_up_gnd_port[$x]]}


#///////////////////////////////////////////////////////////////////////////// worked till here////////////////////////////////////////////////
#////////////////////////////////////////////////////////////////////////below is experimental///////////////////////////////////////////////////////////

for {set x 0} {$x< $reg_count} {incr x} { set_logic_one [get_ports made_up_gnd_port[$x]]}

#connect the select pin of both and gate and mux to the ground
for {set x 0} {$x< $reg_count} {incr x} { create_cell -reference PULLDOWN [lindex $reg_list $x]_GND_port }

#
for {set x 0} {$x< $reg_count} {incr x} { connect_net -net [get_nets [lindex $reg_list $x]_mux_sel_net] -objects [list [get_ports made_up_gnd_port[$x]]]}



//
get_nets -of_objects  [get_pins -of_objects [lindex $reg_list 1] -filter {REF_PIN_NAME=~D}] /get ff D net

for {set x 0} {$x<$reg_count} {incr x} { puts [get_pins -of_objects [get_cells [lindex $reg_list $x]_mux] -filter {REF_PIN_NAME =~O}] }
get_pins -of_objects [get_cells ff_0/q_reg[5]_and1] -filter {REF_PIN_NAME =~O }

for {set x 0} {$x< $reg_count} {incr x} { connect_net -net [get_nets [lindex $reg_list $x]_muxo2d_net] -objects [list [get_pins -of_objects [get_cells [lindex $reg_list $x]_mux -filter {REF_PIN_NAME =~O }]] [get_pins -of_objects [get_cells [lindex $reg_list $x] -filter {REF_PIN_NAME =~D }] ]] }

for {set x 0} {$x< $reg_count} {incr x} { connect_net -net [get_nets [lindex $reg_list $x]_muxo2d_net] -objects [list [get_pins -of_objects [lindex $reg_list $x] -filter {REF_PIN_NAME=~D}]]


for {set x 0} {$x< $reg_count} {incr x} { connect_net -net [get_nets [lindex $reg_list $x]_or2mux_net] -objects  [list [get_pins -of_objects [get_cells [lindex $reg_list $x]_OR] -filter {REF_PIN_NAME =~O}] [get_pins -of_objects [get_cells [lindex $reg_list $x]_mux] -filter {REF_PIN_NAME =~I1}]]}

