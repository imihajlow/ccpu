EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A2 23386 16535
encoding utf-8
Sheet 1 3
Title "ALU module"
Date "2020-10-31"
Rev "2"
Comp ""
Comment1 "Licensed under the TAPR Open Hardware License (www.tapr.org/OHL)"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Sheet
S 2350 2850 850  950 
U 5FC3F1F0
F0 "interface" 50
F1 "interface.sch" 50
F2 "a[0..7]" O L 2350 2950 50 
F3 "b[0..7]" O L 2350 3050 50 
F4 "op[0..3]" O L 2350 3200 50 
F5 "~oe" O L 2350 3350 50 
F6 "carry_in" O L 2350 3450 50 
F7 "invert" O L 2350 3550 50 
F8 "result[0..7]" T R 3200 2950 50 
F9 "flags[0..3]" I R 3200 3050 50 
$EndSheet
Wire Bus Line
	1900 2950 2350 2950
Text Label 1900 2950 2    50   ~ 0
a[0..7]
Text Label 1900 3050 2    50   ~ 0
b[0..7]
Text Label 1900 3200 2    50   ~ 0
op[0..3]
Wire Wire Line
	2350 3350 1900 3350
Wire Wire Line
	2350 3450 1900 3450
Wire Wire Line
	1900 3550 2350 3550
Text Label 1900 3350 2    50   ~ 0
~oe
Text Label 1900 3450 2    50   ~ 0
carry_in
Text Label 1900 3550 2    50   ~ 0
invert
Wire Bus Line
	3200 2950 3450 2950
Text Label 3450 2950 0    50   ~ 0
r[0..7]
Wire Bus Line
	3200 3050 3450 3050
Text Label 3450 3050 0    50   ~ 0
flags[0..3]
$Comp
L 74xx:74LS02 U14
U 3 1 5FC47CF2
P 14400 12450
F 0 "U14" H 14400 12775 50  0000 C CNN
F 1 "MC74ACT02DTR2G" H 14400 12684 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 14400 12450 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/2032041.pdf" H 14400 12450 50  0001 C CNN
	3    14400 12450
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS02 U14
U 4 1 5FC4E346
P 14400 13000
F 0 "U14" H 14400 13325 50  0000 C CNN
F 1 "MC74ACT02DTR2G" H 14400 13234 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 14400 13000 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/2032041.pdf" H 14400 13000 50  0001 C CNN
	4    14400 13000
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS02 U14
U 1 1 5FC506A0
P 14400 13550
F 0 "U14" H 14400 13875 50  0000 C CNN
F 1 "MC74ACT02DTR2G" H 14400 13784 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 14400 13550 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/2032041.pdf" H 14400 13550 50  0001 C CNN
	1    14400 13550
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS02 U14
U 2 1 5FC52E76
P 14400 14100
F 0 "U14" H 14400 14425 50  0000 C CNN
F 1 "MC74ACT02DTR2G" H 14400 14334 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 14400 14100 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/2032041.pdf" H 14400 14100 50  0001 C CNN
	2    14400 14100
	1    0    0    -1  
$EndComp
Text Label 14100 12350 2    50   ~ 0
r0
Text Label 14100 12550 2    50   ~ 0
r1
Text Label 14100 12900 2    50   ~ 0
r2
Text Label 14100 13100 2    50   ~ 0
r3
Text Label 14100 13450 2    50   ~ 0
r4
Text Label 14100 13650 2    50   ~ 0
r5
Text Label 14100 14000 2    50   ~ 0
r6
Text Label 14100 14200 2    50   ~ 0
r7
$Comp
L 74xx:74LS08 U13
U 4 1 5FC5A01A
P 15350 13800
F 0 "U13" H 15350 14125 50  0000 C CNN
F 1 "SN74ACT08PW" H 15350 14034 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 15350 13800 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74act08.pdf" H 15350 13800 50  0001 C CNN
	4    15350 13800
	1    0    0    1   
$EndComp
Wire Wire Line
	14700 12450 14900 12450
Wire Wire Line
	14900 12450 14900 12650
Wire Wire Line
	14900 12650 15050 12650
Wire Wire Line
	15050 12850 14900 12850
Wire Wire Line
	14900 12850 14900 13000
Wire Wire Line
	14900 13000 14700 13000
Wire Wire Line
	14700 13550 14900 13550
Wire Wire Line
	14900 13550 14900 13700
Wire Wire Line
	14900 13700 15050 13700
Wire Wire Line
	14700 14100 14900 14100
Wire Wire Line
	14900 14100 14900 13900
Wire Wire Line
	14900 13900 15050 13900
$Comp
L 74xx:74LS08 U13
U 5 1 5FC6102B
P 15400 15000
F 0 "U13" H 15630 15046 50  0000 L CNN
F 1 "SN74ACT08PW" V 15150 14750 50  0000 L CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 15400 15000 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74act08.pdf" H 15400 15000 50  0001 C CNN
	5    15400 15000
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS02 U14
U 5 1 5FC677D7
P 14400 15000
F 0 "U14" H 14630 15046 50  0000 L CNN
F 1 "MC74ACT02DTR2G" V 14100 14650 50  0000 L CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 14400 15000 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/2032041.pdf" H 14400 15000 50  0001 C CNN
	5    14400 15000
	1    0    0    -1  
$EndComp
Wire Wire Line
	15650 13800 15800 13800
Wire Wire Line
	15800 13800 15800 13350
Wire Wire Line
	15800 13350 15900 13350
Wire Wire Line
	15900 13150 15800 13150
Wire Wire Line
	15800 13150 15800 12750
Wire Wire Line
	15800 12750 15650 12750
Text Label 16500 13250 0    50   ~ 0
flags0
Text Label 14900 12450 2    50   ~ 0
nor01
Text Label 14900 12850 2    50   ~ 0
nor23
Text Label 14900 13550 2    50   ~ 0
nor45
Text Label 14900 13900 2    50   ~ 0
nor67
Text Label 15800 12750 2    50   ~ 0
z03
Text Label 15800 13350 2    50   ~ 0
z47
Entry Wire Line
	3450 3250 3550 3150
Entry Wire Line
	3450 3350 3550 3250
Entry Wire Line
	3450 3450 3550 3350
Entry Wire Line
	3450 3550 3550 3450
Text Label 3700 3450 0    50   ~ 0
flags3
Wire Wire Line
	3700 3450 3550 3450
Wire Wire Line
	3700 3350 3550 3350
Wire Wire Line
	3700 3250 3550 3250
Wire Wire Line
	3700 3150 3550 3150
Text Label 3700 3350 0    50   ~ 0
flags2
Text Label 3700 3250 0    50   ~ 0
flags1
Text Label 3700 3150 0    50   ~ 0
flags0
Entry Wire Line
	3450 2750 3550 2650
Wire Wire Line
	3550 2650 3700 2650
Entry Wire Line
	3450 2650 3550 2550
Wire Wire Line
	3550 2550 3700 2550
Entry Wire Line
	3450 2550 3550 2450
Wire Wire Line
	3550 2450 3700 2450
Entry Wire Line
	3450 2450 3550 2350
Wire Wire Line
	3550 2350 3700 2350
Entry Wire Line
	3450 2350 3550 2250
Wire Wire Line
	3550 2250 3700 2250
Entry Wire Line
	3450 2250 3550 2150
Wire Wire Line
	3550 2150 3700 2150
Entry Wire Line
	3450 2150 3550 2050
Wire Wire Line
	3550 2050 3700 2050
Entry Wire Line
	3450 2050 3550 1950
Wire Wire Line
	3550 1950 3700 1950
Text Label 3700 1950 0    50   ~ 0
r0
Text Label 3700 2050 0    50   ~ 0
r1
Text Label 3700 2150 0    50   ~ 0
r2
Text Label 3700 2250 0    50   ~ 0
r3
Text Label 3700 2350 0    50   ~ 0
r4
Text Label 3700 2450 0    50   ~ 0
r5
Text Label 3700 2550 0    50   ~ 0
r6
Text Label 3700 2650 0    50   ~ 0
r7
Wire Wire Line
	1600 2450 1800 2450
Entry Wire Line
	1800 2450 1900 2350
Wire Wire Line
	1600 2350 1800 2350
Entry Wire Line
	1800 2350 1900 2250
Wire Wire Line
	1600 2250 1800 2250
Entry Wire Line
	1800 2250 1900 2150
Wire Wire Line
	1600 2150 1800 2150
Entry Wire Line
	1800 2150 1900 2050
Wire Wire Line
	1600 2050 1800 2050
Entry Wire Line
	1800 2050 1900 1950
Wire Wire Line
	1600 1950 1800 1950
Entry Wire Line
	1800 1950 1900 1850
Wire Wire Line
	1600 1850 1800 1850
Entry Wire Line
	1800 1850 1900 1750
Wire Wire Line
	1600 1750 1800 1750
Entry Wire Line
	1800 1750 1900 1650
Wire Wire Line
	950  2450 1150 2450
Entry Wire Line
	1150 2450 1250 2350
Wire Wire Line
	950  2350 1150 2350
Entry Wire Line
	1150 2350 1250 2250
Wire Wire Line
	950  2250 1150 2250
Entry Wire Line
	1150 2250 1250 2150
Wire Wire Line
	950  2150 1150 2150
Entry Wire Line
	1150 2150 1250 2050
Wire Wire Line
	950  2050 1150 2050
Entry Wire Line
	1150 2050 1250 1950
Wire Wire Line
	950  1950 1150 1950
Entry Wire Line
	1150 1950 1250 1850
Wire Wire Line
	950  1850 1150 1850
Entry Wire Line
	1150 1850 1250 1750
Wire Wire Line
	950  1750 1150 1750
Entry Wire Line
	1150 1750 1250 1650
Wire Bus Line
	1250 3050 2350 3050
Text Label 1600 1750 2    50   ~ 0
a0
Text Label 1600 1850 2    50   ~ 0
a1
Text Label 1600 1950 2    50   ~ 0
a2
Text Label 1600 2050 2    50   ~ 0
a3
Text Label 1600 2150 2    50   ~ 0
a4
Text Label 1600 2250 2    50   ~ 0
a5
Text Label 1600 2350 2    50   ~ 0
a6
Text Label 1600 2450 2    50   ~ 0
a7
Text Label 950  1750 2    50   ~ 0
b0
Text Label 950  1850 2    50   ~ 0
b1
Text Label 950  1950 2    50   ~ 0
b2
Text Label 950  2050 2    50   ~ 0
b3
Text Label 950  2150 2    50   ~ 0
b4
Text Label 950  2250 2    50   ~ 0
b5
Text Label 950  2350 2    50   ~ 0
b6
Text Label 950  2450 2    50   ~ 0
b7
Wire Wire Line
	950  4100 1150 4100
Entry Wire Line
	1150 4100 1250 4000
Wire Wire Line
	950  4000 1150 4000
Entry Wire Line
	1150 4000 1250 3900
Wire Wire Line
	950  3900 1150 3900
Entry Wire Line
	1150 3900 1250 3800
Wire Wire Line
	950  3800 1150 3800
Entry Wire Line
	1150 3800 1250 3700
Wire Bus Line
	1250 3200 2350 3200
Text Label 950  3800 2    50   ~ 0
op0
Text Label 950  3900 2    50   ~ 0
op1
Text Label 950  4000 2    50   ~ 0
op2
Text Label 950  4100 2    50   ~ 0
op3
$Comp
L power:GND #PWR060
U 1 1 5FCDA9D5
P 15400 15500
F 0 "#PWR060" H 15400 15250 50  0001 C CNN
F 1 "GND" H 15405 15327 50  0000 C CNN
F 2 "" H 15400 15500 50  0001 C CNN
F 3 "" H 15400 15500 50  0001 C CNN
	1    15400 15500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR058
U 1 1 5FCDB0CA
P 14400 15500
F 0 "#PWR058" H 14400 15250 50  0001 C CNN
F 1 "GND" H 14405 15327 50  0000 C CNN
F 2 "" H 14400 15500 50  0001 C CNN
F 3 "" H 14400 15500 50  0001 C CNN
	1    14400 15500
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR059
U 1 1 5FCDC538
P 15400 14500
F 0 "#PWR059" H 15400 14350 50  0001 C CNN
F 1 "VCC" H 15417 14673 50  0000 C CNN
F 2 "" H 15400 14500 50  0001 C CNN
F 3 "" H 15400 14500 50  0001 C CNN
	1    15400 14500
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR057
U 1 1 5FCDC9EB
P 14400 14500
F 0 "#PWR057" H 14400 14350 50  0001 C CNN
F 1 "VCC" H 14417 14673 50  0000 C CNN
F 2 "" H 14400 14500 50  0001 C CNN
F 3 "" H 14400 14500 50  0001 C CNN
	1    14400 14500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 5FCDDC90
