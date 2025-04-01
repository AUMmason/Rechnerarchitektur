quit -sim 

# Files needed for Simulation
vcom Rechnerarchitektur/UE_3_ALU/alu_package.vhd
vcom Rechnerarchitektur/UE_3_ALU/half_adder_ea.vhd
vcom Rechnerarchitektur/UE_3_ALU/full_adder_ea.vhd
vcom Rechnerarchitektur/UE_3_ALU/cr_adder_ea.vhd
vcom Rechnerarchitektur/UE_3_ALU/mux_1_ea.vhd
vcom Rechnerarchitektur/UE_3_ALU/m_bit_n_mux_ea.vhd
vcom Rechnerarchitektur/UE_3_ALU/alu_ea_struct.vhd
vcom Rechnerarchitektur/UE_3_ALU/testbench.vhd

# Start Simulation
vsim -voptargs="\+acc" -t ns testbench -wlf testbench_sim.wlf

# Label
add wave -divider Inputs

add wave -noupdate -color {Cornflower Blue} -radix symbolic /testbench/f
add wave -noupdate -color {Cornflower Blue} -radix hexadecimal /testbench/a
add wave -noupdate -color {Cornflower Blue} -radix hexadecimal /testbench/b

# Label
add wave -divider Outputs

add wave -noupdate -radix hexadecimal /testbench/y
add wave -noupdate -radix symbolic /testbench/neg

run 100 us
# Set Zoom Level {from ms} {to ms}
WaveRestoreZoom {0 us} {1 us}