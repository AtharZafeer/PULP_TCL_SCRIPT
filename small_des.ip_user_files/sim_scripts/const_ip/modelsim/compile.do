vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xlconstant_v1_1_8
vlib modelsim_lib/msim/xil_defaultlib

vmap xlconstant_v1_1_8 modelsim_lib/msim/xlconstant_v1_1_8
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xlconstant_v1_1_8 -64 -incr -mfcu  \
"../../../../small_des.gen/sources_1/bd/const_ip/ipshared/d390/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  \
"../../../bd/const_ip/ip/const_ip_xlconstant_0_0/sim/const_ip_xlconstant_0_0.v" \
"../../../bd/const_ip/sim/const_ip.v" \

vlog -work xil_defaultlib \
"glbl.v"