P 22600 12800
F 0 "C2" H 22715 12846 50  0000 L CNN
F 1 "0.1u" H 22715 12755 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 22638 12650 50  0001 C CNN
F 3 "~" H 22600 12800 50  0001 C CNN
	1    22600 12800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR079
U 1 1 5FCDE2E2
P 22600 12950
F 0 "#PWR079" H 22600 12700 50  0001 C CNN
F 1 "GND" H 22605 12777 50  0000 C CNN
F 2 "" H 22600 12950 50  0001 C CNN
F 3 "" H 22600 12950 50  0001 C CNN
	1    22600 12950
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR078
U 1 1 5FCDE648
P 22600 12650
F 0 "#PWR078" H 22600 12500 50  0001 C CNN
F 1 "VCC" H 22617 12823 50  0000 C CNN
F 2 "" H 22600 12650 50  0001 C CNN
F 3 "" H 22600 12650 50  0001 C CNN
	1    22600 12650
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 5FCE7A23
P 22200 12800
F 0 "C1" H 22315 12846 50  0000 L CNN
F 1 "0.1u" H 22315 12755 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 22238 12650 50  0001 C CNN
F 3 "~" H 22200 12800 50  0001 C CNN
	1    22200 12800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR077
U 1 1 5FCE7A29
P 22200 12950
F 0 "#PWR077" H 22200 12700 50  0001 C CNN
F 1 "GND" H 22205 12777 50  0000 C CNN
F 2 "" H 22200 12950 50  0001 C CNN
F 3 "" H 22200 12950 50  0001 C CNN
	1    22200 12950
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR076
U 1 1 5FCE7A2F
P 22200 12650
F 0 "#PWR076" H 22200 12500 50  0001 C CNN
F 1 "VCC" H 22217 12823 50  0000 C CNN
F 2 "" H 22200 12650 50  0001 C CNN
F 3 "" H 22200 12650 50  0001 C CNN
	1    22200 12650
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H2
U 1 1 5FCEA543
P 950 800
F 0 "H2" H 1050 846 50  0000 L CNN
F 1 "MountingHole" H 1050 755 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 950 800 50  0001 C CNN
F 3 "~" H 950 800 50  0001 C CNN
	1    950  800 
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H4
U 1 1 5FCEABB7
P 21900 750
F 0 "H4" H 22000 796 50  0000 L CNN
F 1 "MountingHole" H 22000 705 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 21900 750 50  0001 C CNN
F 3 "~" H 21900 750 50  0001 C CNN
	1    21900 750 
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H1
U 1 1 5FCEB2AC
P 750 15800
F 0 "H1" H 850 15846 50  0000 L CNN
F 1 "MountingHole" H 850 15755 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 750 15800 50  0001 C CNN
F 3 "~" H 750 15800 50  0001 C CNN
	1    750  15800
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H3
U 1 1 5FCEBA7B
P 18000 15800
F 0 "H3" H 18100 15846 50  0000 L CNN
F 1 "MountingHole" H 18100 15755 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 18000 15800 50  0001 C CNN
F 3 "~" H 18000 15800 50  0001 C CNN
	1    18000 15800
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C3
U 1 1 5FCF26BA
P 22200 14000
F 0 "C3" H 22318 14046 50  0000 L CNN
F 1 "10u x 6.3V" H 22318 13955 50  0000 L CNN
F 2 "Capacitor_SMD:CP_Elec_4x4.5" H 22238 13850 50  0001 C CNN
F 3 "~" H 22200 14000 50  0001 C CNN
	1    22200 14000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR081
U 1 1 5FCF28E8
P 22200 14150
F 0 "#PWR081" H 22200 13900 50  0001 C CNN
F 1 "GND" H 22205 13977 50  0000 C CNN
F 2 "" H 22200 14150 50  0001 C CNN
F 3 "" H 22200 14150 50  0001 C CNN
	1    22200 14150
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR080
U 1 1 5FCF2DC8
P 22200 13850
F 0 "#PWR080" H 22200 13700 50  0001 C CNN
F 1 "VCC" H 22217 14023 50  0000 C CNN
F 2 "" H 22200 13850 50  0001 C CNN
F 3 "" H 22200 13850 50  0001 C CNN
	1    22200 13850
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D8
U 1 1 5FD786C6
P 20600 2750
F 0 "D8" H 19700 2750 50  0000 C CNN
F 1 "KP-2012EC" H 20593 2586 50  0001 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 20600 2750 50  0001 C CNN
F 3 "~" H 20600 2750 50  0001 C CNN
	1    20600 2750
	-1   0    0    1   
$EndComp
$Sheet
S 14550 2500 900  1150
U 5FF15207
F0 "Adder" 50
F1 "adder.sch" 50
F2 "a[0..7]" I L 14550 2700 50 
F3 "b[0..7]" I L 14550 2900 50 
F4 "sub" I L 14550 3200 50 
F5 "c_in" I L 14550 3400 50 
F6 "r[0..7]" O R 15450 2700 50 
F7 "xor[0..7]" O R 15450 2900 50 
F8 "c_out" O R 15450 3400 50 
F9 "c6_out" O R 15450 3200 50 
$EndSheet
Text Label 14400 3200 2    50   ~ 0
adder_sub
$Comp
L 74xx:74LS32 U11
U 1 1 60628A2D
P 12550 2600
F 0 "U11" H 12550 2925 50  0000 C CNN
F 1 "74ACT32MTCX" H 12550 2834 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 12550 2600 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/245063.pdf" H 12550 2600 50  0001 C CNN
	1    12550 2600
	1    0    0    -1  
$EndComp
Entry Wire Line
	12250 6550 12350 6650
Entry Wire Line
	12250 6000 12350 6100
Entry Wire Line
	12250 5450 12350 5550
Entry Wire Line
	12250 4900 12350 5000
Entry Wire Line
	12250 4350 12350 4450
Entry Wire Line
	12250 3800 12350 3900
Entry Wire Line
	12250 3250 12350 3350
Text Label 12250 3250 1    50   ~ 0
adder_b1
Text Label 12250 3800 1    50   ~ 0
adder_b2
Text Label 12250 4350 1    50   ~ 0
adder_b3
Text Label 12250 4900 1    50   ~ 0
adder_b4
Text Label 12250 5450 1    50   ~ 0
adder_b5
Text Label 12250 6000 1    50   ~ 0
adder_b6
Text Label 12250 6550 1    50   ~ 0
adder_b7
Entry Wire Line
	13000 2800 13100 2900
Text Label 13000 2600 1    50   ~ 0
adder_b0
Wire Wire Line
	12850 2600 13000 2600
Wire Wire Line
	13000 2600 13000 2800
Text Label 14150 2900 2    50   ~ 0
adder_b[0..7]
Text Label 11450 2500 0    50   ~ 0
adder_b_one
$Comp
L 74xx:74LS157 U4
U 1 1 6076623E
P 6850 2700
F 0 "U4" H 7250 1900 50  0000 C CNN
F 1 "MC74AC157DR2G" H 7350 1800 50  0000 C CNN
F 2 "Package_SO:SOIC-16_3.9x9.9mm_P1.27mm" H 6850 2700 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/234541.pdf" H 6850 2700 50  0001 C CNN
	1    6850 2700
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS157 U5
U 1 1 6076F6E2
P 6850 4900
F 0 "U5" H 7250 4100 50  0000 C CNN
F 1 "MC74AC157DR2G" H 7300 4000 50  0000 C CNN
F 2 "Package_SO:SOIC-16_3.9x9.9mm_P1.27mm" H 6850 4900 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/234541.pdf" H 6850 4900 50  0001 C CNN
	1    6850 4900
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS157 U6
U 1 1 6077044E
P 6850 7150
F 0 "U6" H 7250 6400 50  0000 C CNN
F 1 "MC74AC157DR2G" H 7350 6250 50  0000 C CNN
F 2 "Package_SO:SOIC-16_3.9x9.9mm_P1.27mm" H 6850 7150 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/234541.pdf" H 6850 7150 50  0001 C CNN
	1    6850 7150
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS157 U7
U 1 1 60771A28
P 6850 9350
F 0 "U7" H 7250 8650 50  0000 C CNN
F 1 "MC74AC157DR2G" H 7300 8450 50  0000 C CNN
F 2 "Package_SO:SOIC-16_3.9x9.9mm_P1.27mm" H 6850 9350 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/234541.pdf" H 6850 9350 50  0001 C CNN
	1    6850 9350
	1    0    0    -1  
$EndComp
Entry Wire Line
	5950 9750 5850 9650
Entry Wire Line
	5950 9450 5850 9350
Entry Wire Line
	5950 9150 5850 9050
Entry Wire Line
	5950 8850 5850 8750
Entry Wire Line
	5950 7550 5850 7450
Entry Wire Line
	5950 7250 5850 7150
Entry Wire Line
	5950 6950 5850 6850
Entry Wire Line
	5950 6650 5850 6550
Wire Wire Line
	5950 6650 6350 6650
Wire Wire Line
	5950 6950 6350 6950
Wire Wire Line
	5950 7250 6350 7250
Wire Wire Line
	5950 7550 6350 7550
Wire Wire Line
	5950 8850 6350 8850
Wire Wire Line
	5950 9150 6350 9150
Wire Wire Line
	5950 9450 6350 9450
Wire Wire Line
	5950 9750 6350 9750
Entry Wire Line
	5450 9650 5350 9550
Entry Wire Line
	5450 9350 5350 9250
Entry Wire Line
	5450 9050 5350 8950
Entry Wire Line
	5450 8750 5350 8650
Entry Wire Line
	5450 7450 5350 7350
Entry Wire Line
	5450 7150 5350 7050
Entry Wire Line
	5450 6850 5350 6750
Entry Wire Line
	5450 6550 5350 6450
Entry Wire Line
	5950 5300 5850 5200
Entry Wire Line
	5950 5000 5850 4900
Entry Wire Line
	5950 4700 5850 4600
Entry Wire Line
	5950 4400 5850 4300
Entry Wire Line
	5950 3100 5850 3000
Entry Wire Line
	5950 2800 5850 2700
Entry Wire Line
	5950 2500 5850 2400
Entry Wire Line
	5950 2200 5850 2100
Wire Wire Line
	5950 2200 6350 2200
Wire Wire Line
	5950 2500 6350 2500
Wire Wire Line
	5950 2800 6350 2800
Wire Wire Line
	5950 3100 6350 3100
Wire Wire Line
	5950 4400 6350 4400
Wire Wire Line
	5950 4700 6350 4700
Wire Wire Line
	5950 5000 6350 5000
Wire Wire Line
	5950 5300 6350 5300
Entry Wire Line
	5450 5200 5350 5100
Entry Wire Line
	5450 4900 5350 4800
Entry Wire Line
	5450 4600 5350 4500
Entry Wire Line
	5450 4300 5350 4200
Entry Wire Line
	5450 3000 5350 2900
Entry Wire Line
	5450 2700 5350 2600
Entry Wire Line
	5450 2400 5350 2300
Entry Wire Line
	5450 2100 5350 2000
