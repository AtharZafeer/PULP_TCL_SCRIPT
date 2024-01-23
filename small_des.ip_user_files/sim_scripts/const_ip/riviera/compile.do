transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xlconstant_v1_1_8
vlib riviera/xil_defaultlib

vmap xlconstant_v1_1_8 riviera/xlconstant_v1_1_8
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xlconstant_v1_1_8  -incr -v2k5 -l xlconstant_v1_1_8 -l xil_defaultlib \
"../../../../small_des.gen/sources_1/bd/const_ip/ipshared/d390/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -v2k5 -l xlconstant_v1_1_8 -l xil_defaultlib \
"../../../bd/const_ip/ip/const_ip_xlconstant_0_0/sim/const_ip_xlconstant_0_0.v" \
"../../../bd/const_ip/sim/const_ip.v" \

vlog -work xil_defaultlib \
"glbl.v"

