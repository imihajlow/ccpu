EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 9 10
Title "Memory and IO"
Date "2020-01-02"
Rev "1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 1500 1200 0    50   Input ~ 0
a[0..15]
Text HLabel 1500 1300 0    50   BiDi ~ 0
d[0..7]
Text HLabel 1500 1700 0    50   Input ~ 0
~oe
Text HLabel 1500 1800 0    50   Input ~ 0
~we
Text HLabel 1500 1900 0    50   Output ~ 0
~rdy
Text HLabel 1500 2000 0    50   Input ~ 0
clk
Text HLabel 1500 2100 0    50   Input ~ 0
~rst
Text Notes 2000 1050 0    50   ~ 0
0000-7FFF - ROM\n8000-EFFF - RAM\nF000-FFFF - IO
$Comp
L Memory_EEPROM:28C256 U?
U 1 1 5EC757DC
P 3750 2650
F 0 "U?" H 4150 1700 50  0000 C CNN
F 1 "28C256" H 4100 1600 50  0000 C CNN
F 2 "" H 3750 2650 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/doc0006.pdf" H 3750 2650 50  0001 C CNN
	1    3750 2650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EC7B846
P 3750 3750
F 0 "#PWR?" H 3750 3500 50  0001 C CNN
F 1 "GND" H 3755 3577 50  0000 C CNN
F 2 "" H 3750 3750 50  0001 C CNN
F 3 "" H 3750 3750 50  0001 C CNN
	1    3750 3750
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5EC7BF31
P 3750 1550
F 0 "#PWR?" H 3750 1400 50  0001 C CNN
F 1 "VCC" H 3767 1723 50  0000 C CNN
F 2 "" H 3750 1550 50  0001 C CNN
F 3 "" H 3750 1550 50  0001 C CNN
	1    3750 1550
	1    0    0    -1  
$EndComp
Entry Wire Line
	2800 1850 2900 1750
Entry Wire Line
	2800 1950 2900 1850
Entry Wire Line
	2800 2050 2900 1950
Entry Wire Line
	2800 2150 2900 2050
Entry Wire Line
	2800 2250 2900 2150
Entry Wire Line
	2800 2350 2900 2250
Entry Wire Line
	2800 2450 2900 2350
Entry Wire Line
	2800 2550 2900 2450
Entry Wire Line
	2800 2650 2900 2550
Entry Wire Line
	2800 2750 2900 2650
Entry Wire Line
	2800 2850 2900 2750
Entry Wire Line
	2800 2950 2900 2850
Entry Wire Line
	2800 3050 2900 2950
Entry Wire Line
	2800 3150 2900 3050
Entry Wire Line
	2800 3250 2900 3150
Entry Wire Line
	2800 3650 2900 3550
Wire Wire Line
	3350 1750 2900 1750
Wire Wire Line
	2900 1850 3350 1850
Wire Wire Line
	3350 1950 2900 1950
Wire Wire Line
	2900 2050 3350 2050
Wire Wire Line
	3350 2150 2900 2150
Wire Wire Line
	2900 2250 3350 2250
Wire Wire Line
	3350 2350 2900 2350
Wire Wire Line
	2900 2450 3350 2450
Wire Wire Line
	3350 2550 2900 2550
Wire Wire Line
	2900 2650 3350 2650
Wire Wire Line
	3350 2750 2900 2750
Wire Wire Line
	2900 2850 3350 2850
Wire Wire Line
	3350 2950 2900 2950
Wire Wire Line
	2900 3050 3350 3050
Wire Wire Line
	3350 3150 2900 3150
Wire Wire Line
	2900 3550 3350 3550
Wire Wire Line
	2500 3450 2500 1700
Wire Wire Line
	2500 1700 1500 1700
Wire Wire Line
	2500 3450 3350 3450