Text Label 5550 2100 0    50   ~ 0
a0
Text Label 5550 2400 0    50   ~ 0
a1
Text Label 5550 2700 0    50   ~ 0
a2
Text Label 5550 3000 0    50   ~ 0
a3
Text Label 5550 4300 0    50   ~ 0
a4
Text Label 5550 4600 0    50   ~ 0
a5
Text Label 5550 4900 0    50   ~ 0
a6
Text Label 5550 5200 0    50   ~ 0
a7
Text Label 6000 2200 0    50   ~ 0
b0
Text Label 6000 2500 0    50   ~ 0
b1
Text Label 6000 2800 0    50   ~ 0
b2
Text Label 6000 3100 0    50   ~ 0
b3
Text Label 6000 4400 0    50   ~ 0
b4
Text Label 6000 4700 0    50   ~ 0
b5
Text Label 6000 5000 0    50   ~ 0
b6
Text Label 6000 5300 0    50   ~ 0
b7
Text Label 5550 6550 0    50   ~ 0
b1
Text Label 5550 6850 0    50   ~ 0
b0
Text Label 5550 7150 0    50   ~ 0
b3
Text Label 5550 7450 0    50   ~ 0
b2
Text Label 5550 8750 0    50   ~ 0
b5
Text Label 5550 9050 0    50   ~ 0
b4
Text Label 5550 9350 0    50   ~ 0
b7
Text Label 5550 9650 0    50   ~ 0
b6
Text Label 6050 6650 0    50   ~ 0
a1
Text Label 6050 6950 0    50   ~ 0
a0
Text Label 6050 7250 0    50   ~ 0
a3
Text Label 6050 7550 0    50   ~ 0
a2
Text Label 6050 8850 0    50   ~ 0
a5
Text Label 6050 9150 0    50   ~ 0
a4
Text Label 6050 9450 0    50   ~ 0
a7
Text Label 6050 9750 0    50   ~ 0
a6
$Comp
L power:GND #PWR037
U 1 1 60831F45
P 6850 3700
F 0 "#PWR037" H 6850 3450 50  0001 C CNN
F 1 "GND" H 7000 3700 50  0000 C CNN
F 2 "" H 6850 3700 50  0001 C CNN
F 3 "" H 6850 3700 50  0001 C CNN
	1    6850 3700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR039
U 1 1 6083263D
P 6850 5900
F 0 "#PWR039" H 6850 5650 50  0001 C CNN
F 1 "GND" H 6855 5727 50  0000 C CNN
F 2 "" H 6850 5900 50  0001 C CNN
F 3 "" H 6850 5900 50  0001 C CNN
	1    6850 5900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR041
U 1 1 6083332E
P 6850 8150
F 0 "#PWR041" H 6850 7900 50  0001 C CNN
F 1 "GND" H 6950 8150 50  0000 C CNN
F 2 "" H 6850 8150 50  0001 C CNN
F 3 "" H 6850 8150 50  0001 C CNN
	1    6850 8150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR043
U 1 1 608337F1
P 6850 10350
F 0 "#PWR043" H 6850 10100 50  0001 C CNN
F 1 "GND" H 6855 10177 50  0000 C CNN
F 2 "" H 6850 10350 50  0001 C CNN
F 3 "" H 6850 10350 50  0001 C CNN
	1    6850 10350
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR036
U 1 1 60834DEC
P 6850 1800
F 0 "#PWR036" H 6850 1650 50  0001 C CNN
F 1 "VCC" H 6867 1973 50  0000 C CNN
F 2 "" H 6850 1800 50  0001 C CNN
F 3 "" H 6850 1800 50  0001 C CNN
	1    6850 1800
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR038
U 1 1 60835562
P 6850 4000
F 0 "#PWR038" H 6850 3850 50  0001 C CNN
F 1 "VCC" H 6950 4000 50  0000 C CNN
F 2 "" H 6850 4000 50  0001 C CNN
F 3 "" H 6850 4000 50  0001 C CNN
	1    6850 4000
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR040
U 1 1 60835D22
P 6850 6250
F 0 "#PWR040" H 6850 6100 50  0001 C CNN
F 1 "VCC" H 6950 6250 50  0000 C CNN
F 2 "" H 6850 6250 50  0001 C CNN
F 3 "" H 6850 6250 50  0001 C CNN
	1    6850 6250
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR042
U 1 1 608361CA
P 6850 8450
F 0 "#PWR042" H 6850 8300 50  0001 C CNN
F 1 "VCC" H 6950 8450 50  0000 C CNN
F 2 "" H 6850 8450 50  0001 C CNN
F 3 "" H 6850 8450 50  0001 C CNN
	1    6850 8450
	1    0    0    -1  
$EndComp
Wire Wire Line
	6350 9950 6250 9950
Wire Wire Line
	6250 9950 6250 7750
Wire Wire Line
	6350 3300 6250 3300
Wire Wire Line
	6350 5500 6250 5500
Connection ~ 6250 5500
Wire Wire Line
	6250 5500 6250 3300
Wire Wire Line
	6350 7750 6250 7750
Connection ~ 6250 7750
Wire Wire Line
	6250 7750 6250 5950
Text Label 4350 5950 0    50   ~ 0
swap
Wire Wire Line
	6350 5600 6150 5600
Wire Wire Line
	6150 5600 6150 3400
Wire Wire Line
	6350 3400 6150 3400
Connection ~ 6150 3400
Wire Wire Line
	6150 3400 6150 1400
Text Label 4200 4800 0    50   ~ 0
~sa_ena
Wire Wire Line
	6350 10050 5150 10050
Wire Wire Line
	5150 10050 5150 7850
Text Label 5150 1400 0    50   ~ 0
~sb_ena
Wire Wire Line
	6350 7850 5150 7850
Connection ~ 5150 7850
Wire Wire Line
	5150 7850 5150 6900
Wire Bus Line
	5350 6000 5600 6000
Wire Bus Line
	5600 6000 5600 5500
Wire Bus Line
	5600 5500 5850 5500
Wire Bus Line
	5850 5700 5350 5700
Wire Bus Line
	1900 1650 5350 1650
Wire Bus Line
	1250 1500 5850 1500
Entry Wire Line
	7700 2100 7800 2200
Entry Wire Line
	7700 2400 7800 2500
Entry Wire Line
	7700 2700 7800 2800
Entry Wire Line
	7700 3000 7800 3100
Wire Wire Line
	7700 3000 7350 3000
Wire Wire Line
	7700 2700 7350 2700
Wire Wire Line
	7700 2400 7350 2400
Wire Wire Line
	7700 2100 7350 2100
Entry Wire Line
	7700 4300 7800 4400
Entry Wire Line
	7700 4600 7800 4700
Entry Wire Line
	7700 4900 7800 5000
Entry Wire Line
	7700 5200 7800 5300
Wire Wire Line
	7700 5200 7350 5200
Wire Wire Line
	7700 4900 7350 4900
Wire Wire Line
	7700 4600 7350 4600
Wire Wire Line
	7700 4300 7350 4300
Entry Wire Line
	7700 6550 7800 6650
Entry Wire Line
	7700 6850 7800 6950
Entry Wire Line
	7700 7150 7800 7250
Entry Wire Line
	7700 7450 7800 7550
Wire Wire Line
	7700 7450 7350 7450
Wire Wire Line
	7700 7150 7350 7150
Wire Wire Line
	7700 6850 7350 6850
Wire Wire Line
	7700 6550 7350 6550
Entry Wire Line
	7700 8750 7800 8850
Entry Wire Line
	7700 9050 7800 9150
Entry Wire Line
	7700 9350 7800 9450
Entry Wire Line
	7700 9650 7800 9750
Wire Wire Line
	7700 9650 7350 9650
Wire Wire Line
	7700 9350 7350 9350
Wire Wire Line
	7700 9050 7350 9050
Wire Wire Line
	7700 8750 7350 8750
Text Label 7650 2100 0    50   ~ 0
sa0
Text Label 7650 2400 0    50   ~ 0
sa1
Text Label 7650 2700 0    50   ~ 0
sa2
Text Label 7650 3000 0    50   ~ 0
sa3
Text Label 7650 4300 0    50   ~ 0
sa4
Text Label 7650 4600 0    50   ~ 0
sa5
Text Label 7650 4900 0    50   ~ 0
sa6
Text Label 7650 5200 0    50   ~ 0
sa7
Text Label 7650 6550 0    50   ~ 0
sb1
Text Label 7650 6850 0    50   ~ 0
sb0
Text Label 7650 7150 0    50   ~ 0
sb3
Text Label 7650 7450 0    50   ~ 0
sb2
Text Label 7650 8750 0    50   ~ 0
sb5
Text Label 7650 9050 0    50   ~ 0
sb4
Text Label 7650 9350 0    50   ~ 0
sb7
Text Label 7650 9650 0    50   ~ 0
sb6
Wire Bus Line
	7800 1950 14000 1950
Wire Bus Line
	14000 1950 14000 2700
Wire Bus Line
	14000 2700 14550 2700
Text Label 7800 1950 0    50   ~ 0
sa[0..7]
Wire Bus Line
	7800 6600 11450 6600
Entry Wire Line
	11550 6550 11450 6450
Entry Wire Line
	11550 6000 11450 5900
Entry Wire Line
	11550 5450 11450 5350
Entry Wire Line
	11550 4900 11450 4800
Entry Wire Line
	11550 4350 11450 4250
Entry Wire Line
	11550 3800 11450 3700
Entry Wire Line
	11550 3250 11450 3150
Entry Wire Line
	11550 2700 11450 2600
Wire Wire Line
	11550 2700 12250 2700
Wire Wire Line
	11550 3250 12250 3250
Wire Wire Line
	11550 3800 12250 3800
Wire Wire Line
	11550 4350 12250 4350
Wire Wire Line
	11550 4900 12250 4900
Wire Wire Line
	11550 5450 12250 5450
Wire Wire Line
	11550 6000 12250 6000
Wire Wire Line
	11550 6550 12250 6550
Text Label 11600 6550 0    50   ~ 0
sb7
Text Label 11600 6000 0    50   ~ 0
sb6
Text Label 11600 5450 0    50   ~ 0
sb5
Text Label 11600 4900 0    50   ~ 0
sb4
Text Label 11600 4350 0    50   ~ 0
sb3
Text Label 11600 3800 0    50   ~ 0
sb2
Text Label 11600 3250 0    50   ~ 0
sb1
Text Label 11600 2700 0    50   ~ 0
sb0
Wire Bus Line
	15450 2900 15700 2900
Text Label 15700 2900 0    50   ~ 0
xor_r[0..7]
Wire Bus Line
	15450 2700 15700 2700
Text Label 15700 2700 0    50   ~ 0
adder_r[0..7]
Text Label 15600 3400 0    50   ~ 0
adder_c_out
Wire Wire Line
	14550 3400 14400 3400
$Comp
L 74xx:74HC244 U16
U 1 1 60A2B4F3
P 17900 1550
F 0 "U16" H 18350 1100 50  0000 C CNN
F 1 "74ACT244MTC" H 18450 1000 50  0000 C CNN
F 2 "Package_SO:TSSOP-20_4.4x6.5mm_P0.65mm" H 17900 1550 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/162478.pdf" H 17900 1550 50  0001 C CNN
	1    17900 1550
	1    0    0    -1  
$EndComp
Text Label 18400 1450 0    50   ~ 0
r0
Text Label 18400 1550 0    50   ~ 0
r1
Text Label 18400 1650 0    50   ~ 0
r2
Text Label 18400 1350 0    50   ~ 0
r7
Text Label 18400 1050 0    50   ~ 0
r4
Text Label 18400 1150 0    50   ~ 0
r5
Text Label 18400 1250 0    50   ~ 0
r6
Text Label 18400 1750 0    50   ~ 0
r3
Text Label 17400 1450 2    50   ~ 0
adder_r0
Text Label 17400 1550 2    50   ~ 0
adder_r1
Text Label 17400 1650 2    50   ~ 0
adder_r2
Text Label 17400 1750 2    50   ~ 0
adder_r3
Text Label 17400 1050 2    50   ~ 0
adder_r4
Text Label 17400 1150 2    50   ~ 0
adder_r5
Text Label 17400 1250 2    50   ~ 0
adder_r6
Text Label 17400 1350 2    50   ~ 0
adder_r7
Text Label 17400 1950 2    50   ~ 0
~adder_oe
Wire Wire Line
	17400 1950 17400 2000
$Comp
L power:GND #PWR067
U 1 1 60AE807D
P 17900 2350
F 0 "#PWR067" H 17900 2100 50  0001 C CNN
F 1 "GND" H 17905 2177 50  0000 C CNN
F 2 "" H 17900 2350 50  0001 C CNN
F 3 "" H 17900 2350 50  0001 C CNN
	1    17900 2350
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR066
U 1 1 60AE970A
P 17900 750
F 0 "#PWR066" H 17900 600 50  0001 C CNN
F 1 "VCC" H 17917 923 50  0000 C CNN
F 2 "" H 17900 750 50  0001 C CNN
F 3 "" H 17900 750 50  0001 C CNN
	1    17900 750 
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC244 U17
U 1 1 60AED4AD
P 17900 3750
F 0 "U17" H 18350 3300 50  0000 C CNN
F 1 "74ACT244MTC" H 18450 3200 50  0000 C CNN
F 2 "Package_SO:TSSOP-20_4.4x6.5mm_P0.65mm" H 17900 3750 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/162478.pdf" H 17900 3750 50  0001 C CNN
	1    17900 3750
	1    0    0    -1  
