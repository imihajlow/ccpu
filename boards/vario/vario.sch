EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A2 23386 16535
encoding utf-8
Sheet 1 3
Title "Various IO module"
Date "2020-12-23"
Rev "1"
Comp "Licensed under the TAPR Open Hardware License (www.tapr.org/OHL)"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector_Generic:Conn_02x20_Odd_Even J1
U 1 1 5FE386D6
P 2000 2550
F 0 "J1" H 2050 3667 50  0000 C CNN
F 1 "Conn_02x20_Odd_Even" H 2050 3576 50  0000 C CNN
F 2 "" H 2000 2550 50  0001 C CNN
F 3 "~" H 2000 2550 50  0001 C CNN
	1    2000 2550
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR01
U 1 1 5FE3D97F
P 1800 1650
F 0 "#PWR01" H 1800 1500 50  0001 C CNN
F 1 "VCC" V 1815 1777 50  0000 L CNN
F 2 "" H 1800 1650 50  0001 C CNN
F 3 "" H 1800 1650 50  0001 C CNN
	1    1800 1650
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR03
U 1 1 5FE3E59A
P 2300 1650
F 0 "#PWR03" H 2300 1400 50  0001 C CNN
F 1 "GND" V 2305 1522 50  0000 R CNN
F 2 "" H 2300 1650 50  0001 C CNN
F 3 "" H 2300 1650 50  0001 C CNN
	1    2300 1650
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR04
U 1 1 5FE3E980
P 2300 3550
F 0 "#PWR04" H 2300 3400 50  0001 C CNN
F 1 "VCC" V 2315 3678 50  0000 L CNN
F 2 "" H 2300 3550 50  0001 C CNN
F 3 "" H 2300 3550 50  0001 C CNN
	1    2300 3550
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR02
U 1 1 5FE3F7E0
P 1800 3550
F 0 "#PWR02" H 1800 3300 50  0001 C CNN
F 1 "GND" V 1805 3422 50  0000 R CNN
F 2 "" H 1800 3550 50  0001 C CNN
F 3 "" H 1800 3550 50  0001 C CNN
	1    1800 3550
	0    1    1    0   
$EndComp
NoConn ~ 1800 1750
Text Label 2300 1750 0    50   ~ 0
~rst
Text Label 1800 1850 2    50   ~ 0
~rdy
Text Label 2300 1850 0    50   ~ 0
ena
Text Label 1800 1950 2    50   ~ 0
~oe
Text Label 2300 1950 0    50   ~ 0
~we
NoConn ~ 1800 2050
NoConn ~ 2300 2050
NoConn ~ 1800 2550
NoConn ~ 1800 2650
NoConn ~ 2300 2650
NoConn ~ 2300 2550
Text Label 1800 2150 2    50   ~ 0
d0
Text Label 1800 2250 2    50   ~ 0
d2
Text Label 1800 2350 2    50   ~ 0
d4
Text Label 1800 2450 2    50   ~ 0
d6
Text Label 1800 2750 2    50   ~ 0
a0
Text Label 1800 2850 2    50   ~ 0
a2
Text Label 1800 2950 2    50   ~ 0
a4
Text Label 1800 3050 2    50   ~ 0
a6
Text Label 1800 3150 2    50   ~ 0
a8
Text Label 1800 3250 2    50   ~ 0
a10
Text Label 1800 3350 2    50   ~ 0
a12
Text Label 1800 3450 2    50   ~ 0
a14
Text Label 2300 2750 0    50   ~ 0
a1
Text Label 2300 2850 0    50   ~ 0
a3
Text Label 2300 2950 0    50   ~ 0
a5
Text Label 2300 3050 0    50   ~ 0
a7
Text Label 2300 3150 0    50   ~ 0
a9
Text Label 2300 3250 0    50   ~ 0
a11
Text Label 2300 3350 0    50   ~ 0
a13
Text Label 2300 3450 0    50   ~ 0
a15
Text Label 2300 2150 0    50   ~ 0
d1
Text Label 2300 2250 0    50   ~ 0
d3
Text Label 2300 2350 0    50   ~ 0
d5
Text Label 2300 2450 0    50   ~ 0
d7
$Comp
L Connector:SD_Card J2
U 1 1 5FE3BA45
P 17700 6350
F 0 "J2" H 17700 7015 50  0000 C CNN
F 1 "SD_Card" H 17700 6924 50  0000 C CNN
F 2 "" H 17700 6350 50  0001 C CNN
F 3 "http://portal.fciconnect.com/Comergent//fci/drawing/10067847.pdf" H 17700 6350 50  0001 C CNN
	1    17700 6350
	1    0    0    -1  
$EndComp
$Comp
L Connector:Mini-DIN-6 J3
U 1 1 5FE41893
P 7600 2250
F 0 "J3" H 7600 2617 50  0000 C CNN
F 1 "Mini-DIN-6" H 7600 2526 50  0000 C CNN
F 2 "" H 7600 2250 50  0001 C CNN
F 3 "http://service.powerdynamics.com/ec/Catalog17/Section%2011.pdf" H 7600 2250 50  0001 C CNN
	1    7600 2250
	0    1    1    0   
