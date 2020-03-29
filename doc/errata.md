# Control unit rev. 1
Doesn't work at all: because of undefined transition states of ROM outputs random values are written into IR, A, and B.


# Registers rev. 1
To work with control unit rev. 2, registers rev. 1 should be modified: pin 1 of U1 should be disconnected from clk and connected to ~clk. To do so, cut the track going west from pin 1 of U1 and solder pin 1 and pin 4 together using a short thin wire.


# ROM
All ROM chips used in ALU rev. 1, IO rev. 1, control unit rev. 1 have data pins D6 and D7 swapped. To workaround, use `tools/flip67.py` on the firmware files before flashing.