$EndComp
Text Label 18400 3250 0    50   ~ 0
r0
Text Label 18400 3350 0    50   ~ 0
r1
Text Label 18400 3450 0    50   ~ 0
r2
Text Label 18400 3550 0    50   ~ 0
r3
Text Label 18400 3650 0    50   ~ 0
r4
Text Label 18400 3750 0    50   ~ 0
r5
Text Label 18400 3850 0    50   ~ 0
r6
Text Label 18400 3950 0    50   ~ 0
r7
Text Label 17400 4150 2    50   ~ 0
~xor_oe
Wire Wire Line
	17400 4150 17400 4250
$Comp
L power:GND #PWR069
U 1 1 60AED4C5
P 17900 4550
F 0 "#PWR069" H 17900 4300 50  0001 C CNN
F 1 "GND" H 17905 4377 50  0000 C CNN
F 2 "" H 17900 4550 50  0001 C CNN
F 3 "" H 17900 4550 50  0001 C CNN
	1    17900 4550
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR068
U 1 1 60AED4CB
P 17900 2950
F 0 "#PWR068" H 17900 2800 50  0001 C CNN
F 1 "VCC" H 17917 3123 50  0000 C CNN
F 2 "" H 17900 2950 50  0001 C CNN
F 3 "" H 17900 2950 50  0001 C CNN
	1    17900 2950
	1    0    0    -1  
$EndComp
Text Label 17400 3250 2    50   ~ 0
xor_r0
Text Label 17400 3350 2    50   ~ 0
xor_r1
Text Label 17400 3450 2    50   ~ 0
xor_r2
Text Label 17400 3550 2    50   ~ 0
xor_r3
Text Label 17400 3650 2    50   ~ 0
xor_r4
Text Label 17400 3750 2    50   ~ 0
xor_r5
Text Label 17400 3850 2    50   ~ 0
xor_r6
Text Label 17400 3950 2    50   ~ 0
xor_r7
$Comp
L 74xx:74HC244 U18
U 1 1 60B10627
P 17900 5800
F 0 "U18" H 18350 5350 50  0000 C CNN
F 1 "74ACT244MTC" H 18450 5250 50  0000 C CNN
F 2 "Package_SO:TSSOP-20_4.4x6.5mm_P0.65mm" H 17900 5800 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/162478.pdf" H 17900 5800 50  0001 C CNN
	1    17900 5800
	1    0    0    -1  
$EndComp
Text Label 18400 5300 0    50   ~ 0
r0
Text Label 18400 5400 0    50   ~ 0
r1
Text Label 18400 5500 0    50   ~ 0
r2
Text Label 18400 5600 0    50   ~ 0
r3
Text Label 18400 5700 0    50   ~ 0
r4
Text Label 18400 5800 0    50   ~ 0
r5
Text Label 18400 5900 0    50   ~ 0
r6
Text Label 18400 6000 0    50   ~ 0
r7
Text Label 17400 6200 2    50   ~ 0
~shl_oe
Wire Wire Line
	17400 6200 17400 6300
$Comp
L power:GND #PWR071
U 1 1 60B10637
P 17900 6600
F 0 "#PWR071" H 17900 6350 50  0001 C CNN
F 1 "GND" H 17905 6427 50  0000 C CNN
F 2 "" H 17900 6600 50  0001 C CNN
F 3 "" H 17900 6600 50  0001 C CNN
	1    17900 6600
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR070
U 1 1 60B1063D
P 17900 5000
F 0 "#PWR070" H 17900 4850 50  0001 C CNN
F 1 "VCC" H 17917 5173 50  0000 C CNN
F 2 "" H 17900 5000 50  0001 C CNN
F 3 "" H 17900 5000 50  0001 C CNN
	1    17900 5000
	1    0    0    -1  
$EndComp
Text Label 17400 5400 2    50   ~ 0
sa0
Text Label 17400 5500 2    50   ~ 0
sa1
Text Label 17400 5600 2    50   ~ 0
sa2
Text Label 17400 5700 2    50   ~ 0
sa3
Text Label 17400 5800 2    50   ~ 0
sa4
Text Label 17400 5900 2    50   ~ 0
sa5
Text Label 17400 6000 2    50   ~ 0
sa6
$Comp
L power:GND #PWR065
U 1 1 60B30445
P 17250 5300
F 0 "#PWR065" H 17250 5050 50  0001 C CNN
F 1 "GND" V 17255 5172 50  0000 R CNN
F 2 "" H 17250 5300 50  0001 C CNN
F 3 "" H 17250 5300 50  0001 C CNN
	1    17250 5300
	0    1    1    0   
$EndComp
Wire Wire Line
	17250 5300 17400 5300
$Comp
L 74xx:74HC244 U19
U 1 1 60B3F5CE
P 17900 7850
F 0 "U19" H 18350 7400 50  0000 C CNN
F 1 "74ACT244MTC" H 18450 7300 50  0000 C CNN
F 2 "Package_SO:TSSOP-20_4.4x6.5mm_P0.65mm" H 17900 7850 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/162478.pdf" H 17900 7850 50  0001 C CNN
	1    17900 7850
	1    0    0    -1  
$EndComp
Text Label 18400 7750 0    50   ~ 0
r0
Text Label 18400 7850 0    50   ~ 0
r1
Text Label 18400 7950 0    50   ~ 0
r2
Text Label 18400 8050 0    50   ~ 0
r3
Text Label 18400 7350 0    50   ~ 0
r4
Text Label 18400 7450 0    50   ~ 0
r5
Text Label 18400 7550 0    50   ~ 0
r6
Text Label 18400 7650 0    50   ~ 0
r7
Text Label 17400 8300 2    50   ~ 0
~shr_oe
Wire Wire Line
	17400 8250 17400 8350
$Comp
L power:GND #PWR073
U 1 1 60B3F5DE
P 17900 8650
F 0 "#PWR073" H 17900 8400 50  0001 C CNN
F 1 "GND" H 17905 8477 50  0000 C CNN
F 2 "" H 17900 8650 50  0001 C CNN
F 3 "" H 17900 8650 50  0001 C CNN
	1    17900 8650
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR072
U 1 1 60B3F5E4
P 17900 7050
F 0 "#PWR072" H 17900 6900 50  0001 C CNN
F 1 "VCC" H 17917 7223 50  0000 C CNN
F 2 "" H 17900 7050 50  0001 C CNN
F 3 "" H 17900 7050 50  0001 C CNN
	1    17900 7050
	1    0    0    -1  
$EndComp
Text Label 17400 7750 2    50   ~ 0
sa1
Text Label 17400 7850 2    50   ~ 0
sa2
Text Label 17400 7950 2    50   ~ 0
sa3
Text Label 17400 8050 2    50   ~ 0
sa4
Text Label 17400 7350 2    50   ~ 0
sa5
Text Label 17400 7450 2    50   ~ 0
sa6
Text Label 17400 7550 2    50   ~ 0
sa7
Text Label 16500 7750 2    50   ~ 0
sa7
Wire Wire Line
	17100 7650 17400 7650
$Comp
L 74xx:74LS08 U15
U 2 1 60B88332
P 16800 7650
F 0 "U15" H 16800 7975 50  0000 C CNN
F 1 "SN74ACT08PW" H 16800 7884 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 16800 7650 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74act08.pdf" H 16800 7650 50  0001 C CNN
	2    16800 7650
	1    0    0    -1  
$EndComp
Text Label 16500 7550 2    50   ~ 0
sar_ena
$Comp
L 74xx:74HC240 U21
U 1 1 60BC5547
P 20700 1550
F 0 "U21" H 21100 950 50  0000 C CNN
F 1 "SN74ACT240PWR" H 21200 800 50  0000 C CNN
F 2 "Package_SO:TSSOP-20_4.4x6.5mm_P0.65mm" H 20700 1550 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74act240.pdf" H 20700 1550 50  0001 C CNN
	1    20700 1550
	1    0    0    -1  
$EndComp
Wire Wire Line
	20200 2050 20200 1950
Text Label 20200 1950 2    50   ~ 0
~not_oe
Text Label 20200 1550 2    50   ~ 0
sb1
Text Label 20200 1650 2    50   ~ 0
sb2
Text Label 20200 1750 2    50   ~ 0
sb3
Text Label 20200 1050 2    50   ~ 0
sb4
Text Label 20200 1150 2    50   ~ 0
sb5
Text Label 20200 1250 2    50   ~ 0
sb6
Text Label 20200 1350 2    50   ~ 0
sb7
Text Label 20200 1450 2    50   ~ 0
sb0
Text Label 21200 1450 0    50   ~ 0
r0
Text Label 21200 1550 0    50   ~ 0
r1
Text Label 21200 1650 0    50   ~ 0
r2
Text Label 21200 1750 0    50   ~ 0
r3
Text Label 21200 1050 0    50   ~ 0
r4
Text Label 21200 1150 0    50   ~ 0
r5
Text Label 21200 1250 0    50   ~ 0
r6
Text Label 21200 1350 0    50   ~ 0
r7
$Comp
L power:GND #PWR083
U 1 1 60BEF4AE
P 20700 2350
F 0 "#PWR083" H 20700 2100 50  0001 C CNN
F 1 "GND" H 20705 2177 50  0000 C CNN
F 2 "" H 20700 2350 50  0001 C CNN
F 3 "" H 20700 2350 50  0001 C CNN
	1    20700 2350
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR082
U 1 1 60BEFA29
P 20700 750
F 0 "#PWR082" H 20700 600 50  0001 C CNN
F 1 "VCC" H 20717 923 50  0000 C CNN
F 2 "" H 20700 750 50  0001 C CNN
F 3 "" H 20700 750 50  0001 C CNN
	1    20700 750 
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U1
U 1 1 60BF1BEA
P 1550 7450
F 0 "U1" H 1550 7775 50  0000 C CNN
F 1 "SN74ACT08PW" H 1550 7684 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 1550 7450 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74act08.pdf" H 1550 7450 50  0001 C CNN
	1    1550 7450
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U1
U 2 1 60BF56DC
P 1550 8000
F 0 "U1" H 1550 8325 50  0000 C CNN
F 1 "SN74ACT08PW" H 1550 8234 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 1550 8000 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74act08.pdf" H 1550 8000 50  0001 C CNN
	2    1550 8000
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U1
U 3 1 60BFD039
P 1550 8550
F 0 "U1" H 1550 8875 50  0000 C CNN
F 1 "SN74ACT08PW" H 1550 8784 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 1550 8550 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74act08.pdf" H 1550 8550 50  0001 C CNN
	3    1550 8550
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U1
U 4 1 60BFD03F
P 1550 9100
F 0 "U1" H 1550 9425 50  0000 C CNN
F 1 "SN74ACT08PW" H 1550 9334 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 1550 9100 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74act08.pdf" H 1550 9100 50  0001 C CNN
	4    1550 9100
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U2
U 1 1 60C16F0A
P 1550 9650
F 0 "U2" H 1550 9975 50  0000 C CNN
F 1 "SN74ACT08PW" H 1550 9884 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 1550 9650 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74act08.pdf" H 1550 9650 50  0001 C CNN
	1    1550 9650
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U2
U 2 1 60C16F10
P 1550 10200
F 0 "U2" H 1550 10525 50  0000 C CNN
F 1 "SN74ACT08PW" H 1550 10434 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 1550 10200 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74act08.pdf" H 1550 10200 50  0001 C CNN
	2    1550 10200
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U2
U 3 1 60C16F16
P 1550 10750
F 0 "U2" H 1550 11075 50  0000 C CNN
F 1 "SN74ACT08PW" H 1550 10984 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 1550 10750 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74act08.pdf" H 1550 10750 50  0001 C CNN
	3    1550 10750
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U2
U 4 1 60C16F1C
P 1550 11300
F 0 "U2" H 1550 11625 50  0000 C CNN
F 1 "SN74ACT08PW" H 1550 11534 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 1550 11300 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74act08.pdf" H 1550 11300 50  0001 C CNN
	4    1550 11300
	1    0    0    -1  
