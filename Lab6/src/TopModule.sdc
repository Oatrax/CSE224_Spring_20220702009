
set_units -time ns -capacitance pF -resistance ohm -voltage V

create_clock [get_ports clk] -name core_clock -period 10

set_input_delay 2.0 -clock core_clock [get_ports {BtnL BtnR}]

set_output_delay 2.0 -clock core_clock [get_ports {seg[*] an[*]}]

set_drive 2.0 [get_ports {BtnL BtnR}]

set_load 0.5 [get_ports {seg[*] an[*]}]

set_max_fanout 5 [all_designs]

set_clock_groups -asynchronous -group [get_clocks core_clock]