Text Label 3000 1750 2    50   ~ 0
a0
Text Label 2900 1850 0    50   ~ 0
a1
Text Label 2900 1950 0    50   ~ 0
a2
Text Label 2900 2050 0    50   ~ 0
a3
Text Label 2900 2150 0    50   ~ 0
a4
Text Label 2900 2250 0    50   ~ 0
a5
Text Label 2900 2350 0    50   ~ 0
a6
Text Label 2900 2550 0    50   ~ 0
a8
Text Label 2900 2450 0    50   ~ 0
a7
Text Label 2900 2650 0    50   ~ 0
a9
Text Label 2900 2750 0    50   ~ 0
a10
Text Label 2900 2850 0    50   ~ 0
a11
Text Label 2900 2950 0    50   ~ 0
a12
Text Label 2900 3050 0    50   ~ 0
a13
Text Label 2900 3150 0    50   ~ 0
a14
Text Label 2900 3550 0    50   ~ 0
a15
Entry Wire Line
	4400 2450 4500 2350
Entry Wire Line
	4400 2350 4500 2250
Entry Wire Line
	4400 2250 4500 2150
Entry Wire Line
	4400 2150 4500 2050
Entry Wire Line
	4400 2050 4500 1950
Entry Wire Line
	4400 1950 4500 1850
Entry Wire Line
	4400 1850 4500 1750
Entry Wire Line
	4400 1750 4500 1650
Wire Wire Line
	4400 1750 4150 1750
Wire Wire Line
	4150 1850 4400 1850
Wire Wire Line
	4400 1950 4150 1950
Wire Wire Line
	4150 2050 4400 2050
Wire Wire Line
	4400 2150 4150 2150
Wire Wire Line
	4150 2250 4400 2250
Wire Wire Line
	4400 2350 4150 2350
Wire Wire Line
	4150 2450 4400 2450
Text Label 4250 1750 0    50   ~ 0
d0
Text Label 4250 1850 0    50   ~ 0
d1
Text Label 4250 1950 0    50   ~ 0
d2
Text Label 4250 2050 0    50   ~ 0
d3
Text Label 4250 2150 0    50   ~ 0
d4
Text Label 4250 2250 0    50   ~ 0
d5
Text Label 4250 2350 0    50   ~ 0
d6
Text Label 4250 2450 0    50   ~ 0
d7
$Comp
L missing:62256-TSOP U?
U 1 1 5EC8A148
P 6500 2650
F 0 "U?" H 7000 1650 50  0000 C CNN
F 1 "62256-TSOP" H 7000 1550 50  0000 C CNN
F 2 "Package_SO:TSOP-I-28_11.8x8mm_P0.55mm" H 6500 3500 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/1674430.pdf" H 6500 3500 50  0001 C CNN
	1    6500 2650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EC90E88
P 6500 3750
F 0 "#PWR?" H 6500 3500 50  0001 C CNN
F 1 "GND" H 6505 3577 50  0000 C CNN
F 2 "" H 6500 3750 50  0001 C CNN
F 3 "" H 6500 3750 50  0001 C CNN
	1    6500 3750
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5EC91550
P 6500 1600
F 0 "#PWR?" H 6500 1450 50  0001 C CNN
F 1 "VCC" H 6517 1773 50  0000 C CNN
F 2 "" H 6500 1600 50  0001 C CNN
F 3 "" H 6500 1600 50  0001 C CNN
	1    6500 1600
	1    0    0    -1  
$EndComp
Entry Wire Line
	7250 2500 7350 2400
Entry Wire Line
	7250 2400 7350 2300
Entry Wire Line
	7250 2300 7350 2200
Entry Wire Line
	7250 2200 7350 2100
Entry Wire Line
	7250 2100 7350 2000
Entry Wire Line
	7250 2000 7350 1900
Entry Wire Line
	7250 1900 7350 1800
Entry Wire Line
	7250 1800 7350 1700
Wire Wire Line
	7250 1800 7000 1800
Wire Wire Line
	7000 1900 7250 1900
Wire Wire Line
	7250 2000 7000 2000
Wire Wire Line
	7000 2100 7250 2100
Wire Wire Line
	7250 2200 7000 2200
Wire Wire Line
	7000 2300 7250 2300
Wire Wire Line
	7250 2400 7000 2400
Wire Wire Line
	7000 2500 7250 2500
