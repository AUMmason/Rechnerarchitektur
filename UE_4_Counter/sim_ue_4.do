quit -sim 

# Files needed for Simulation
vcom Rechnerarchitektur/UE_3_ALU/alu_package.vhd
vcom Rechnerarchitektur/UE_3_ALU/half_adder_ea.vhd
vcom Rechnerarchitektur/UE_3_ALU/full_adder_ea.vhd
vcom Rechnerarchitektur/UE_3_ALU/cr_adder_ea.vhd

vcom Rechnerarchitektur/UE_4_ALU/ff_ea_bhv.vhd
vcom Rechnerarchitektur/UE_4_ALU/n_bit_1_mux.vhd
vcom Rechnerarchitektur/UE_4_ALU/counter_ea_struct.vhd
vcom Rechnerarchitektur/UE_4_ALU/testbench.vhd


# Start Simulation
vsim -voptargs="\+acc" -t ns testbench -wlf testbench_sim.wlf

# Label
add wave -divider Inputs

add wave -noupdate  -radix symbolic /testbench/clk
add wave -noupdate -color {Red} -radix symbolic /testbench/reset
add wave -noupdate -color {Cornflower Blue} -radix symbolic /testbench/up

# Label
add wave -divider Outputs

add wave -noupdate -radix symbolic /testbench/y

run 100 us
# Set Zoom Level {from ms} {to ms}
WaveRestoreZoom {0 us} {1 us}