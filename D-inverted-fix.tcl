#change the D_FLIPFLOP to the name of the design element  you want to add the modification to. Neccessary step! prevents you from modifying the whole design
current_instance fifo 

#get the number of flipflops in the design
set reg_count [llength [lindex [all_ffs]]] 

#get the cell names of these registers
set reg_list [lindex [all_ffs]]  

#get the nets that are connected to the inputs of these flipflops that we are modifying
set input_nets [get_nets -of_objects [get_pins -of_objects $reg_list -filter {REF_PIN_NAME=~D}]]  

#move back to the whole design
current_instance 

#create a cell which is FDRE and name it as <original_flipflop_name>_fdre
for {set x 0} {$x< $reg_count} {incr x} { create_cell -reference FDRE [lindex $reg_list $x]_fdre } 
 
 
 #create a MUXF7 Cell and name it as  <original_flipflop_name>_mux
for {set x 0} {$x< $reg_count} {incr x} { create_cell -reference MUXF7 [lindex $reg_list $x]_mux } 

#create a MUXF7 Cell and name it as  <original_flipflop_name>_mux
for {set x 0} {$x<$reg_count} {incr x} { create_cell -reference AND2B1L [lindex $reg_list $x]_and }


##create the nets that connects mux_select_pin to others,  mux output (O) to FDRE input D, FDRE (Q) output to input of AND (SRI) and AND output (O) to mux input (I1)
for {set x 0} {$x< $reg_count} {incr x} { create_net [lindex $reg_list $x]_mux_sel [lindex $reg_list $x]_muxO_Din [lindex $reg_list $x]_FDREQ_AND [lindex $reg_list $x]_ANDO_MUXI1 } 


#connect the net FDREQ_AND to the input of And gate(SRI) to the output (Q) of FDRE
for {set x 0} {$x< $reg_count} {incr x} { connect_net -hierarchical -net [get_nets [lindex $reg_list $x]_FDREQ_AND] -objects  [list [get_pins -of_objects [get_cells [lindex $reg_list $x]_and] -filter {REF_PIN_NAME =~SRI}] [get_pins -of_objects [get_cells [lindex $reg_list $x]_fdre] -filter {REF_PIN_NAME =~Q}]] } 

#connect net ANDO_MUXI1 from ANDGATE output (O) to the input of MUXF7 (I1)
for {set x 0} {$x< $reg_count} {incr x} { connect_net -hierarchical -net [get_nets [lindex $reg_list $x]_ANDO_MUXI1] -objects  [list [get_pins -of_objects [get_cells [lindex $reg_list $x]_and] -filter {REF_PIN_NAME =~O}] [get_pins -of_objects [get_cells [lindex $reg_list $x]_mux] -filter {REF_PIN_NAME =~I1}]] }

#connect the data_net to the input of FDRE(D) and input of muxf7 (I0)
for {set x 0} {$x< $reg_count} {incr x} { connect_net -hierarchical -net [get_nets [lindex $input_nets $x]] -objects [list [get_pins -of_objects [get_cells [lindex $reg_list $x]_mux] -filter {REF_PIN_NAME=~I0}] [get_pins -of_objects [get_cells [lindex $reg_list $x]_fdre] -filter {REF_PIN_NAME =~D}]] }   

#disconnect the data net from the input of q_reg (q_reg is the register we are trying to control the inputs of) 
for {set x 0} {$x< $reg_count} {incr x} { disconnect_net -net [get_nets [lindex $input_nets $x]]  -objects [list [get_pins -of_objects [lindex $reg_list $x] -filter {REF_PIN_NAME=~D}] ] }        

#connect the net muxO_Din from the output of muxF7 (O) to the input of  q_reg (D)
for {set x 0} {$x< $reg_count} {incr x} { connect_net -net [get_nets [lindex $reg_list $x]_muxO_Din]  -objects [list [get_pins -of_objects [lindex $reg_list $x] -filter {REF_PIN_NAME=~D}] [get_pins -of_objects [get_cells [lindex $reg_list $x]_mux] -filter {REF_PIN_NAME=~O}]] }  

#connect the clock of the design to the clk of fdre using the net thats already used for the clock, becareful when you have multiple clock, find the name of that and change here accordingly depending on which clock you want to use this in (this statement connects to the clock that is fed into the design, so the reference or main clock of the design.
for {set x 0} {$x< $reg_count} {incr x} {  connect_net -hierarchical -net [get_nets -of_objects [get_pins -of_objects [lindex $reg_list $x] -filter {REF_PIN_NAME=~C}]] -objects [list [get_pins -of_objects [get_cells [lindex $reg_list $x]_fdre] -filter {REF_PIN_NAME =~C}]] }      

#connect the rst_pin of fdre to the rst pin in the design, this is the same reset pin to which our q_reg is connected to.
for {set x 0} {$x< $reg_count} {incr x} { connect_net -hierarchical -net [get_nets -of_objects [get_pins -of_objects [lindex $reg_list $x] -filter {REF_PIN_NAME=~CLR || REF_PIN_NAME=~R}]] -objects [list [get_pins -of_objects [get_cells [lindex $reg_list $x]_fdre] -filter {REF_PIN_NAME =~R}]] }  

#connect the mux_sel_net to the mux select pin and FDRE/CE pin. This makes sure the newly introduced fdre can sample the data when the fault injector triggers the mux_sel_net
for {set x 0} {$x< $reg_count} {incr x} { connect_net -hierarchical -net [get_nets [lindex $reg_list $x]_mux_sel] -objects [list [get_pins -of_objects [get_cells [lindex $reg_list $x]_mux] -filter {REF_PIN_NAME=~S}] [get_pins -of_objects [get_cells [lindex $reg_list $x]_fdre] -filter {REF_PIN_NAME =~CE}] [get_pins -of_objects [get_cells [lindex $reg_list $x]_and] -filter {REF_PIN_NAME =~DI}]] }     

#discconect the output port of our fault injector since we don't need it, let it "dangle"
remove_net [get_nets -of_objects [get_pins -of_objects [get_cells fault_injector] -filter {REF_PIN_NAME=~FI_out**}]]   

#now connect the output of our Fault injector to the  mux_sel_pin
for {set x 0} {$x< $reg_count} {incr x} {connect_net -hierarchical -net [get_nets [lindex $reg_list $x]_mux_sel] -objects [list [get_pins -of_objects [get_cells fault_injector] -filter {REF_PIN_NAME=~FI_out[**}]]  }  

