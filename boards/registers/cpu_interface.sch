EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 9 10
Title "CPU interface"
Date "2020-01-27"
Rev "2"
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
	2500 1700 1500 1700
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
Text Label 2900 3250 0    50   ~ 0
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
Wire Bus Line
	1500 1300 4500 1300
Wire Wire Line
	1500 1800 2400 1800
Wire Wire Line
	1500 1900 2300 1900
Text Label 1750 1800 0    50   ~ 0
~we
Text Label 1750 1700 0    50   ~ 0
~oe
Text Label 1500 2000 0    50   ~ 0
clk
Text Label 1500 2100 0    50   ~ 0
~rst
Text Label 1850 1900 2    50   ~ 0
~rdy
Wire Bus Line
	2800 1200 1500 1200
Entry Wire Line
	2800 3350 2900 3250
Wire Wire Line
	3350 3250 2900 3250
$Comp
L Connector_Generic:Conn_02x20_Odd_Even J?
U 1 1 6056FC88
P 5850 2400
AR Path="/5EA8B32C/6056FC88" Ref="J?"  Part="1" 
AR Path="/5EC337E5/6056FC88" Ref="J5"  Part="1" 
F 0 "J5" H 5900 3517 50  0000 C CNN
F 1 "SSW-120-02-G-D-RA" H 5900 3426 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_2x20_P2.54mm_Horizontal" H 5850 2400 50  0001 C CNN
F 3 "~" H 5850 2400 50  0001 C CNN
	1    5850 2400
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR01
U 1 1 605782E8
P 5650 1500
F 0 "#PWR01" H 5650 1350 50  0001 C CNN
F 1 "VCC" V 5668 1627 50  0000 L CNN
F 2 "" H 5650 1500 50  0001 C CNN
F 3 "" H 5650 1500 50  0001 C CNN
	1    5650 1500
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR05
U 1 1 60578B8C
P 6150 1500
F 0 "#PWR05" H 6150 1250 50  0001 C CNN
F 1 "GND" V 6155 1372 50  0000 R CNN
F 2 "" H 6150 1500 50  0001 C CNN
F 3 "" H 6150 1500 50  0001 C CNN
	1    6150 1500
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR02
U 1 1 60579116
P 5650 3400
F 0 "#PWR02" H 5650 3150 50  0001 C CNN
F 1 "GND" V 5655 3272 50  0000 R CNN
F 2 "" H 5650 3400 50  0001 C CNN
F 3 "" H 5650 3400 50  0001 C CNN
	1    5650 3400
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR06
U 1 1 605798F3
P 6150 3400
F 0 "#PWR06" H 6150 3250 50  0001 C CNN
F 1 "VCC" V 6167 3528 50  0000 L CNN
F 2 "" H 6150 3400 50  0001 C CNN
F 3 "" H 6150 3400 50  0001 C CNN
	1    6150 3400
	0    1    1    0   
$EndComp
Text Label 6150 3300 0    50   ~ 0
a15
Text Label 6150 3200 0    50   ~ 0
a13
Text Label 6150 3100 0    50   ~ 0
a11
Text Label 6150 3000 0    50   ~ 0
a9
Text Label 6150 2900 0    50   ~ 0
a7
Text Label 6150 2800 0    50   ~ 0
a5
Text Label 6150 2700 0    50   ~ 0
a3
Text Label 6150 2600 0    50   ~ 0
a1
Text Label 5650 2600 2    50   ~ 0
a0
Text Label 5650 2700 2    50   ~ 0
a2
Text Label 5650 2800 2    50   ~ 0
a4
Text Label 5650 2900 2    50   ~ 0
a6
Text Label 5650 3000 2    50   ~ 0
a8
Text Label 5650 3100 2    50   ~ 0
a10
Text Label 5650 3200 2    50   ~ 0
a12
Text Label 5650 3300 2    50   ~ 0
a14
Text Label 5650 1800 2    50   ~ 0
~oe
Text Label 6150 1800 0    50   ~ 0
~we
Text Label 5650 1700 2    50   ~ 0
~rdy
Text Label 5650 1600 2    50   ~ 0
clk
Text Label 6150 1600 0    50   ~ 0
~rst
Text Label 5650 2000 2    50   ~ 0
d0
Text Label 5650 2100 2    50   ~ 0
d2
Text Label 5650 2200 2    50   ~ 0
d4
Text Label 5650 2300 2    50   ~ 0
d6
Text Label 6150 2000 0    50   ~ 0
d1
Text Label 6150 2100 0    50   ~ 0
d3
Text Label 6150 2200 0    50   ~ 0
d5
Text Label 6150 2300 0    50   ~ 0
d7
NoConn ~ 5650 2500
NoConn ~ 5650 2400
NoConn ~ 6150 2500
NoConn ~ 6150 2400
NoConn ~ 6150 1900
NoConn ~ 5650 1900
NoConn ~ 6150 1700
Wire Bus Line
	4500 1300 4500 2350
Wire Bus Line
	2800 1200 2800 3350
$EndSCHEMATC
