transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+const_ip  -L xlconstant_v1_1_8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.const_ip xil_defaultlib.glbl

do {const_ip.udo}

run 1000ns

endsim

quit -force
