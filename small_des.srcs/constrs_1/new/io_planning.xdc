set_property PULLTYPE PULLDOWN [get_ports q]



set_property MARK_DEBUG true [get_nets clk_IBUF_BUFG]
#set_property FIXED_ROUTE { { CLK_BUFGCE_58_CLK_OUT CLK_CMT_MUX_16_ENC_16_CLK_OUT CLK_CMT_MUX_2TO1_132_CLK_OUT CLK_CMT_MUX_2TO1_129_CLK_OUT CLK_HDISTR_0_16 <18>CLK_LEAF_SITES_10_CLK_IN CLK_LEAF_SITES_10_CLK_LEAF <3>INT_NODE_GLOBAL_5_INT_OUT1 CTRL_W4 }  } [get_nets clk_IBUF_BUFG]
set_property BEL DFF2 [get_cells q_reg]
set_property LOC SLICE_X96Y237 [get_cells q_reg]
set_property BEL BUFCE [get_cells clk_IBUF_BUFG_inst]
set_property LOC BUFGCE_X0Y88 [get_cells clk_IBUF_BUFG_inst]

create_clock -period 10.000 -name clk -waveform {0.000 4.000} [get_ports clk]
set_input_delay -clock [get_clocks *] 5.000 [get_ports {clear d rst}]
set_output_delay -clock [get_clocks *] 4.000 [get_ports -filter { NAME =~  "*" && DIRECTION == "OUT" }]

set_logic_one [get_ports {made_up_gnd_port[0]}]
set_logic_zero [get_ports {made_up_gnd_port[0]}]
set_logic_zero [get_ports {made_up_gnd_port[0]}]
set_logic_zero [get_ports {made_up_gnd_port[0]}]
set_logic_zero [get_ports {made_up_gnd_port[1]}]

set_property PULLTYPE PULLDOWN [get_ports {made_up_gnd_port[0]}]
connect_debug_port u_ila_0/probe0 [get_nets [list q_reg_muxo2d_net]]
connect_debug_port u_ila_0/probe1 [get_nets [list q_reg_or2mux_net]]
connect_debug_port u_ila_0/probe2 [get_nets [list q_reg_and1or_net]]
connect_debug_port u_ila_0/probe3 [get_nets [list q_reg_and2or_net]]
connect_debug_port u_ila_0/probe4 [get_nets [list q_reg_mux_sel_net]]

set_property PULLTYPE PULLDOWN [get_ports {made_up_gnd_port[0]}]

set_property PULLTYPE PULLDOWN [get_ports {made_up_gnd_port[0]}]
set_property MARK_DEBUG true [get_nets q_i_1_n_0]
set_property MARK_DEBUG true [get_nets q_reg_mux_sel_net]
set_property PULLTYPE PULLDOWN [get_ports {made_up_gnd_port[1]}]
create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 2 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list clk_IBUF_BUFG]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 1 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list clk_IBUF_BUFG]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 1 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list q_i_1_n_0]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 1 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list q_reg_mux_sel_net]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 1 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list q_reg_and1or_net]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 1 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list q_reg_and2or_net]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 1 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list q_reg_muxo2d_net]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 1 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list q_reg_or2mux_net]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk_IBUF_BUFG]
