quit -sim 

# Files needed for Simulation
vcom Rechnerarchitektur/UE_3_ALU/alu_package.vhd
vcom Rechnerarchitektur/UE_3_ALU/half_adder_ea.vhd
vcom Rechnerarchitektur/UE_3_ALU/full_adder_ea.vhd
vcom Rechnerarchitektur/UE_3_ALU/cr_adder_ea.vhd

vcom Rechnerarchitektur/UE_4_Counter/ff_ea_bhv.vhd
vcom Rechnerarchitektur/UE_4_Counter/n_bit_1_mux_ea.vhd
vcom Rechnerarchitektur/UE_4_Counter/counter_ea_struct.vhd
vcom Rechnerarchitektur/UE_4_Counter/testbench.vhd


# Start Simulation
vsim -voptargs="\+acc" -t ps testbench -wlf testbench_sim.wlf

# Label
add wave -divider Inputs

add wave -noupdate  -radix symbolic /testbench/clk
add wave -noupdate -color {Red} -radix symbolic /testbench/reset
add wave -noupdate -color {Cornflower Blue} -radix symbolic /testbench/up

# Label
add wave -divider Outputs

add wave -noupdate -radix unsigned /testbench/y_a
add wave -noupdate -radix unsigned /testbench/y_b

run 15 ns
# Set Zoom Level {from ms} {to ms}
WaveRestoreZoom {0 us} {15 ns}