EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A2 23386 16535
encoding utf-8
Sheet 1 2
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
L Connector_Generic:Conn_02x20_Odd_Even J?
U 1 1 5FE386D6
P 2000 2550
F 0 "J?" H 2050 3667 50  0000 C CNN
F 1 "Conn_02x20_Odd_Even" H 2050 3576 50  0000 C CNN
F 2 "" H 2000 2550 50  0001 C CNN
F 3 "~" H 2000 2550 50  0001 C CNN
	1    2000 2550
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5FE3D97F
P 1800 1650
F 0 "#PWR?" H 1800 1500 50  0001 C CNN
F 1 "VCC" V 1815 1777 50  0000 L CNN
F 2 "" H 1800 1650 50  0001 C CNN
F 3 "" H 1800 1650 50  0001 C CNN
	1    1800 1650
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FE3E59A
P 2300 1650
F 0 "#PWR?" H 2300 1400 50  0001 C CNN
F 1 "GND" V 2305 1522 50  0000 R CNN
F 2 "" H 2300 1650 50  0001 C CNN
F 3 "" H 2300 1650 50  0001 C CNN
	1    2300 1650
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5FE3E980
P 2300 3550
F 0 "#PWR?" H 2300 3400 50  0001 C CNN
F 1 "VCC" V 2315 3678 50  0000 L CNN
F 2 "" H 2300 3550 50  0001 C CNN
F 3 "" H 2300 3550 50  0001 C CNN
	1    2300 3550
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FE3F7E0
P 1800 3550
F 0 "#PWR?" H 1800 3300 50  0001 C CNN
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
L Connector:SD_Card J?
U 1 1 5FE3BA45
P 17700 6350
F 0 "J?" H 17700 7015 50  0000 C CNN
F 1 "SD_Card" H 17700 6924 50  0000 C CNN
F 2 "" H 17700 6350 50  0001 C CNN
F 3 "http://portal.fciconnect.com/Comergent//fci/drawing/10067847.pdf" H 17700 6350 50  0001 C CNN
	1    17700 6350
	1    0    0    -1  
$EndComp
$Comp
L Connector:Mini-DIN-6 J?
U 1 1 5FE41893
P 17700 9650
F 0 "J?" H 17700 10017 50  0000 C CNN
F 1 "Mini-DIN-6" H 17700 9926 50  0000 C CNN
F 2 "" H 17700 9650 50  0001 C CNN
F 3 "http://service.powerdynamics.com/ec/Catalog17/Section%2011.pdf" H 17700 9650 50  0001 C CNN
	1    17700 9650
	1    0    0    -1  
$EndComp
$Sheet
S 4550 5600 1350 1200
U 5FE5ABE2
F0 "SPI" 50
F1 "SPI.sch" 50
$EndSheet
$EndSCHEMATC