Text Label 7100 1800 0    50   ~ 0
d0
Text Label 7100 1900 0    50   ~ 0
d1
Text Label 7100 2000 0    50   ~ 0
d2
Text Label 7100 2100 0    50   ~ 0
d3
Text Label 7100 2200 0    50   ~ 0
d4
Text Label 7100 2300 0    50   ~ 0
d5
Text Label 7100 2400 0    50   ~ 0
d6
Text Label 7100 2500 0    50   ~ 0
d7
Wire Bus Line
	7350 1300 4500 1300
Connection ~ 4500 1300
Entry Wire Line
	5450 1900 5550 1800
Entry Wire Line
	5450 2000 5550 1900
Entry Wire Line
	5450 2100 5550 2000
Entry Wire Line
	5450 2200 5550 2100
Entry Wire Line
	5450 2300 5550 2200
Entry Wire Line
	5450 2400 5550 2300
Entry Wire Line
	5450 2500 5550 2400
Entry Wire Line
	5450 2600 5550 2500
Entry Wire Line
	5450 2700 5550 2600
Entry Wire Line
	5450 2800 5550 2700
Entry Wire Line
	5450 2900 5550 2800
Entry Wire Line
	5450 3000 5550 2900
Entry Wire Line
	5450 3100 5550 3000
Entry Wire Line
	5450 3200 5550 3100
Entry Wire Line
	5450 3300 5550 3200
Wire Wire Line
	6000 1800 5550 1800
Wire Wire Line
	5550 1900 6000 1900
Wire Wire Line
	6000 2000 5550 2000
Wire Wire Line
	5550 2100 6000 2100
Wire Wire Line
	6000 2200 5550 2200
Wire Wire Line
	5550 2300 6000 2300
Wire Wire Line
	6000 2400 5550 2400
Wire Wire Line
	5550 2500 6000 2500
Wire Wire Line
	6000 2600 5550 2600
Wire Wire Line
	5550 2700 6000 2700
Wire Wire Line
	6000 2800 5550 2800
Wire Wire Line
	5550 2900 6000 2900
Wire Wire Line
	6000 3000 5550 3000
Wire Wire Line
	5550 3100 6000 3100
Wire Wire Line
	6000 3200 5550 3200
Text Label 5650 1800 2    50   ~ 0
a0
Text Label 5550 1900 0    50   ~ 0
a1
Text Label 5550 2000 0    50   ~ 0
a2
Text Label 5550 2100 0    50   ~ 0
a3
Text Label 5550 2200 0    50   ~ 0
a4
Text Label 5550 2300 0    50   ~ 0
a5
Text Label 5550 2400 0    50   ~ 0
a6
Text Label 5550 2600 0    50   ~ 0
a8
Text Label 5550 2500 0    50   ~ 0
a7
Text Label 5550 2700 0    50   ~ 0
a9
Text Label 5550 2800 0    50   ~ 0
a10
Text Label 5550 2900 0    50   ~ 0
a11
Text Label 5550 3000 0    50   ~ 0
a12
Text Label 5550 3100 0    50   ~ 0
a13
Text Label 5550 3200 0    50   ~ 0
a14
Wire Bus Line
	5450 1200 2800 1200
Wire Bus Line
	1500 1300 4500 1300
Connection ~ 2800 1200
Wire Bus Line
	2800 1200 1500 1200
Wire Wire Line
	2500 3450 2500 4000
Wire Wire Line
	2500 4000 5450 4000
Wire Wire Line
	5450 4000 5450 3500
Wire Wire Line
	5450 3500 6000 3500
Connection ~ 2500 3450
Wire Wire Line
	1500 1800 2400 1800
Wire Wire Line
	2400 1800 2400 4100
Wire Wire Line
	2400 4100 5550 4100
Wire Wire Line
	5550 4100 5550 3400
Wire Wire Line
	5550 3400 6000 3400
$Comp
L 74xx:74LS20 U?
U 1 1 5ECB09FD
P 3650 4850
F 0 "U?" H 3650 5225 50  0000 C CNN
F 1 "74AC20" H 3650 5134 50  0000 C CNN
F 2 "" H 3650 4850 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS20" H 3650 4850 50  0001 C CNN
	1    3650 4850
	1    0    0    -1  
