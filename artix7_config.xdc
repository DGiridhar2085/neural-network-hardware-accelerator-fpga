## =========================================================
## Artix-7 Configuration and Voltage Constraint File
## =========================================================

# Configuration Bank Voltage Select
# CFGBVS can be set to VCCO or GND. For most Artix-7 boards, use VCCO.
set_property CFGBVS VCCO [current_design]

# Configuration Voltage (in volts)
# Commonly 3.3V for Artix-7 boards (Basys 3, Nexys A7, Arty A7)
set_property CONFIG_VOLTAGE 3.3 [current_design]

## =========================================================
## (Optional) Example I/O Standard for default pins
## Uncomment and adjust according to your design needs
##
## set_property IOSTANDARD LVCMOS33 [get_ports {clk}]
## set_property PACKAGE_PIN W5 [get_ports {clk}]
##
## set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
## set_property PACKAGE_PIN U16 [get_ports {led[0]}]
## =========================================================