$EndComp
Text Label 1250 9550 2    50   ~ 0
sa0
Text Label 1250 9750 2    50   ~ 0
sb0
Text Label 1250 10100 2    50   ~ 0
sa1
Text Label 1250 10300 2    50   ~ 0
sb1
Text Label 1250 10650 2    50   ~ 0
sa2
Text Label 1250 10850 2    50   ~ 0
sb2
Text Label 1250 11200 2    50   ~ 0
sa3
Text Label 1250 11400 2    50   ~ 0
sb3
Text Label 1250 7350 2    50   ~ 0
sa4
Text Label 1250 7550 2    50   ~ 0
sb4
Text Label 1250 7900 2    50   ~ 0
sa5
Text Label 1250 8100 2    50   ~ 0
sb5
Text Label 1250 8450 2    50   ~ 0
sa6
Text Label 1250 8650 2    50   ~ 0
sb6
Text Label 1250 9000 2    50   ~ 0
sa7
Text Label 1250 9200 2    50   ~ 0
sb7
$Comp
L 74xx:74HC244 U3
U 1 1 60C38A75
P 2850 9500
F 0 "U3" H 3300 9050 50  0000 C CNN
F 1 "74ACT244MTC" H 3400 8950 50  0000 C CNN
F 2 "Package_SO:TSSOP-20_4.4x6.5mm_P0.65mm" H 2850 9500 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/162478.pdf" H 2850 9500 50  0001 C CNN
	1    2850 9500
	1    0    0    -1  
$EndComp
Wire Wire Line
	2350 9300 1850 9300
Wire Wire Line
	1850 9300 1850 9100
Wire Wire Line
	2350 9200 1900 9200
Wire Wire Line
	1900 9200 1900 8550
Wire Wire Line
	1900 8550 1850 8550
Wire Wire Line
	2350 9100 1950 9100
Wire Wire Line
	1950 9100 1950 8000
Wire Wire Line
	1950 8000 1850 8000
Wire Wire Line
	2350 9000 2000 9000
Wire Wire Line
	2000 9000 2000 7450
Wire Wire Line
	2000 7450 1850 7450
Wire Wire Line
	2350 9400 1850 9400
Wire Wire Line
	1850 9400 1850 9650
Wire Wire Line
	2350 9500 1900 9500
Wire Wire Line
	1900 9500 1900 10200
Wire Wire Line
	1900 10200 1850 10200
Wire Wire Line
	2350 9600 1950 9600
Wire Wire Line
	1950 9600 1950 10750
Wire Wire Line
	1950 10750 1850 10750
Wire Wire Line
	2350 9700 2000 9700
Wire Wire Line
	2000 9700 2000 11300
Wire Wire Line
	2000 11300 1850 11300
Wire Wire Line
	2350 9900 2350 10000
Text Label 2350 9900 2    50   ~ 0
~and_oe
Text Label 3350 9400 0    50   ~ 0
r0
Text Label 3350 9500 0    50   ~ 0
r1
Text Label 3350 9600 0    50   ~ 0
r2
Text Label 3350 9700 0    50   ~ 0
r3
Text Label 3350 9000 0    50   ~ 0
r4
Text Label 3350 9100 0    50   ~ 0
r5
Text Label 3350 9200 0    50   ~ 0
r6
Text Label 3350 9300 0    50   ~ 0
r7
$Comp
L power:GND #PWR020
U 1 1 60CCCC54
P 2850 10300
F 0 "#PWR020" H 2850 10050 50  0001 C CNN
F 1 "GND" H 2855 10127 50  0000 C CNN
F 2 "" H 2850 10300 50  0001 C CNN
F 3 "" H 2850 10300 50  0001 C CNN
	1    2850 10300
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR019
U 1 1 60CCD303
P 2850 8700
F 0 "#PWR019" H 2850 8550 50  0001 C CNN
F 1 "VCC" H 2867 8873 50  0000 C CNN
F 2 "" H 2850 8700 50  0001 C CNN
F 3 "" H 2850 8700 50  0001 C CNN
	1    2850 8700
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC244 U10
U 1 1 60CE597E
P 10000 9450
F 0 "U10" H 10450 9000 50  0000 C CNN
F 1 "74ACT244MTC" H 10550 8900 50  0000 C CNN
F 2 "Package_SO:TSSOP-20_4.4x6.5mm_P0.65mm" H 10000 9450 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/162478.pdf" H 10000 9450 50  0001 C CNN
	1    10000 9450
	1    0    0    -1  
$EndComp
Wire Wire Line
	9500 9250 9000 9250
Wire Wire Line
	9000 9250 9000 9050
Wire Wire Line
	9500 9150 9050 9150
Wire Wire Line
	9050 9150 9050 8500
Wire Wire Line
	9050 8500 9000 8500
Wire Wire Line
	9500 9050 9100 9050
Wire Wire Line
	9100 9050 9100 7950
Wire Wire Line
	9100 7950 9000 7950
Wire Wire Line
	9500 8950 9150 8950
Wire Wire Line
	9150 8950 9150 7400
Wire Wire Line
	9150 7400 9000 7400
Wire Wire Line
	9500 9350 9000 9350
Wire Wire Line
	9000 9350 9000 9600
Wire Wire Line
	9500 9450 9050 9450
Wire Wire Line
	9050 9450 9050 10150
Wire Wire Line
	9050 10150 9000 10150
Wire Wire Line
	9500 9550 9100 9550
Wire Wire Line
	9100 9550 9100 10700
Wire Wire Line
	9100 10700 9000 10700
Wire Wire Line
	9500 9650 9150 9650
Wire Wire Line
	9150 9650 9150 11250
Wire Wire Line
	9150 11250 9000 11250
Wire Wire Line
	9500 9850 9500 9950
Text Label 9500 9850 2    50   ~ 0
~or_oe
Text Label 10500 8950 0    50   ~ 0
r4
Text Label 10500 9050 0    50   ~ 0
r5
Text Label 10500 9150 0    50   ~ 0
r6
Text Label 10500 9250 0    50   ~ 0
r7
$Comp
L power:GND #PWR051
U 1 1 60CE59A4
P 10000 10250
F 0 "#PWR051" H 10000 10000 50  0001 C CNN
F 1 "GND" H 10005 10077 50  0000 C CNN
F 2 "" H 10000 10250 50  0001 C CNN
F 3 "" H 10000 10250 50  0001 C CNN
	1    10000 10250
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR050
U 1 1 60CE59AA
P 10000 8650
F 0 "#PWR050" H 10000 8500 50  0001 C CNN
F 1 "VCC" H 10017 8823 50  0000 C CNN
F 2 "" H 10000 8650 50  0001 C CNN
F 3 "" H 10000 8650 50  0001 C CNN
	1    10000 8650
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U8
U 1 1 60D06A37
P 8700 7400
F 0 "U8" H 8700 7725 50  0000 C CNN
F 1 "74ACT32MTCX" H 8700 7634 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 8700 7400 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/245063.pdf" H 8700 7400 50  0001 C CNN
	1    8700 7400
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U8
U 2 1 60D0AF2F
P 8700 7950
F 0 "U8" H 8700 8275 50  0000 C CNN
F 1 "74ACT32MTCX" H 8700 8184 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 8700 7950 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/245063.pdf" H 8700 7950 50  0001 C CNN
	2    8700 7950
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U8
U 3 1 60D0B9E9
P 8700 8500
F 0 "U8" H 8700 8825 50  0000 C CNN
F 1 "74ACT32MTCX" H 8700 8734 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 8700 8500 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/245063.pdf" H 8700 8500 50  0001 C CNN
	3    8700 8500
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U8
U 4 1 60D0D0D9
P 8700 9050
F 0 "U8" H 8700 9375 50  0000 C CNN
F 1 "74ACT32MTCX" H 8700 9284 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 8700 9050 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/245063.pdf" H 8700 9050 50  0001 C CNN
	4    8700 9050
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U9
U 1 1 60D0EF60
P 8700 9600
F 0 "U9" H 8700 9925 50  0000 C CNN
F 1 "74ACT32MTCX" H 8700 9834 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 8700 9600 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/245063.pdf" H 8700 9600 50  0001 C CNN
	1    8700 9600
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U9
U 2 1 60D10DE7
P 8700 10150
F 0 "U9" H 8700 10475 50  0000 C CNN
F 1 "74ACT32MTCX" H 8700 10384 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 8700 10150 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/245063.pdf" H 8700 10150 50  0001 C CNN
	2    8700 10150
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U9
U 3 1 60D12FA4
P 8700 10700
F 0 "U9" H 8700 11025 50  0000 C CNN
F 1 "74ACT32MTCX" H 8700 10934 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 8700 10700 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/245063.pdf" H 8700 10700 50  0001 C CNN
	3    8700 10700
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U9
U 4 1 60D15B8C
P 8700 11250
F 0 "U9" H 8700 11575 50  0000 C CNN
F 1 "74ACT32MTCX" H 8700 11484 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 8700 11250 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/245063.pdf" H 8700 11250 50  0001 C CNN
	4    8700 11250
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U2
U 5 1 60D21AC8
P 3500 11600
F 0 "U2" H 3730 11646 50  0000 L CNN
F 1 "SN74ACT08PW" H 3730 11555 50  0000 L CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 3500 11600 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74act08.pdf" H 3500 11600 50  0001 C CNN
	5    3500 11600
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U1
U 5 1 60D25C32
P 2450 11600
F 0 "U1" H 2680 11646 50  0000 L CNN
F 1 "SN74ACT08PW" H 2680 11555 50  0000 L CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 2450 11600 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74act08.pdf" H 2450 11600 50  0001 C CNN
	5    2450 11600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR022
U 1 1 60D2808C
P 3500 12100
F 0 "#PWR022" H 3500 11850 50  0001 C CNN
F 1 "GND" H 3505 11927 50  0000 C CNN
F 2 "" H 3500 12100 50  0001 C CNN
F 3 "" H 3500 12100 50  0001 C CNN
	1    3500 12100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR02
U 1 1 60D2861C
P 2450 12100
F 0 "#PWR02" H 2450 11850 50  0001 C CNN
F 1 "GND" H 2455 11927 50  0000 C CNN
F 2 "" H 2450 12100 50  0001 C CNN
F 3 "" H 2450 12100 50  0001 C CNN
	1    2450 12100
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR01
U 1 1 60D28C01
P 2450 11100
F 0 "#PWR01" H 2450 10950 50  0001 C CNN
F 1 "VCC" H 2467 11273 50  0000 C CNN
F 2 "" H 2450 11100 50  0001 C CNN
F 3 "" H 2450 11100 50  0001 C CNN
	1    2450 11100
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR021
U 1 1 60D291A4
P 3500 11100
F 0 "#PWR021" H 3500 10950 50  0001 C CNN
F 1 "VCC" H 3517 11273 50  0000 C CNN
F 2 "" H 3500 11100 50  0001 C CNN
F 3 "" H 3500 11100 50  0001 C CNN
	1    3500 11100
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U9
U 5 1 60D2B2B9
P 10600 11050
F 0 "U9" H 10830 11096 50  0000 L CNN
F 1 "74ACT32MTCX" H 10830 11005 50  0000 L CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 10600 11050 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/245063.pdf" H 10600 11050 50  0001 C CNN
	5    10600 11050
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U8
U 5 1 60D2CC40
P 9800 11050
F 0 "U8" H 10030 11096 50  0000 L CNN
F 1 "74ACT32MTCX" H 10030 11005 50  0000 L CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 9800 11050 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/245063.pdf" H 9800 11050 50  0001 C CNN
	5    9800 11050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR049
U 1 1 60D31D3C
P 9800 11550
F 0 "#PWR049" H 9800 11300 50  0001 C CNN
F 1 "GND" H 9805 11377 50  0000 C CNN
F 2 "" H 9800 11550 50  0001 C CNN
F 3 "" H 9800 11550 50  0001 C CNN
	1    9800 11550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR053
