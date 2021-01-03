# VGA board calibration

Before turning power on, make sure trimmer resistors RV1 to RV2 are in the middle position (they usually come from the factory like that). Otherwise U21 or/and D1 could be damaged because current would not be limited.

To calibrate color channels:
1. Load any program which doesn't touch video RAM into the program ROM. Do not connect the monitor!
2. Turn the power on.
3. Connect a 75 Ohm resistor between pins 1 (red) and 6 (ground) of the VGA connector to simulate the monitor.
4. Connect an oscilloscope across the resisor.
5. Observe the signal. There should be periodic brusts of random noise. Adjust RV5 and RV6 so that peak-to-peak would be 0.7 V and the smaller peaks (dim colors) are approximately 0.35 V.
6. Repeat steps 3-6 for the other two channels, adjusting RV3 and RV4 for green and RV1 and RV2 for blue.
7. Now it is safe to connect a monitor.