$EndComp
Entry Wire Line
	2800 5100 2900 5000
Entry Wire Line
	2800 4800 2900 4700
Entry Wire Line
	2800 4900 2900 4800
Entry Wire Line
	2800 5000 2900 4900
Wire Wire Line
	3350 4700 2900 4700
Wire Wire Line
	2900 4800 3350 4800
Wire Wire Line
	3350 4900 2900 4900
Text Label 2900 4700 0    50   ~ 0
a12
Text Label 2900 4800 0    50   ~ 0
a13
Text Label 2900 4900 0    50   ~ 0
a14
Wire Wire Line
	2900 5000 3350 5000
Text Label 2900 5000 0    50   ~ 0
a15
$Comp
L 74xx:74LS20 U?
U 2 1 5ECBEAD0
P 3650 5550
F 0 "U?" H 3900 5750 50  0000 C CNN
F 1 "74AC20" H 3950 5450 50  0000 C CNN
F 2 "" H 3650 5550 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS20" H 3650 5550 50  0001 C CNN
	2    3650 5550
	1    0    0    -1  
$EndComp
Wire Wire Line
	3950 5550 5650 5550
Wire Wire Line
	5650 5550 5650 3600
Wire Wire Line
	5650 3600 6000 3600
Wire Wire Line
	3950 4850 4100 4850
Wire Wire Line
	4100 4850 4100 5150
Wire Wire Line
	4100 5150 3200 5150
Wire Wire Line
	3200 5150 3200 5400
Wire Wire Line
	3200 5400 3350 5400
Entry Wire Line
	2800 5600 2900 5500
Wire Wire Line
	2900 5500 3350 5500
Text Label 2900 5500 0    50   ~ 0
a15
$Comp
L 74xx:74LS20 U?
U 3 1 5ECCA4CA
P 9550 4750
F 0 "U?" H 9780 4796 50  0000 L CNN
F 1 "74LS20" H 9780 4705 50  0000 L CNN
F 2 "" H 9550 4750 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS20" H 9550 4750 50  0001 C CNN
	3    9550 4750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5ECCC6F9
P 9550 5250
F 0 "#PWR?" H 9550 5000 50  0001 C CNN
F 1 "GND" H 9555 5077 50  0000 C CNN
F 2 "" H 9550 5250 50  0001 C CNN
F 3 "" H 9550 5250 50  0001 C CNN
	1    9550 5250
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5ECCCCC9
P 9550 4250
F 0 "#PWR?" H 9550 4100 50  0001 C CNN
F 1 "VCC" H 9567 4423 50  0000 C CNN
F 2 "" H 9550 4250 50  0001 C CNN
F 3 "" H 9550 4250 50  0001 C CNN
	1    9550 4250
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5ECCD27F
P 3350 5600
F 0 "#PWR?" H 3350 5450 50  0001 C CNN
F 1 "VCC" V 3368 5727 50  0000 L CNN
F 2 "" H 3350 5600 50  0001 C CNN
F 3 "" H 3350 5600 50  0001 C CNN
	1    3350 5600
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5ECCEA82
P 3350 5700
F 0 "#PWR?" H 3350 5550 50  0001 C CNN
F 1 "VCC" V 3368 5827 50  0000 L CNN
F 2 "" H 3350 5700 50  0001 C CNN
F 3 "" H 3350 5700 50  0001 C CNN
	1    3350 5700
	0    -1   -1   0   
$EndComp
Connection ~ 4100 4850
Text Label 4300 4850 0    50   ~ 0
~io_cs
$Comp
L Device:C C?
U 1 1 5ECD4834
P 7300 3050
F 0 "C?" H 7415 3096 50  0000 L CNN
F 1 "0.1u" H 7415 3005 50  0000 L CNN
F 2 "" H 7338 2900 50  0001 C CNN
F 3 "~" H 7300 3050 50  0001 C CNN
	1    7300 3050
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5ECD56B7
P 7300 2900
F 0 "#PWR?" H 7300 2750 50  0001 C CNN
F 1 "VCC" H 7317 3073 50  0000 C CNN
F 2 "" H 7300 2900 50  0001 C CNN
F 3 "" H 7300 2900 50  0001 C CNN
	1    7300 2900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5ECD5FFC