$EndComp
$Sheet
S 4550 5600 700  950 
U 5FE5ABE2
F0 "SPI" 50
F1 "SPI.sch" 50
F2 "clk" O R 5250 5750 50 
F3 "mosi" O R 5250 5850 50 
F4 "miso" I R 5250 5950 50 
F5 "d[0..7]" B L 4550 5750 50 
F6 "~oe" I L 4550 5900 50 
F7 "~we" I L 4550 6000 50 
F8 "~sel" I L 4550 6100 50 
$EndSheet
$Sheet
S 5600 2000 950  1400
U 5FE853A4
F0 "ps2" 50
F1 "ps2.sch" 50
F2 "ps2_clk" T R 6550 2850 50 
F3 "ps2_data" T R 6550 2700 50 
F4 "d[0..7]" B L 5600 2150 50 
F5 "~oe" I L 5600 2250 50 
F6 "~we" I L 5600 2350 50 
F7 "~sel" I L 5600 2450 50 
F8 "a" I L 5600 2550 50 
$EndSheet
Text GLabel 2950 1750 2    50   Output ~ 0
~rst
Wire Wire Line
	2950 1750 2300 1750
NoConn ~ 7500 1950
NoConn ~ 7700 1950
Wire Wire Line
	6550 2850 7700 2850
Wire Wire Line
	7700 2850 7700 2550
Wire Wire Line
	6550 2700 7500 2700
Wire Wire Line
	7500 2700 7500 2550
$Comp
L power:VCC #PWR0101
U 1 1 6003D229
P 7600 1950
F 0 "#PWR0101" H 7600 1800 50  0001 C CNN
F 1 "VCC" H 7615 2123 50  0000 C CNN
F 2 "" H 7600 1950 50  0001 C CNN
F 3 "" H 7600 1950 50  0001 C CNN
	1    7600 1950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 6003DAC3
P 7600 2550
F 0 "#PWR0102" H 7600 2300 50  0001 C CNN
F 1 "GND" H 7605 2377 50  0000 C CNN
F 2 "" H 7600 2550 50  0001 C CNN
F 3 "" H 7600 2550 50  0001 C CNN
	1    7600 2550
	1    0    0    -1  
$EndComp
Text Label 5600 2150 2    50   ~ 0
d[0..7]
Text Label 5600 2250 2    50   ~ 0
~oe
Text Label 5600 2350 2    50   ~ 0
~we
Text Label 5600 2550 2    50   ~ 0
a0
Entry Wire Line
	4100 2550 4200 2450
Entry Wire Line
	4100 2650 4200 2550
Entry Wire Line
	4100 2750 4200 2650
Entry Wire Line
	4100 2850 4200 2750
Entry Wire Line
	4100 2950 4200 2850
Entry Wire Line
	4100 3050 4200 2950
Entry Wire Line
	4100 3150 4200 3050
Entry Wire Line
	4100 3250 4200 3150
Text Label 3900 3250 2    50   ~ 0
d7
Text Label 3900 3150 2    50   ~ 0
d6
Text Label 3900 3050 2    50   ~ 0
d5
Text Label 3900 2950 2    50   ~ 0
d4
Text Label 3900 2850 2    50   ~ 0
d3
Text Label 3900 2750 2    50   ~ 0
d2
Text Label 3900 2650 2    50   ~ 0
d1
Text Label 3900 2550 2    50   ~ 0
d0
Wire Wire Line
	4100 2550 3900 2550
Wire Wire Line
	3900 2650 4100 2650
Wire Wire Line
	4100 2750 3900 2750
Wire Wire Line
	3900 2850 4100 2850
Wire Wire Line
	4100 2950 3900 2950
Wire Wire Line
	3900 3050 4100 3050
Wire Wire Line
	4100 3150 3900 3150
Wire Wire Line
	3900 3250 4100 3250
Wire Bus Line
	4200 2150 5600 2150
Text GLabel 1400 1850 0    50   3State ~ 0
~rdy
Wire Wire Line
	1400 1850 1800 1850
Text Label 4550 6000 2    50   ~ 0
~we
Text Label 4550 5900 2    50   ~ 0
~oe
Wire Bus Line
	4550 5750 4200 5750
Wire Bus Line
	4200 2150 4200 5750
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 5FF7DC16
P 1650 4600
F 0 "#FLG0101" H 1650 4675 50  0001 C CNN
F 1 "PWR_FLAG" H 1650 4773 50  0000 C CNN
F 2 "" H 1650 4600 50  0001 C CNN
F 3 "~" H 1650 4600 50  0001 C CNN
	1    1650 4600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0181
U 1 1 5FF7E163
P 1650 4600
F 0 "#PWR0181" H 1650 4350 50  0001 C CNN
F 1 "GND" V 1655 4472 50  0000 R CNN
F 2 "" H 1650 4600 50  0001 C CNN
F 3 "" H 1650 4600 50  0001 C CNN
	1    1650 4600
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG0102
U 1 1 5FF7E866
P 1950 4650
F 0 "#FLG0102" H 1950 4725 50  0001 C CNN
F 1 "PWR_FLAG" H 1950 4823 50  0000 C CNN
F 2 "" H 1950 4650 50  0001 C CNN
F 3 "~" H 1950 4650 50  0001 C CNN
	1    1950 4650
	-1   0    0    1   
$EndComp
$Comp
L power:VCC #PWR0182
U 1 1 5FF7EE14
P 1950 4650
F 0 "#PWR0182" H 1950 4500 50  0001 C CNN
F 1 "VCC" V 1965 4778 50  0000 L CNN
F 2 "" H 1950 4650 50  0001 C CNN
F 3 "" H 1950 4650 50  0001 C CNN
	1    1950 4650
	1    0    0    -1  
$EndComp
$EndSCHEMATC