U 1 1 60D3230E
P 10600 11550
F 0 "#PWR053" H 10600 11300 50  0001 C CNN
F 1 "GND" H 10605 11377 50  0000 C CNN
F 2 "" H 10600 11550 50  0001 C CNN
F 3 "" H 10600 11550 50  0001 C CNN
	1    10600 11550
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR048
U 1 1 60D3268D
P 9800 10550
F 0 "#PWR048" H 9800 10400 50  0001 C CNN
F 1 "VCC" H 9817 10723 50  0000 C CNN
F 2 "" H 9800 10550 50  0001 C CNN
F 3 "" H 9800 10550 50  0001 C CNN
	1    9800 10550
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR052
U 1 1 60D32F39
P 10600 10550
F 0 "#PWR052" H 10600 10400 50  0001 C CNN
F 1 "VCC" H 10617 10723 50  0000 C CNN
F 2 "" H 10600 10550 50  0001 C CNN
F 3 "" H 10600 10550 50  0001 C CNN
	1    10600 10550
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC244 U20
U 1 1 60D36A45
P 17900 10100
F 0 "U20" H 18350 9650 50  0000 C CNN
F 1 "74ACT244MTC" H 18450 9550 50  0000 C CNN
F 2 "Package_SO:TSSOP-20_4.4x6.5mm_P0.65mm" H 17900 10100 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/162478.pdf" H 17900 10100 50  0001 C CNN
	1    17900 10100
	1    0    0    -1  
$EndComp
Text Label 18400 9600 0    50   ~ 0
r0
Text Label 18400 9700 0    50   ~ 0
r1
Text Label 18400 9800 0    50   ~ 0
r2
Text Label 18400 9900 0    50   ~ 0
r3
Text Label 18400 10000 0    50   ~ 0
r4
Text Label 18400 10100 0    50   ~ 0
r5
Text Label 18400 10200 0    50   ~ 0
r6
Text Label 18400 10300 0    50   ~ 0
r7
$Comp
L power:GND #PWR075
U 1 1 60D36A53
P 17900 10900
F 0 "#PWR075" H 17900 10650 50  0001 C CNN
F 1 "GND" H 17905 10727 50  0000 C CNN
F 2 "" H 17900 10900 50  0001 C CNN
F 3 "" H 17900 10900 50  0001 C CNN
	1    17900 10900
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR074
U 1 1 60D36A59
P 17900 9300
F 0 "#PWR074" H 17900 9150 50  0001 C CNN
F 1 "VCC" H 17917 9473 50  0000 C CNN
F 2 "" H 17900 9300 50  0001 C CNN
F 3 "" H 17900 9300 50  0001 C CNN
	1    17900 9300
	1    0    0    -1  
$EndComp
Wire Wire Line
	17400 10600 17400 10500
Text Label 17400 10500 2    50   ~ 0
~exp_oe
Wire Wire Line
	17400 10300 17400 10200
Connection ~ 17400 9700
Wire Wire Line
	17400 9700 17400 9600
Connection ~ 17400 9800
Wire Wire Line
	17400 9800 17400 9700
Connection ~ 17400 9900
Wire Wire Line
	17400 9900 17400 9800
Connection ~ 17400 10000
Wire Wire Line
	17400 10000 17400 9900
Connection ~ 17400 10100
Wire Wire Line
	17400 10100 17400 10000
Connection ~ 17400 10200
Wire Wire Line
	17400 10200 17400 10100
Text Label 17400 9600 2    50   ~ 0
carry_in
$Comp
L 74xx:74LS08 U13
U 1 1 60D8E69A
P 14000 4000
F 0 "U13" H 14000 4325 50  0000 C CNN
F 1 "SN74ACT08PW" H 14000 4234 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 14000 4000 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74act08.pdf" H 14000 4000 50  0001 C CNN
	1    14000 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	14300 4000 14400 4000
Wire Wire Line
	14400 4000 14400 3400
Text Label 13700 3900 2    50   ~ 0
carry_in
Text Label 13700 4100 2    50   ~ 0
adder_carry_ena
Text Label 14400 3400 2    50   ~ 0
adder_c_in
$Comp
L 74xx:74LS138 U12
U 1 1 60DB6AA7
P 13700 5600
F 0 "U12" H 14100 5050 50  0000 C CNN
F 1 "MC74ACT138DTR2G" H 14100 4950 50  0000 C CNN
F 2 "Package_SO:TSSOP-16_4.4x5mm_P0.65mm" H 13700 5600 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/1878558.pdf" H 13700 5600 50  0001 C CNN
	1    13700 5600
	1    0    0    -1  
$EndComp
Text Label 13200 5300 2    50   ~ 0
op0
Text Label 13200 5400 2    50   ~ 0
op1
Text Label 13200 5500 2    50   ~ 0
op2
Text Label 13200 5900 2    50   ~ 0
op3
Text Label 13200 6000 2    50   ~ 0
~oe
$Comp
L power:VCC #PWR055
U 1 1 60DB942E
P 13700 5000
F 0 "#PWR055" H 13700 4850 50  0001 C CNN
F 1 "VCC" H 13800 5000 50  0000 C CNN
F 2 "" H 13700 5000 50  0001 C CNN
F 3 "" H 13700 5000 50  0001 C CNN
	1    13700 5000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR056
U 1 1 60DB9A39
P 13700 6300
F 0 "#PWR056" H 13700 6050 50  0001 C CNN
F 1 "GND" H 13705 6127 50  0000 C CNN
F 2 "" H 13700 6300 50  0001 C CNN
F 3 "" H 13700 6300 50  0001 C CNN
	1    13700 6300
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR054
U 1 1 60DB9F1E
P 13200 5800
F 0 "#PWR054" H 13200 5650 50  0001 C CNN
F 1 "VCC" H 13300 5800 50  0000 C CNN
F 2 "" H 13200 5800 50  0001 C CNN
F 3 "" H 13200 5800 50  0001 C CNN
	1    13200 5800
	0    -1   -1   0   
$EndComp
Text Label 14200 5300 0    50   ~ 0
~exp_oe
Text Label 14200 5400 0    50   ~ 0
~and_oe
Text Label 14200 5500 0    50   ~ 0
~or_oe
Text Label 14200 5600 0    50   ~ 0
~shl_oe
Text Label 14200 5700 0    50   ~ 0
~not_oe
Text Label 14200 5800 0    50   ~ 0
~xor_oe
$Comp
L 74xx:74LS32 U11
U 2 1 60DC7C43
P 16650 2000
F 0 "U11" H 16650 2325 50  0000 C CNN
F 1 "74ACT32MTCX" H 16650 2234 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 16650 2000 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/245063.pdf" H 16650 2000 50  0001 C CNN
	2    16650 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	14200 6000 14650 6000
Wire Wire Line
	14650 6000 14650 6050
Wire Wire Line
	14200 5900 14450 5900
Wire Wire Line
	14650 5900 14650 5850
Text Label 15250 5950 0    50   ~ 0
~shr_oe
Wire Wire Line
	14450 5900 14450 6250
Wire Wire Line
	14450 6250 15250 6250
Connection ~ 14450 5900
Wire Wire Line
	14450 5900 14650 5900
Text Label 15250 6250 0    50   ~ 0
sar_ena
$Comp
L 74xx:74LS32 U11
U 5 1 60F72C9B
P 16200 15000
F 0 "U11" H 16430 15046 50  0000 L CNN
F 1 "74ACT32MTCX" V 15950 14750 50  0000 L CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 16200 15000 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/245063.pdf" H 16200 15000 50  0001 C CNN
	5    16200 15000
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR061
U 1 1 60F77AD4
P 16200 14500
F 0 "#PWR061" H 16200 14350 50  0001 C CNN
F 1 "VCC" H 16217 14673 50  0000 C CNN
F 2 "" H 16200 14500 50  0001 C CNN
F 3 "" H 16200 14500 50  0001 C CNN
	1    16200 14500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR062
U 1 1 60F77F1F
P 16200 15500
F 0 "#PWR062" H 16200 15250 50  0001 C CNN
F 1 "GND" H 16205 15327 50  0000 C CNN
F 2 "" H 16200 15500 50  0001 C CNN
F 3 "" H 16200 15500 50  0001 C CNN
	1    16200 15500
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U11
U 3 1 60F6AD4B
P 16100 9650
F 0 "U11" H 16100 9333 50  0000 C CNN
F 1 "74ACT32MTCX" H 16100 9424 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 16100 9650 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/245063.pdf" H 16100 9650 50  0001 C CNN
	3    16100 9650
	1    0    0    1   
$EndComp
$Comp
L 74xx:74LS32 U11
U 4 1 60F78326
P 15450 9100
F 0 "U11" H 15450 9425 50  0000 C CNN
F 1 "74ACT32MTCX" H 15450 9334 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 15450 9100 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/245063.pdf" H 15450 9100 50  0001 C CNN
	4    15450 9100
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U13
U 2 1 60F845D5
P 16200 13250
F 0 "U13" H 16200 13575 50  0000 C CNN
F 1 "SN74ACT08PW" H 16200 13484 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 16200 13250 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74act08.pdf" H 16200 13250 50  0001 C CNN
	2    16200 13250
	1    0    0    1   
$EndComp
$Comp
L 74xx:74LS08 U15
U 1 1 60F863EA
P 11000 2500
F 0 "U15" H 11000 2825 50  0000 C CNN
F 1 "SN74ACT08PW" H 11000 2734 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 11000 2500 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74act08.pdf" H 11000 2500 50  0001 C CNN
	1    11000 2500
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U15
U 3 1 60F87B24
P 3000 6050
F 0 "U15" H 3000 6375 50  0000 C CNN
F 1 "SN74ACT08PW" H 3000 6284 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 3000 6050 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74act08.pdf" H 3000 6050 50  0001 C CNN
	3    3000 6050
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U15
U 4 1 60F89E7F
P 3850 6900
F 0 "U15" H 3850 7225 50  0000 C CNN
F 1 "SN74ACT08PW" H 3850 7134 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 3850 6900 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74act08.pdf" H 3850 6900 50  0001 C CNN
	4    3850 6900
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U15
U 5 1 60F96106
P 17050 15000
F 0 "U15" H 17280 15046 50  0000 L CNN
F 1 "SN74ACT08PW" V 16800 14750 50  0000 L CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 17050 15000 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74act08.pdf" H 17050 15000 50  0001 C CNN
	5    17050 15000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR064
U 1 1 60F9610C
P 17050 15500
F 0 "#PWR064" H 17050 15250 50  0001 C CNN
F 1 "GND" H 17055 15327 50  0000 C CNN
F 2 "" H 17050 15500 50  0001 C CNN
F 3 "" H 17050 15500 50  0001 C CNN
	1    17050 15500
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR063
U 1 1 60F96112
P 17050 14500
F 0 "#PWR063" H 17050 14350 50  0001 C CNN
F 1 "VCC" H 17067 14673 50  0000 C CNN
F 2 "" H 17050 14500 50  0001 C CNN
F 3 "" H 17050 14500 50  0001 C CNN
	1    17050 14500
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U13
U 3 1 5FC56530
P 15350 12750
F 0 "U13" H 15350 13075 50  0000 C CNN
F 1 "SN74ACT08PW" H 15350 12984 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 15350 12750 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74act08.pdf" H 15350 12750 50  0001 C CNN
	3    15350 12750
	1    0    0    -1  
$EndComp
Text Label 10700 2400 2    50   ~ 0
op0
Text Label 10700 2600 2    50   ~ 0
op1
Wire Wire Line
	12250 2500 11300 2500
Text Label 13600 3200 2    50   ~ 0
op2
Wire Wire Line
	13600 3200 14550 3200
