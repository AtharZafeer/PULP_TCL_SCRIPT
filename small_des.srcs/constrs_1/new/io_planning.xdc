#set_property PULLTYPE PULLDOWN [get_ports q]




create_clock -period 10.000 -name clk -waveform {0.000 5.000} -add [get_ports clk]


set_property MARK_DEBUG true [get_nets q_i_1_n_0]
set_property MARK_DEBUG true [get_nets q_reg_mux_sel]
set_property MARK_DEBUG true [get_nets q_reg_FDREQ_MUXI]
set_property MARK_DEBUG true [get_nets q_i_2_n_0]
set_property MARK_DEBUG true [get_nets clk_IBUF_BUFG]
set_property PULLTYPE PULLDOWN [get_ports {made_up_gnd_port[0]}]
