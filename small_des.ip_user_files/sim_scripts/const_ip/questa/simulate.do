onbreak {quit -f}
onerror {quit -f}

vsim -scasyncupdate  -lib xil_defaultlib const_ip_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

log -r /*

do {const_ip.udo}

run 1000ns

quit -force