$Comp
L 74xx:74HC86 U36
U 1 1 6104B0C4
P 4000 5950
F 0 "U36" H 4000 6275 50  0000 C CNN
F 1 "MC74ACT86DG" H 4000 6184 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 4000 5950 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/1912674.pdf" H 4000 5950 50  0001 C CNN
	1    4000 5950
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC86 U36
U 2 1 6104DAA0
P 16350 3300
F 0 "U36" H 16350 3625 50  0000 C CNN
F 1 "MC74ACT86DG" H 16350 3534 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 16350 3300 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/1912674.pdf" H 16350 3300 50  0001 C CNN
	2    16350 3300
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC86 U36
U 3 1 61050857
P 15900 1900
F 0 "U36" H 15900 2225 50  0000 C CNN
F 1 "MC74ACT86DG" H 15900 2134 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 15900 1900 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/1912674.pdf" H 15900 1900 50  0001 C CNN
	3    15900 1900
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC86 U36
U 4 1 61054144
P 13600 8550
F 0 "U36" H 13600 8875 50  0000 C CNN
F 1 "MC74ACT86DG" H 13600 8784 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 13600 8550 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/1912674.pdf" H 13600 8550 50  0001 C CNN
	4    13600 8550
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC86 U36
U 5 1 61058652
P 17800 15000
F 0 "U36" H 18030 15046 50  0000 L CNN
F 1 "MC74ACT86DG" V 17550 14750 50  0000 L CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 17800 15000 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/1912674.pdf" H 17800 15000 50  0001 C CNN
	5    17800 15000
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0130
U 1 1 6105C9CB
P 17800 14500
F 0 "#PWR0130" H 17800 14350 50  0001 C CNN
F 1 "VCC" H 17817 14673 50  0000 C CNN
F 2 "" H 17800 14500 50  0001 C CNN
F 3 "" H 17800 14500 50  0001 C CNN
	1    17800 14500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0131
U 1 1 6105D081
P 17800 15500
F 0 "#PWR0131" H 17800 15250 50  0001 C CNN
F 1 "GND" H 17805 15327 50  0000 C CNN
F 2 "" H 17800 15500 50  0001 C CNN
F 3 "" H 17800 15500 50  0001 C CNN
	1    17800 15500
	1    0    0    -1  
$EndComp
Wire Wire Line
	4300 5950 6250 5950
Connection ~ 6250 5950
Wire Wire Line
	6250 5950 6250 5500
Text Label 3700 5850 2    50   ~ 0
invert
Text Label 3700 6050 2    50   ~ 0
int_swap
Wire Wire Line
	15450 3200 16050 3200
Wire Wire Line
	15450 3400 16050 3400
Text Label 15600 3200 0    50   ~ 0
adder_c6_out
Text Label 16650 3300 0    50   ~ 0
flags3
Wire Wire Line
	3300 6050 3700 6050
Text Label 2700 5950 2    50   ~ 0
op2
Text Label 2700 6150 2    50   ~ 0
~sa_ena
$Comp
L 74xx:74LS02 U37
U 1 1 61101419
P 3900 4800
F 0 "U37" H 3900 5125 50  0000 C CNN
F 1 "MC74ACT02DTR2G" H 3900 5034 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 3900 4800 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/2032041.pdf" H 3900 4800 50  0001 C CNN
	1    3900 4800
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS02 U37
U 2 1 61102EBE
P 9750 3850
F 0 "U37" H 9750 4175 50  0000 C CNN
F 1 "MC74ACT02DTR2G" H 9750 4084 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 9750 3850 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/2032041.pdf" H 9750 3850 50  0001 C CNN
	2    9750 3850
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS02 U37
U 3 1 6110502F
P 8950 3750
F 0 "U37" H 8950 4075 50  0000 C CNN
F 1 "MC74ACT02DTR2G" H 8950 3984 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 8950 3750 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/2032041.pdf" H 8950 3750 50  0001 C CNN
	3    8950 3750
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS02 U37
U 4 1 61106DA9
P 13600 9400
F 0 "U37" H 13600 9725 50  0000 C CNN
F 1 "MC74ACT02DTR2G" H 13600 9634 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 13600 9400 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/2032041.pdf" H 13600 9400 50  0001 C CNN
	4    13600 9400
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS02 U37
U 5 1 6110BC0B
P 20850 13750
F 0 "U37" H 21080 13796 50  0000 L CNN
F 1 "MC74ACT02DTR2G" V 20550 13400 50  0000 L CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 20850 13750 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/2032041.pdf" H 20850 13750 50  0001 C CNN
	5    20850 13750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0134
U 1 1 6110BC11
P 20850 14250
F 0 "#PWR0134" H 20850 14000 50  0001 C CNN
F 1 "GND" H 20855 14077 50  0000 C CNN
F 2 "" H 20850 14250 50  0001 C CNN
F 3 "" H 20850 14250 50  0001 C CNN
	1    20850 14250
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0133
U 1 1 6110BC17
P 20850 13250
F 0 "#PWR0133" H 20850 13100 50  0001 C CNN
F 1 "VCC" H 20867 13423 50  0000 C CNN
F 2 "" H 20850 13250 50  0001 C CNN
F 3 "" H 20850 13250 50  0001 C CNN
	1    20850 13250
	1    0    0    -1  
$EndComp
Wire Wire Line
	16950 2000 17400 2000
Connection ~ 17400 2000
Wire Wire Line
	17400 2000 17400 2050
Text Label 15600 1800 2    50   ~ 0
op3
$Comp
L power:VCC #PWR0132
U 1 1 6113D12F
P 15600 2000
F 0 "#PWR0132" H 15600 1850 50  0001 C CNN
F 1 "VCC" V 15618 2127 50  0000 L CNN
F 2 "" H 15600 2000 50  0001 C CNN
F 3 "" H 15600 2000 50  0001 C CNN
	1    15600 2000
	0    -1   -1   0   
$EndComp
Text Label 3600 4700 2    50   ~ 0
op0
Text Label 3600 4900 2    50   ~ 0
op1
Text Label 6150 1400 0    50   ~ 0
~sa_ena
Wire Wire Line
	4150 6900 5150 6900
Connection ~ 5150 6900
Wire Wire Line
	5150 6900 5150 1400
Text Label 4200 6900 0    50   ~ 0
~sb_ena
Text Label 3550 7000 2    50   ~ 0
op3
Text Label 3550 6800 2    50   ~ 0
adder_b_one
Wire Wire Line
	9450 3750 9250 3750
Text Label 10050 3850 0    50   ~ 0
adder_carry_ena
Text Label 9250 3750 0    50   ~ 0
~op1
Wire Wire Line
	8650 3850 8650 3750
Wire Wire Line
	8650 3750 8550 3750
Connection ~ 8650 3750
Wire Wire Line
	8650 3750 8650 3650
Text Label 8550 3750 2    50   ~ 0
op1
Text Label 9450 3950 2    50   ~ 0
op0
$Comp
L 74xx:74LS08 U38
U 1 1 611F3399
P 14600 8650
F 0 "U38" H 14600 8975 50  0000 C CNN
F 1 "SN74ACT08PW" H 14600 8884 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 14600 8650 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74act08.pdf" H 14600 8650 50  0001 C CNN
	1    14600 8650
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U38
U 2 1 611F339F
P 14600 9500
F 0 "U38" H 14600 9825 50  0000 C CNN
F 1 "SN74ACT08PW" H 14600 9734 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 14600 9500 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74act08.pdf" H 14600 9500 50  0001 C CNN
	2    14600 9500
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U38
U 3 1 611F33A5
P 14600 10300
F 0 "U38" H 14600 10625 50  0000 C CNN
F 1 "SN74ACT08PW" H 14600 10534 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 14600 10300 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74act08.pdf" H 14600 10300 50  0001 C CNN
	3    14600 10300
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U38
U 4 1 611F33AB
P 14950 5950
F 0 "U38" H 14950 6275 50  0000 C CNN
F 1 "SN74ACT08PW" H 14950 6184 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 14950 5950 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74act08.pdf" H 14950 5950 50  0001 C CNN
	4    14950 5950
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U38
U 5 1 612068CC
P 21950 11450
F 0 "U38" H 22180 11496 50  0000 L CNN
F 1 "SN74ACT08PW" H 22180 11405 50  0000 L CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 21950 11450 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74act08.pdf" H 21950 11450 50  0001 C CNN
	5    21950 11450
	1    0    0    -1  
$EndComp
Text Label 13300 8450 2    50   ~ 0
~shr_oe
$Comp
L power:VCC #PWR0135
U 1 1 61210B1E
P 13300 8650
F 0 "#PWR0135" H 13300 8500 50  0001 C CNN
F 1 "VCC" V 13318 8777 50  0000 L CNN
F 2 "" H 13300 8650 50  0001 C CNN
F 3 "" H 13300 8650 50  0001 C CNN
	1    13300 8650
	0    -1   -1   0   
$EndComp
Text Label 13900 8550 0    50   ~ 0
shr_oe
Text Label 13150 9400 2    50   ~ 0
~shl_oe
Wire Wire Line
	13300 9300 13300 9400
Wire Wire Line
	13150 9400 13300 9400
Connection ~ 13300 9400
Wire Wire Line
	13300 9400 13300 9500
Text Label 13900 9400 0    50   ~ 0
shl_oe
Wire Wire Line
	14300 8550 13900 8550
Text Label 14300 8750 2    50   ~ 0
sa0
Wire Wire Line
	14300 9400 13900 9400
Text Label 14300 9600 2    50   ~ 0
sa7
Text Label 14300 10200 2    50   ~ 0
adder_c_out
Text Label 14300 10400 2    50   ~ 0
op3
Wire Wire Line
	15150 9000 15000 9000
Wire Wire Line
	15000 9000 15000 8650
Wire Wire Line
	15000 8650 14900 8650
Wire Wire Line
	14900 9500 15000 9500
Wire Wire Line
	15000 9500 15000 9200
Wire Wire Line
	15000 9200 15150 9200
Wire Wire Line
	15800 9550 15750 9550
Wire Wire Line
	15750 9550 15750 9100
Wire Wire Line
	14900 10300 15400 10300
Wire Wire Line
	15400 10300 15400 9750
Wire Wire Line
	15400 9750 15800 9750
Text Label 16400 9650 0    50   ~ 0
flags1
$Comp
L power:GND #PWR0137
U 1 1 6135550A
P 21950 11950
F 0 "#PWR0137" H 21950 11700 50  0001 C CNN
F 1 "GND" H 21955 11777 50  0000 C CNN
F 2 "" H 21950 11950 50  0001 C CNN
F 3 "" H 21950 11950 50  0001 C CNN
	1    21950 11950
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0136
U 1 1 613559CE
P 21950 10950
F 0 "#PWR0136" H 21950 10800 50  0001 C CNN
F 1 "VCC" H 21967 11123 50  0000 C CNN
F 2 "" H 21950 10950 50  0001 C CNN
F 3 "" H 21950 10950 50  0001 C CNN
	1    21950 10950
	1    0    0    -1  
$EndComp
Text Label 16350 2100 2    50   ~ 0
~oe
Wire Wire Line
	16200 1900 16350 1900
Text Label 16250 1900 0    50   ~ 0
~op3
Text Label 15750 9300 0    50   ~ 0
c_sh
Text Label 15000 9400 0    50   ~ 0
c_shl
Text Label 15000 8800 0    50   ~ 0
c_shr
Text Label 15400 10100 0    50   ~ 0
c_adder
Text Label 18350 12500 0    50   ~ 0
flags2
Text Label 18150 12500 0    50   ~ 0
r7
Wire Wire Line
	18150 12500 18350 12500
$Comp
L Device:C C11
U 1 1 614B7270
P 21750 12800
F 0 "C11" H 21865 12846 50  0000 L CNN
F 1 "0.1u" H 21865 12755 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 21788 12650 50  0001 C CNN
F 3 "~" H 21750 12800 50  0001 C CNN
	1    21750 12800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0138
U 1 1 614B7276
P 21750 12950
F 0 "#PWR0138" H 21750 12700 50  0001 C CNN
F 1 "GND" H 21755 12777 50  0000 C CNN
F 2 "" H 21750 12950 50  0001 C CNN
F 3 "" H 21750 12950 50  0001 C CNN
	1    21750 12950
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0139
U 1 1 614B727C
P 21750 12650
F 0 "#PWR0139" H 21750 12500 50  0001 C CNN
F 1 "VCC" H 21767 12823 50  0000 C CNN
F 2 "" H 21750 12650 50  0001 C CNN
F 3 "" H 21750 12650 50  0001 C CNN
	1    21750 12650
	1    0    0    -1  
$EndComp
$Comp
L Device:C C10
U 1 1 614CCB2A
P 21350 12800
F 0 "C10" H 21465 12846 50  0000 L CNN
F 1 "0.1u" H 21465 12755 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 21388 12650 50  0001 C CNN
F 3 "~" H 21350 12800 50  0001 C CNN
	1    21350 12800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0140