P 7300 3200
F 0 "#PWR?" H 7300 2950 50  0001 C CNN
F 1 "GND" H 7305 3027 50  0000 C CNN
F 2 "" H 7300 3200 50  0001 C CNN
F 3 "" H 7300 3200 50  0001 C CNN
	1    7300 3200
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 5ECD6CFA
P 4350 3150
F 0 "C?" H 4465 3196 50  0000 L CNN
F 1 "0.1u" H 4465 3105 50  0000 L CNN
F 2 "" H 4388 3000 50  0001 C CNN
F 3 "~" H 4350 3150 50  0001 C CNN
	1    4350 3150
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5ECD6D00
P 4350 3000
F 0 "#PWR?" H 4350 2850 50  0001 C CNN
F 1 "VCC" H 4367 3173 50  0000 C CNN
F 2 "" H 4350 3000 50  0001 C CNN
F 3 "" H 4350 3000 50  0001 C CNN
	1    4350 3000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5ECD6D06
P 4350 3300
F 0 "#PWR?" H 4350 3050 50  0001 C CNN
F 1 "GND" H 4355 3127 50  0000 C CNN
F 2 "" H 4350 3300 50  0001 C CNN
F 3 "" H 4350 3300 50  0001 C CNN
	1    4350 3300
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 5ECDA802
P 9000 4750
F 0 "C?" H 9115 4796 50  0000 L CNN
F 1 "0.1u" H 9115 4705 50  0000 L CNN
F 2 "" H 9038 4600 50  0001 C CNN
F 3 "~" H 9000 4750 50  0001 C CNN
	1    9000 4750
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5ECDA808
P 9000 4600
F 0 "#PWR?" H 9000 4450 50  0001 C CNN
F 1 "VCC" H 9017 4773 50  0000 C CNN
F 2 "" H 9000 4600 50  0001 C CNN
F 3 "" H 9000 4600 50  0001 C CNN
	1    9000 4600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5ECDA80E
P 9000 4900
F 0 "#PWR?" H 9000 4650 50  0001 C CNN
F 1 "GND" H 9005 4727 50  0000 C CNN
F 2 "" H 9000 4900 50  0001 C CNN
F 3 "" H 9000 4900 50  0001 C CNN
	1    9000 4900
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS02 U?
U 1 1 5ECE1479
P 6750 4800
F 0 "U?" H 6750 5125 50  0000 C CNN
F 1 "74LS02" H 6750 5034 50  0000 C CNN
F 2 "" H 6750 4800 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74ls02" H 6750 4800 50  0001 C CNN
	1    6750 4800
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS02 U?
U 2 1 5ECE8843
P 6750 5500
F 0 "U?" H 6750 5825 50  0000 C CNN
F 1 "74LS02" H 6750 5734 50  0000 C CNN
F 2 "" H 6750 5500 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74ls02" H 6750 5500 50  0001 C CNN
	2    6750 5500
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS02 U?
U 5 1 5ECEB0A9
P 10800 4750
F 0 "U?" H 11030 4796 50  0000 L CNN
F 1 "74LS02" H 11030 4705 50  0000 L CNN
F 2 "" H 10800 4750 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74ls02" H 10800 4750 50  0001 C CNN
	5    10800 4750
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5ECEF161
P 10800 4250
F 0 "#PWR?" H 10800 4100 50  0001 C CNN
F 1 "VCC" H 10817 4423 50  0000 C CNN
F 2 "" H 10800 4250 50  0001 C CNN
F 3 "" H 10800 4250 50  0001 C CNN
	1    10800 4250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5ECEF827
