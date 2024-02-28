vlib work
vlog  RAM_package.sv RAM_if.sv RAM_top.sv MONITOR_if.sv RAM_tb_if.sv ram.sv +cover
vsim -voptargs=+acc work.RAM_top -cover
add wave -position insertpoint  \
sim:/RAM_top/RAMif/clk \
sim:/RAM_top/RAMif/rx_valid \
sim:/RAM_top/RAMif/rst_n \
sim:/RAM_top/RAMif/din \
sim:/RAM_top/RAMif/tx_valid \
sim:/RAM_top/RAMif/dout
add wave -position insertpoint  \
sim:/RAM_top/dut/mem 
coverage save RAM_TOP.ucdb -onexit
run -all