U 1 1 614CCB30
P 21350 12950
F 0 "#PWR0140" H 21350 12700 50  0001 C CNN
F 1 "GND" H 21355 12777 50  0000 C CNN
F 2 "" H 21350 12950 50  0001 C CNN
F 3 "" H 21350 12950 50  0001 C CNN
	1    21350 12950
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0141
U 1 1 614CCB36
P 21350 12650
F 0 "#PWR0141" H 21350 12500 50  0001 C CNN
F 1 "VCC" H 21367 12823 50  0000 C CNN
F 2 "" H 21350 12650 50  0001 C CNN
F 3 "" H 21350 12650 50  0001 C CNN
	1    21350 12650
	1    0    0    -1  
$EndComp
Text Label 8400 9150 2    50   ~ 0
sb7
Text Label 8400 8950 2    50   ~ 0
sa7
Text Label 8400 8600 2    50   ~ 0
sb6
Text Label 8400 8400 2    50   ~ 0
sa6
Text Label 8400 8050 2    50   ~ 0
sb5
Text Label 8400 7850 2    50   ~ 0
sa5
Text Label 8400 7500 2    50   ~ 0
sb4
Text Label 8400 7300 2    50   ~ 0
sa4
Text Label 8400 11350 2    50   ~ 0
sb3
Text Label 8400 11150 2    50   ~ 0
sa3
Text Label 8400 10800 2    50   ~ 0
sb2
Text Label 8400 10600 2    50   ~ 0
sa2
Text Label 8400 10250 2    50   ~ 0
sb1
Text Label 8400 10050 2    50   ~ 0
sa1
Text Label 8400 9700 2    50   ~ 0
sb0
Text Label 8400 9500 2    50   ~ 0
sa0
Text Label 10500 9650 0    50   ~ 0
r3
Text Label 10500 9550 0    50   ~ 0
r2
Text Label 10500 9450 0    50   ~ 0
r1
Text Label 10500 9350 0    50   ~ 0
r0
$Comp
L power:VCC #PWR010
U 1 1 5FDA95F7
P 21050 2750
F 0 "#PWR010" H 21050 2600 50  0001 C CNN
F 1 "VCC" H 21067 2923 50  0000 C CNN
F 2 "" H 21050 2750 50  0001 C CNN
F 3 "" H 21050 2750 50  0001 C CNN
	1    21050 2750
	0    1    1    0   
$EndComp
Text Label 20450 2750 2    50   ~ 0
~not_oe
$Comp
L Device:LED D3
U 1 1 5FDDC708
P 17550 2650
F 0 "D3" H 16650 2650 50  0000 C CNN
F 1 "KP-2012EC" H 17543 2486 50  0001 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 17550 2650 50  0001 C CNN
F 3 "~" H 17550 2650 50  0001 C CNN
	1    17550 2650
	-1   0    0    1   
$EndComp
$Comp
L Device:R R3
U 1 1 5FDDC70E
P 17850 2650
F 0 "R3" V 17850 3450 50  0000 C CNN
F 1 "620" V 17850 3800 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 17780 2650 50  0001 C CNN
F 3 "~" H 17850 2650 50  0001 C CNN
	1    17850 2650
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR05
U 1 1 5FDDC714
P 18000 2650
F 0 "#PWR05" H 18000 2500 50  0001 C CNN
F 1 "VCC" H 18017 2823 50  0000 C CNN
F 2 "" H 18000 2650 50  0001 C CNN
F 3 "" H 18000 2650 50  0001 C CNN
	1    18000 2650
	0    1    1    0   
$EndComp
Text Label 17400 2650 2    50   ~ 0
~adder_oe
$Comp
L Device:LED D4
U 1 1 5FDF2CD0
P 18600 4500
F 0 "D4" H 17700 4500 50  0000 C CNN
F 1 "KP-2012EC" H 18593 4336 50  0001 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 18600 4500 50  0001 C CNN
F 3 "~" H 18600 4500 50  0001 C CNN
	1    18600 4500
	-1   0    0    1   
$EndComp
$Comp
L Device:R R4
U 1 1 5FDF2CD6
P 18900 4500
F 0 "R4" V 18900 5300 50  0000 C CNN
F 1 "620" V 18900 5650 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 18830 4500 50  0001 C CNN
F 3 "~" H 18900 4500 50  0001 C CNN
	1    18900 4500
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR06
U 1 1 5FDF2CDC
P 19050 4500
F 0 "#PWR06" H 19050 4350 50  0001 C CNN
F 1 "VCC" H 19067 4673 50  0000 C CNN
F 2 "" H 19050 4500 50  0001 C CNN
F 3 "" H 19050 4500 50  0001 C CNN
	1    19050 4500
	0    1    1    0   
$EndComp
Text Label 18450 4500 2    50   ~ 0
~xor_oe
$Comp
L Device:LED D6
U 1 1 5FE0919F
P 18650 6650
F 0 "D6" H 17750 6650 50  0000 C CNN
F 1 "KP-2012EC" H 18643 6486 50  0001 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 18650 6650 50  0001 C CNN
F 3 "~" H 18650 6650 50  0001 C CNN
	1    18650 6650
	-1   0    0    1   
$EndComp
$Comp
L Device:R R6
U 1 1 5FE091A5
P 18950 6650
F 0 "R6" V 18950 7450 50  0000 C CNN
F 1 "620" V 18950 7800 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 18880 6650 50  0001 C CNN
F 3 "~" H 18950 6650 50  0001 C CNN
	1    18950 6650
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR08
U 1 1 5FE091AB
P 19100 6650
F 0 "#PWR08" H 19100 6500 50  0001 C CNN
F 1 "VCC" H 19117 6823 50  0000 C CNN
F 2 "" H 19100 6650 50  0001 C CNN
F 3 "" H 19100 6650 50  0001 C CNN
	1    19100 6650
	0    1    1    0   
$EndComp
Text Label 18500 6650 2    50   ~ 0
~shl_oe
$Comp
L Device:LED D7
U 1 1 5FE200E5
P 18650 8700
F 0 "D7" H 17750 8700 50  0000 C CNN
F 1 "KP-2012EC" H 18643 8536 50  0001 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 18650 8700 50  0001 C CNN
F 3 "~" H 18650 8700 50  0001 C CNN
	1    18650 8700
	-1   0    0    1   
$EndComp
$Comp
L Device:R R7
U 1 1 5FE200EB
P 18950 8700
F 0 "R7" V 18950 9500 50  0000 C CNN
F 1 "620" V 18950 9850 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 18880 8700 50  0001 C CNN
F 3 "~" H 18950 8700 50  0001 C CNN
	1    18950 8700
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR09
U 1 1 5FE200F1
P 19100 8700
F 0 "#PWR09" H 19100 8550 50  0001 C CNN
F 1 "VCC" H 19117 8873 50  0000 C CNN
F 2 "" H 19100 8700 50  0001 C CNN
F 3 "" H 19100 8700 50  0001 C CNN
	1    19100 8700
	0    1    1    0   
$EndComp
Text Label 18500 8700 2    50   ~ 0
~shr_oe
$Comp
L Device:LED D5
U 1 1 5FE365AB
P 18600 10900
F 0 "D5" H 17700 10900 50  0000 C CNN
F 1 "KP-2012EC" H 18593 10736 50  0001 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 18600 10900 50  0001 C CNN
F 3 "~" H 18600 10900 50  0001 C CNN
	1    18600 10900
	-1   0    0    1   
$EndComp
$Comp
L Device:R R5
U 1 1 5FE365B1
P 18900 10900
F 0 "R5" V 18900 11700 50  0000 C CNN
F 1 "620" V 18900 12050 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 18830 10900 50  0001 C CNN
F 3 "~" H 18900 10900 50  0001 C CNN
	1    18900 10900
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR07
U 1 1 5FE365B7
P 19050 10900
F 0 "#PWR07" H 19050 10750 50  0001 C CNN
F 1 "VCC" H 19067 11073 50  0000 C CNN
F 2 "" H 19050 10900 50  0001 C CNN
F 3 "" H 19050 10900 50  0001 C CNN
	1    19050 10900
	0    1    1    0   
$EndComp
Text Label 18450 10900 2    50   ~ 0
~exp_oe
$Comp
L Device:LED D2
U 1 1 5FE4C529
P 11150 9800
F 0 "D2" H 10250 9800 50  0000 C CNN
F 1 "KP-2012EC" H 11143 9636 50  0001 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 11150 9800 50  0001 C CNN
F 3 "~" H 11150 9800 50  0001 C CNN
	1    11150 9800
	-1   0    0    1   
$EndComp
$Comp
L Device:R R2
U 1 1 5FE4C52F
P 11450 9800
F 0 "R2" V 11450 10600 50  0000 C CNN
F 1 "620" V 11450 10950 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 11380 9800 50  0001 C CNN
F 3 "~" H 11450 9800 50  0001 C CNN
	1    11450 9800
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR04
U 1 1 5FE4C535
P 11600 9800
F 0 "#PWR04" H 11600 9650 50  0001 C CNN
F 1 "VCC" H 11617 9973 50  0000 C CNN
F 2 "" H 11600 9800 50  0001 C CNN
F 3 "" H 11600 9800 50  0001 C CNN
	1    11600 9800
	0    1    1    0   
$EndComp
Text Label 11000 9800 2    50   ~ 0
~or_oe
$Comp
L Device:LED D1
U 1 1 5FE625BB
P 3750 10300
F 0 "D1" H 2850 10300 50  0000 C CNN
F 1 "KP-2012EC" H 3743 10136 50  0001 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 3750 10300 50  0001 C CNN
F 3 "~" H 3750 10300 50  0001 C CNN
	1    3750 10300
	-1   0    0    1   
$EndComp
$Comp
L Device:R R1
U 1 1 5FE625C1
P 4050 10300
F 0 "R1" V 4050 11100 50  0000 C CNN
F 1 "620" V 4050 11450 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 3980 10300 50  0001 C CNN
F 3 "~" H 4050 10300 50  0001 C CNN
	1    4050 10300
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR03
U 1 1 5FE625C7
P 4200 10300
F 0 "#PWR03" H 4200 10150 50  0001 C CNN
F 1 "VCC" H 4217 10473 50  0000 C CNN
F 2 "" H 4200 10300 50  0001 C CNN
F 3 "" H 4200 10300 50  0001 C CNN
	1    4200 10300
	0    1    1    0   
$EndComp
Text Label 3600 10300 2    50   ~ 0
~and_oe
Wire Bus Line
	11450 2600 11450 6600
Wire Bus Line
	7800 6600 7800 9750
Wire Bus Line
	7800 1950 7800 5300
Wire Bus Line
	5350 1650 5350 5700
Wire Wire Line
	5450 2100 6350 2100
Wire Wire Line
	5450 2400 6350 2400
Wire Wire Line
	5450 2700 6350 2700
Wire Wire Line
	5450 3000 6350 3000
Wire Wire Line
	5450 4300 6350 4300
Wire Wire Line
	5450 4600 6350 4600
Wire Wire Line
	5450 4900 6350 4900
Wire Bus Line
	5850 1500 5850 5500
Wire Wire Line
	5450 5200 6350 5200
Wire Bus Line
	5350 6000 5350 9550
Wire Wire Line
	5450 6550 6350 6550
Wire Wire Line
	5450 6850 6350 6850
Wire Wire Line
	5450 7150 6350 7150
Wire Wire Line
	5450 7450 6350 7450
Wire Wire Line
	5450 8750 6350 8750
Wire Wire Line
	5450 9050 6350 9050
Wire Bus Line
	5850 5700 5850 9650
Wire Wire Line
	5450 9350 6350 9350
Wire Wire Line
	5450 9650 6350 9650
Wire Bus Line
	12350 2900 14550 2900
Wire Bus Line
	12350 2900 12350 6650
Wire Bus Line
	1250 3200 1250 4000
Wire Bus Line
	1250 1500 1250 3050
Wire Bus Line
	1900 1650 1900 2950
Wire Bus Line
	3450 2050 3450 2950
Wire Bus Line
	3450 3050 3450 3550
$Comp
L Device:R R8
U 1 1 5FD786CC
P 20900 2750
F 0 "R8" V 20900 3550 50  0000 C CNN
F 1 "620" V 20900 3900 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 20830 2750 50  0001 C CNN
F 3 "~" H 20900 2750 50  0001 C CNN
	1    20900 2750
	0    1    1    0   
$EndComp
$EndSCHEMATC