P 10800 5250
F 0 "#PWR?" H 10800 5000 50  0001 C CNN
F 1 "GND" H 10805 5077 50  0000 C CNN
F 2 "" H 10800 5250 50  0001 C CNN
F 3 "" H 10800 5250 50  0001 C CNN
	1    10800 5250
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 5ECF04C3
P 10300 4750
F 0 "C?" H 10415 4796 50  0000 L CNN
F 1 "0.1u" H 10415 4705 50  0000 L CNN
F 2 "" H 10338 4600 50  0001 C CNN
F 3 "~" H 10300 4750 50  0001 C CNN
	1    10300 4750
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5ECF04C9
P 10300 4600
F 0 "#PWR?" H 10300 4450 50  0001 C CNN
F 1 "VCC" H 10317 4773 50  0000 C CNN
F 2 "" H 10300 4600 50  0001 C CNN
F 3 "" H 10300 4600 50  0001 C CNN
	1    10300 4600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5ECF04CF
P 10300 4900
F 0 "#PWR?" H 10300 4650 50  0001 C CNN
F 1 "GND" H 10305 4727 50  0000 C CNN
F 2 "" H 10300 4900 50  0001 C CNN
F 3 "" H 10300 4900 50  0001 C CNN
	1    10300 4900
	1    0    0    -1  
$EndComp
Wire Wire Line
	6450 4900 6450 4800
Wire Wire Line
	6450 4800 6250 4800
Connection ~ 6450 4800
Wire Wire Line
	6450 4800 6450 4700
Text Label 6250 4800 2    50   ~ 0
~io_rdy
Wire Wire Line
	7050 4800 7050 5100
Wire Wire Line
	7050 5100 6450 5100
Wire Wire Line
	6450 5100 6450 5400
Wire Wire Line
	6450 5600 5850 5600
Wire Wire Line
	5850 5600 5850 4850
Wire Wire Line
	4100 4850 5850 4850
Wire Wire Line
	1500 1900 2300 1900
Wire Wire Line
	2300 1900 2300 5900
Wire Wire Line
	2300 5900 7050 5900
Wire Wire Line
	7050 5900 7050 5500
$Comp
L power:VCC #PWR?
U 1 1 5ED0A785
P 3350 3350
F 0 "#PWR?" H 3350 3200 50  0001 C CNN
F 1 "VCC" V 3368 3477 50  0000 L CNN
F 2 "" H 3350 3350 50  0001 C CNN
F 3 "" H 3350 3350 50  0001 C CNN
	1    3350 3350
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EDD5828
P 9950 1400
F 0 "#PWR?" H 9950 1150 50  0001 C CNN
F 1 "GND" V 9955 1272 50  0000 R CNN
F 2 "" H 9950 1400 50  0001 C CNN
F 3 "" H 9950 1400 50  0001 C CNN
	1    9950 1400
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EDD64B3
P 9450 2600
F 0 "#PWR?" H 9450 2350 50  0001 C CNN
F 1 "GND" V 9455 2472 50  0000 R CNN
F 2 "" H 9450 2600 50  0001 C CNN
F 3 "" H 9450 2600 50  0001 C CNN
	1    9450 2600
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5EDD71B4
P 9450 1400
F 0 "#PWR?" H 9450 1250 50  0001 C CNN
F 1 "VCC" V 9468 1527 50  0000 L CNN
F 2 "" H 9450 1400 50  0001 C CNN
F 3 "" H 9450 1400 50  0001 C CNN
	1    9450 1400
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5EDD7F36
P 9950 2600
F 0 "#PWR?" H 9950 2450 50  0001 C CNN
F 1 "VCC" V 9967 2728 50  0000 L CNN
F 2 "" H 9950 2600 50  0001 C CNN
F 3 "" H 9950 2600 50  0001 C CNN
	1    9950 2600
	0    1    1    0   
$EndComp
Text Label 9950 2500 0    50   ~ 0
~io_rdy
Text Label 9950 2300 0    50   ~ 0
~io_cs
Text Label 1750 1800 0    50   ~ 0
~we
Text Label 1750 1700 0    50   ~ 0
~oe
Text Label 1500 2000 0    50   ~ 0
clk
Text Label 1500 2100 0    50   ~ 0
~rst
Text Label 9450 2400 2    50   ~ 0
~oe
Text Label 9450 2500 2    50   ~ 0
~we
Text Label 9950 2400 0    50   ~ 0
~rst
Text Label 9450 2300 2    50   ~ 0
clk
Entry Wire Line
	10300 1600 10400 1500
Entry Wire Line
	10300 1500 10400 1400
Wire Wire Line
	9950 1500 10300 1500
Wire Wire Line
	10300 1600 9950 1600
Entry Wire Line
	10300 1800 10400 1700
Entry Wire Line
	10300 1700 10400 1600
Wire Wire Line
	9950 1700 10300 1700
Wire Wire Line
	10300 1800 9950 1800
Entry Wire Line
	9100 1600 9200 1500
Entry Wire Line
	9100 1700 9200 1600
Wire Wire Line
	9450 1500 9200 1500
Wire Wire Line
	9200 1600 9450 1600
Entry Wire Line
	9100 1800 9200 1700
Entry Wire Line
	9100 1900 9200 1800
Wire Wire Line
	9450 1700 9200 1700
Wire Wire Line
	9200 1800 9450 1800
Text Label 9250 1500 0    50   ~ 0
a0
Text Label 9250 1600 0    50   ~ 0
a2
Text Label 9250 1700 0    50   ~ 0
a4
Text Label 9250 1800 0    50   ~ 0
a6
Text Label 10100 1500 0    50   ~ 0
a1
Text Label 10100 1600 0    50   ~ 0
a3
Text Label 10100 1700 0    50   ~ 0
a5
Text Label 10100 1800 0    50   ~ 0
a7
$Comp
L Connector_Generic:Conn_02x13_Odd_Even J?
U 1 1 5EEDDD9A
P 9650 2000
F 0 "J?" H 9700 2817 50  0000 C CNN
F 1 "IO" H 9700 2726 50  0000 C CNN
F 2 "" H 9650 2000 50  0001 C CNN
F 3 "~" H 9650 2000 50  0001 C CNN
	1    9650 2000
	1    0    0    -1  
$EndComp
Text Label 10100 2200 0    50   ~ 0
d7
Text Label 10100 2100 0    50   ~ 0
d5
Text Label 10100 2000 0    50   ~ 0
d3
Text Label 10100 1900 0    50   ~ 0
d1
Wire Wire Line
	9950 1900 10300 1900
Wire Wire Line
	10300 2000 9950 2000
Wire Wire Line
	9950 2100 10300 2100
Wire Wire Line
	10300 2200 9950 2200
Entry Wire Line
	10300 2200 10400 2100
Entry Wire Line
	10300 2100 10400 2000
Entry Wire Line
	10300 2000 10400 1900
Entry Wire Line
	10300 1900 10400 1800
Text Label 9250 2200 0    50   ~ 0
d6
Text Label 9250 2100 0    50   ~ 0
d4
Text Label 9250 2000 0    50   ~ 0
d2
Text Label 9250 1900 0    50   ~ 0
d0
Wire Wire Line
	9200 2200 9450 2200
Wire Wire Line
	9450 2100 9200 2100
Wire Wire Line
	9200 2000 9450 2000
Wire Wire Line
	9450 1900 9200 1900
Entry Wire Line
	9100 2000 9200 1900
Entry Wire Line
	9100 2100 9200 2000
Entry Wire Line
	9100 2200 9200 2100
Entry Wire Line
	9100 2300 9200 2200
Wire Bus Line
	10400 1100 9100 1100
Wire Bus Line
	5450 1200 9100 1200
Wire Bus Line
	9100 1100 9100 1200
Connection ~ 5450 1200
Connection ~ 9100 1200
Wire Bus Line
	10400 2750 9100 2750
Wire Bus Line
	9100 2000 7350 2000
Wire Bus Line
	10400 1100 10400 1700
Wire Bus Line
	7350 1300 7350 2000
Wire Bus Line
	9100 1200 9100 1900
Wire Bus Line
	10400 1800 10400 2750
Wire Bus Line
	9100 2000 9100 2750
Wire Bus Line
	7350 2000 7350 2400
Wire Bus Line
	4500 1300 4500 2350
Wire Bus Line
	5450 1200 5450 3300
Wire Bus Line
	2800 1200 2800 5600
Connection ~ 7350 2000
$EndSCHEMATC
