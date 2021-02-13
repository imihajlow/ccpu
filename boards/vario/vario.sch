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
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x20_P2.54mm_Horizontal" H 2000 2550 50  0001 C CNN
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
rdy
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
P 8050 6050
F 0 "J2" H 8050 6715 50  0000 C CNN
F 1 "SD_Card" H 8050 6624 50  0000 C CNN
F 2 "Connector_Card:SD_Kyocera_145638009211859+" H 8050 6050 50  0001 C CNN
F 3 "http://portal.fciconnect.com/Comergent//fci/drawing/10067847.pdf" H 8050 6050 50  0001 C CNN
	1    8050 6050
	1    0    0    -1  
$EndComp
$Comp
L Connector:Mini-DIN-6 J3
U 1 1 5FE41893
P 7600 2250
F 0 "J3" H 7600 2617 50  0000 C CNN
F 1 "Mini-DIN-6" H 7600 2526 50  0000 C CNN
F 2 "vario:Connector-MiniDIN-6" H 7600 2250 50  0001 C CNN
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
F3 "mosi" O R 5250 6250 50 
F4 "d[0..7]" B L 4550 5750 50 
F5 "~oe" I L 4550 5900 50 
F6 "~we" I L 4550 6000 50 
F7 "~sel" I L 4550 6100 50 
F8 "~miso" I R 5250 6450 50 
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
F7 "~data_sel" I L 5600 2650 50 
F8 "~status_sel" I L 5600 2750 50 
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
rdy
Wire Wire Line
	1400 1850 1800 1850
Text Label 4550 6000 2    50   ~ 0
~we
Text Label 4550 5900 2    50   ~ 0
~oe
Wire Bus Line
	4550 5750 4200 5750
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 5FF7DC16
P 1000 850
F 0 "#FLG0101" H 1000 925 50  0001 C CNN
F 1 "PWR_FLAG" H 1000 1023 50  0000 C CNN
F 2 "" H 1000 850 50  0001 C CNN
F 3 "~" H 1000 850 50  0001 C CNN
	1    1000 850 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0181
U 1 1 5FF7E163
P 1000 850
F 0 "#PWR0181" H 1000 600 50  0001 C CNN
F 1 "GND" V 1005 722 50  0000 R CNN
F 2 "" H 1000 850 50  0001 C CNN
F 3 "" H 1000 850 50  0001 C CNN
	1    1000 850 
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG0102
U 1 1 5FF7E866
P 1300 900
F 0 "#FLG0102" H 1300 975 50  0001 C CNN
F 1 "PWR_FLAG" H 1300 1073 50  0000 C CNN
F 2 "" H 1300 900 50  0001 C CNN
F 3 "~" H 1300 900 50  0001 C CNN
	1    1300 900 
	-1   0    0    1   
$EndComp
$Comp
L power:VCC #PWR0182
U 1 1 5FF7EE14
P 1300 900
F 0 "#PWR0182" H 1300 750 50  0001 C CNN
F 1 "VCC" V 1315 1028 50  0000 L CNN
F 2 "" H 1300 900 50  0001 C CNN
F 3 "" H 1300 900 50  0001 C CNN
	1    1300 900 
	1    0    0    -1  
$EndComp
$Comp
L Device:R R7
U 1 1 5FECCF7D
P 5850 5750
F 0 "R7" V 5643 5750 50  0000 C CNN
F 1 "10k" V 5734 5750 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 5780 5750 50  0001 C CNN
F 3 "~" H 5850 5750 50  0001 C CNN
	1    5850 5750
	0    1    1    0   
$EndComp
$Comp
L Device:R R10
U 1 1 5FECE484
P 6100 5900
F 0 "R10" H 6170 5946 50  0000 L CNN
F 1 "20k" H 6170 5855 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 6030 5900 50  0001 C CNN
F 3 "~" H 6100 5900 50  0001 C CNN
	1    6100 5900
	1    0    0    -1  
$EndComp
Wire Wire Line
	7150 6150 6450 6150
Wire Wire Line
	6450 6150 6450 5750
Wire Wire Line
	6450 5750 6100 5750
Connection ~ 6100 5750
Wire Wire Line
	6100 5750 6000 5750
Wire Wire Line
	5700 5750 5250 5750
$Comp
L power:GND #PWR0189
U 1 1 5FECFCB0
P 6100 6050
F 0 "#PWR0189" H 6100 5800 50  0001 C CNN
F 1 "GND" H 6100 5900 50  0000 C CNN
F 2 "" H 6100 6050 50  0001 C CNN
F 3 "" H 6100 6050 50  0001 C CNN
	1    6100 6050
	1    0    0    -1  
$EndComp
$Comp
L Device:R R6
U 1 1 5FED00E2
P 5650 6250
F 0 "R6" V 5443 6250 50  0000 C CNN
F 1 "10k" V 5534 6250 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 5580 6250 50  0001 C CNN
F 3 "~" H 5650 6250 50  0001 C CNN
	1    5650 6250
	0    1    1    0   
$EndComp
$Comp
L Device:R R8
U 1 1 5FED0724
P 5900 6400
F 0 "R8" H 5970 6446 50  0000 L CNN
F 1 "20k" H 5970 6355 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 5830 6400 50  0001 C CNN
F 3 "~" H 5900 6400 50  0001 C CNN
	1    5900 6400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0186
U 1 1 5FED0BC2
P 5900 6550
F 0 "#PWR0186" H 5900 6300 50  0001 C CNN
F 1 "GND" H 5905 6377 50  0000 C CNN
F 2 "" H 5900 6550 50  0001 C CNN
F 3 "" H 5900 6550 50  0001 C CNN
	1    5900 6550
	1    0    0    -1  
$EndComp
Wire Wire Line
	5500 6250 5250 6250
Wire Wire Line
	5800 6250 5900 6250
Wire Wire Line
	6750 6250 6750 5850
Wire Wire Line
	6750 5850 7150 5850
Connection ~ 5900 6250
Wire Wire Line
	5900 6250 6750 6250
$Comp
L power:GND #PWR0201
U 1 1 5FED1A42
P 8950 6300
F 0 "#PWR0201" H 8950 6050 50  0001 C CNN
F 1 "GND" H 8955 6127 50  0000 C CNN
F 2 "" H 8950 6300 50  0001 C CNN
F 3 "" H 8950 6300 50  0001 C CNN
	1    8950 6300
	1    0    0    -1  
$EndComp
Wire Wire Line
	8950 6150 8950 6250
Connection ~ 8950 6250
Wire Wire Line
	8950 6250 8950 6300
$Comp
L Device:R R9
U 1 1 5FEE1EBB
P 5900 7200
F 0 "R9" H 5970 7246 50  0000 L CNN
F 1 "10k" H 5970 7155 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 5830 7200 50  0001 C CNN
F 3 "~" H 5900 7200 50  0001 C CNN
	1    5900 7200
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0187
U 1 1 5FEE26EF
P 5900 7050
F 0 "#PWR0187" H 5900 6900 50  0001 C CNN
F 1 "VCC" H 5915 7223 50  0000 C CNN
F 2 "" H 5900 7050 50  0001 C CNN
F 3 "" H 5900 7050 50  0001 C CNN
	1    5900 7050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0188
U 1 1 5FEE4681
P 5900 7750
F 0 "#PWR0188" H 5900 7500 50  0001 C CNN
F 1 "GND" H 5905 7577 50  0000 C CNN
F 2 "" H 5900 7750 50  0001 C CNN
F 3 "" H 5900 7750 50  0001 C CNN
	1    5900 7750
	1    0    0    -1  
$EndComp
Wire Wire Line
	5900 7350 5500 7350
Wire Wire Line
	5500 7350 5500 6450
Wire Wire Line
	5500 6450 5250 6450
Text Label 5350 6450 0    50   ~ 0
~miso
$Comp
L Device:R R11
U 1 1 5FEE571F
P 6300 7400
F 0 "R11" H 6370 7446 50  0000 L CNN
F 1 "47k" H 6370 7355 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 6230 7400 50  0001 C CNN
F 3 "~" H 6300 7400 50  0001 C CNN
	1    6300 7400
	1    0    0    -1  
$EndComp
Wire Wire Line
	6200 7550 6300 7550
$Comp
L power:+3.3V #PWR0190
U 1 1 5FEE6B58
P 6300 7250
F 0 "#PWR0190" H 6300 7100 50  0001 C CNN
F 1 "+3.3V" H 6315 7423 50  0000 C CNN
F 2 "" H 6300 7250 50  0001 C CNN
F 3 "" H 6300 7250 50  0001 C CNN
	1    6300 7250
	1    0    0    -1  
$EndComp
Wire Wire Line
	7150 6350 6750 6350
Wire Wire Line
	6750 6350 6750 7550
Wire Wire Line
	6750 7550 6300 7550
Connection ~ 6300 7550
$Comp
L power:GND #PWR0195
U 1 1 5FEE92A3
P 7150 6250
F 0 "#PWR0195" H 7150 6000 50  0001 C CNN
F 1 "GND" V 7155 6122 50  0000 R CNN
F 2 "" H 7150 6250 50  0001 C CNN
F 3 "" H 7150 6250 50  0001 C CNN
	1    7150 6250
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0193
U 1 1 5FEE9AE1
P 7150 5950
F 0 "#PWR0193" H 7150 5700 50  0001 C CNN
F 1 "GND" V 7155 5822 50  0000 R CNN
F 2 "" H 7150 5950 50  0001 C CNN
F 3 "" H 7150 5950 50  0001 C CNN
	1    7150 5950
	0    1    1    0   
$EndComp
$Comp
L power:+3.3V #PWR0194
U 1 1 5FEEA07E
P 7150 6050
F 0 "#PWR0194" H 7150 5900 50  0001 C CNN
F 1 "+3.3V" V 7165 6178 50  0000 L CNN
F 2 "" H 7150 6050 50  0001 C CNN
F 3 "" H 7150 6050 50  0001 C CNN
	1    7150 6050
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R16
U 1 1 5FEEC40F
P 9150 5700
F 0 "R16" H 9220 5746 50  0000 L CNN
F 1 "47k" H 9220 5655 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 9080 5700 50  0001 C CNN
F 3 "~" H 9150 5700 50  0001 C CNN
	1    9150 5700
	1    0    0    -1  
$EndComp
$Comp
L Device:R R17
U 1 1 5FEECB23
P 9450 5600
F 0 "R17" H 9520 5646 50  0000 L CNN
F 1 "47k" H 9520 5555 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 9380 5600 50  0001 C CNN
F 3 "~" H 9450 5600 50  0001 C CNN
	1    9450 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	9750 5850 9150 5850
Connection ~ 9150 5850
Wire Wire Line
	9150 5850 8950 5850
Wire Wire Line
	8950 5950 9450 5950
Wire Wire Line
	9450 5750 9450 5950
Connection ~ 9450 5950
Wire Wire Line
	9450 5950 9750 5950
$Comp
L power:VCC #PWR0204
U 1 1 5FEEF21D
P 9450 5450
F 0 "#PWR0204" H 9450 5300 50  0001 C CNN
F 1 "VCC" H 9465 5623 50  0000 C CNN
F 2 "" H 9450 5450 50  0001 C CNN
F 3 "" H 9450 5450 50  0001 C CNN
	1    9450 5450
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0202
U 1 1 5FEEF967
P 9150 5550
F 0 "#PWR0202" H 9150 5400 50  0001 C CNN
F 1 "VCC" H 9165 5723 50  0000 C CNN
F 2 "" H 9150 5550 50  0001 C CNN
F 3 "" H 9150 5550 50  0001 C CNN
	1    9150 5550
	1    0    0    -1  
$EndComp
Text Label 9750 5850 0    50   ~ 0
~card_detect
Text Label 9750 5950 0    50   ~ 0
write_protect
$Comp
L Device:R R13
U 1 1 5FEF18B3
P 7000 5500
F 0 "R13" H 7070 5546 50  0000 L CNN
F 1 "47k" H 7070 5455 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 6930 5500 50  0001 C CNN
F 3 "~" H 7000 5500 50  0001 C CNN
	1    7000 5500
	1    0    0    -1  
$EndComp
Wire Wire Line
	7150 5650 7000 5650
$Comp
L power:+3.3V #PWR0192
U 1 1 5FEF351E
P 7000 5350
F 0 "#PWR0192" H 7000 5200 50  0001 C CNN
F 1 "+3.3V" H 7015 5523 50  0000 C CNN
F 2 "" H 7000 5350 50  0001 C CNN
F 3 "" H 7000 5350 50  0001 C CNN
	1    7000 5350
	1    0    0    -1  
$EndComp
$Comp
L Device:R R12
U 1 1 5FEF3A38
P 6650 5500
F 0 "R12" H 6720 5546 50  0000 L CNN
F 1 "47k" H 6720 5455 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 6580 5500 50  0001 C CNN
F 3 "~" H 6650 5500 50  0001 C CNN
	1    6650 5500
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR0191
U 1 1 5FEF3FFC
P 6650 5350
F 0 "#PWR0191" H 6650 5200 50  0001 C CNN
F 1 "+3.3V" H 6665 5523 50  0000 C CNN
F 2 "" H 6650 5350 50  0001 C CNN
F 3 "" H 6650 5350 50  0001 C CNN
	1    6650 5350
	1    0    0    -1  
$EndComp
Wire Wire Line
	7150 6450 6650 6450
Wire Wire Line
	6650 6450 6650 5650
Text Label 7150 5750 2    50   ~ 0
~card_cs_3v3
$Comp
L Device:C C37
U 1 1 5FEF86F8
P 7250 6950
F 0 "C37" H 7365 6996 50  0000 L CNN
F 1 "0.1" H 7365 6905 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 7288 6800 50  0001 C CNN
F 3 "~" H 7250 6950 50  0001 C CNN
	1    7250 6950
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR0196
U 1 1 5FEF95DD
P 7250 6800
F 0 "#PWR0196" H 7250 6650 50  0001 C CNN
F 1 "+3.3V" H 7265 6973 50  0000 C CNN
F 2 "" H 7250 6800 50  0001 C CNN
F 3 "" H 7250 6800 50  0001 C CNN
	1    7250 6800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0197
U 1 1 5FEF9C97
P 7250 7100
F 0 "#PWR0197" H 7250 6850 50  0001 C CNN
F 1 "GND" H 7255 6927 50  0000 C CNN
F 2 "" H 7250 7100 50  0001 C CNN
F 3 "" H 7250 7100 50  0001 C CNN
	1    7250 7100
	1    0    0    -1  
$EndComp
$Comp
L Device:C C38
U 1 1 5FEFAB70
P 7700 6950
F 0 "C38" H 7815 6996 50  0000 L CNN
F 1 "1.0" H 7815 6905 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 7738 6800 50  0001 C CNN
F 3 "~" H 7700 6950 50  0001 C CNN
	1    7700 6950
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR0199
U 1 1 5FEFAB76
P 7700 6800
F 0 "#PWR0199" H 7700 6650 50  0001 C CNN
F 1 "+3.3V" H 7715 6973 50  0000 C CNN
F 2 "" H 7700 6800 50  0001 C CNN
F 3 "" H 7700 6800 50  0001 C CNN
	1    7700 6800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0200
U 1 1 5FEFAB7C
P 7700 7100
F 0 "#PWR0200" H 7700 6850 50  0001 C CNN
F 1 "GND" H 7705 6927 50  0000 C CNN
F 2 "" H 7700 7100 50  0001 C CNN
F 3 "" H 7700 7100 50  0001 C CNN
	1    7700 7100
	1    0    0    -1  
$EndComp
$Comp
L missing:IFX54441EJV33 U36
U 1 1 5FF055DF
P 12700 1900
F 0 "U36" H 12700 2415 50  0000 C CNN
F 1 "IFX54441EJV33" H 12700 2324 50  0000 C CNN
F 2 "Package_SO:Infineon_PG-DSO-8-27_3.9x4.9mm_EP2.65x3mm" H 12600 1800 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/196/Infineon-IFX54441-DS-v01_01-EN-1226726.pdf" H 12600 1800 50  0001 C CNN
	1    12700 1900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0209
U 1 1 5FF06C7D
P 12700 2350
F 0 "#PWR0209" H 12700 2100 50  0001 C CNN
F 1 "GND" H 12705 2177 50  0000 C CNN
F 2 "" H 12700 2350 50  0001 C CNN
F 3 "" H 12700 2350 50  0001 C CNN
	1    12700 2350
	1    0    0    -1  
$EndComp
Wire Wire Line
	12650 2350 12700 2350
Connection ~ 12700 2350
Wire Wire Line
	12700 2350 12750 2350
$Comp
L power:VCC #PWR0207
U 1 1 5FF082ED
P 11700 1650
F 0 "#PWR0207" H 11700 1500 50  0001 C CNN
F 1 "VCC" H 11715 1823 50  0000 C CNN
F 2 "" H 11700 1650 50  0001 C CNN
F 3 "" H 11700 1650 50  0001 C CNN
	1    11700 1650
	1    0    0    -1  
$EndComp
$Comp
L Device:C C39
U 1 1 5FF0975A
P 11700 1800
F 0 "C39" H 11815 1846 50  0000 L CNN
F 1 "1.0" H 11815 1755 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 11738 1650 50  0001 C CNN
F 3 "~" H 11700 1800 50  0001 C CNN
	1    11700 1800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0208
U 1 1 5FF0A86C
P 11700 1950
F 0 "#PWR0208" H 11700 1700 50  0001 C CNN
F 1 "GND" H 11705 1777 50  0000 C CNN
F 2 "" H 11700 1950 50  0001 C CNN
F 3 "" H 11700 1950 50  0001 C CNN
	1    11700 1950
	1    0    0    -1  
$EndComp
$Comp
L Device:C C40
U 1 1 5FF0B4FC
P 13400 1800
F 0 "C40" H 13515 1846 50  0000 L CNN
F 1 "10n" H 13515 1755 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 13438 1650 50  0001 C CNN
F 3 "~" H 13400 1800 50  0001 C CNN
	1    13400 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	13050 1950 13400 1950
Wire Wire Line
	13400 1650 13150 1650
Wire Wire Line
	13050 1800 13150 1800
Wire Wire Line
	13150 1800 13150 1650
Connection ~ 13150 1650
Wire Wire Line
	13150 1650 13050 1650
$Comp
L Device:CP C46
U 1 1 5FF0EBC2
P 13800 1800
F 0 "C46" H 13918 1846 50  0000 L CNN
F 1 "33.0x10v" H 13918 1755 50  0000 L CNN
F 2 "Capacitor_Tantalum_SMD:CP_EIA-3528-21_Kemet-B_Pad1.50x2.35mm_HandSolder" H 13838 1650 50  0001 C CNN
F 3 "~" H 13800 1800 50  0001 C CNN
	1    13800 1800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0211
U 1 1 5FF0F4B9
P 13800 1950
F 0 "#PWR0211" H 13800 1700 50  0001 C CNN
F 1 "GND" H 13805 1777 50  0000 C CNN
F 2 "" H 13800 1950 50  0001 C CNN
F 3 "" H 13800 1950 50  0001 C CNN
	1    13800 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	13400 1650 13800 1650
Connection ~ 13400 1650
$Comp
L power:+3.3V #PWR0210
U 1 1 5FF10860
P 13800 1650
F 0 "#PWR0210" H 13800 1500 50  0001 C CNN
F 1 "+3.3V" H 13815 1823 50  0000 C CNN
F 2 "" H 13800 1650 50  0001 C CNN
F 3 "" H 13800 1650 50  0001 C CNN
	1    13800 1650
	1    0    0    -1  
$EndComp
Connection ~ 13800 1650
Text Label 12350 1900 2    50   ~ 0
en_3v3
Wire Wire Line
	11700 1650 12350 1650
Connection ~ 11700 1650
$Comp
L Device:R R14
U 1 1 5FF1D01C
P 7150 9250
F 0 "R14" V 6943 9250 50  0000 C CNN
F 1 "10k" V 7034 9250 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 7080 9250 50  0001 C CNN
F 3 "~" H 7150 9250 50  0001 C CNN
	1    7150 9250
	0    1    1    0   
$EndComp
$Comp
L Device:R R15
U 1 1 5FF1D71B
P 7400 9400
F 0 "R15" H 7470 9446 50  0000 L CNN
F 1 "20k" H 7470 9355 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 7330 9400 50  0001 C CNN
F 3 "~" H 7400 9400 50  0001 C CNN
	1    7400 9400
	1    0    0    -1  
$EndComp
Text Label 7750 9250 0    50   ~ 0
~card_cs_3v3
Wire Wire Line
	7750 9250 7400 9250
Connection ~ 7400 9250
Wire Wire Line
	7400 9250 7300 9250
Wire Wire Line
	7000 9250 6100 9250
$Comp
L power:GND #PWR0198
U 1 1 5FF20273
P 7400 9550
F 0 "#PWR0198" H 7400 9300 50  0001 C CNN
F 1 "GND" H 7405 9377 50  0000 C CNN
F 2 "" H 7400 9550 50  0001 C CNN
F 3 "" H 7400 9550 50  0001 C CNN
	1    7400 9550
	1    0    0    -1  
$EndComp
Text Label 5100 9350 2    50   ~ 0
d3
Text Label 5100 9250 2    50   ~ 0
d2
Text Label 5100 10250 2    50   ~ 0
~rst
Text Label 6100 9350 0    50   ~ 0
en_3v3
NoConn ~ 6100 9450
NoConn ~ 6100 9550
NoConn ~ 6100 9650
NoConn ~ 6100 9750
NoConn ~ 6100 9850
NoConn ~ 6100 9950
$Comp
L power:GND #PWR0185
U 1 1 5FF2E206
P 5600 10550
F 0 "#PWR0185" H 5600 10300 50  0001 C CNN
F 1 "GND" H 5605 10377 50  0000 C CNN
F 2 "" H 5600 10550 50  0001 C CNN
F 3 "" H 5600 10550 50  0001 C CNN
	1    5600 10550
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0184
U 1 1 5FF2E9EF
P 5600 8950
F 0 "#PWR0184" H 5600 8800 50  0001 C CNN
F 1 "VCC" H 5615 9123 50  0000 C CNN
F 2 "" H 5600 8950 50  0001 C CNN
F 3 "" H 5600 8950 50  0001 C CNN
	1    5600 8950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0206
U 1 1 5FF355A2
P 9750 10550
F 0 "#PWR0206" H 9750 10300 50  0001 C CNN
F 1 "GND" H 9755 10377 50  0000 C CNN
F 2 "" H 9750 10550 50  0001 C CNN
F 3 "" H 9750 10550 50  0001 C CNN
	1    9750 10550
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC244 U35
U 1 1 5FF36646
P 9750 9750
F 0 "U35" H 10250 9100 50  0000 C CNN
F 1 "MC74HC244ADT" H 10200 9000 50  0000 C CNN
F 2 "Package_SO:TSSOP-20_4.4x6.5mm_P0.65mm" H 9750 9750 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/1878565.pdf" H 9750 9750 50  0001 C CNN
	1    9750 9750
	1    0    0    -1  
$EndComp
Text Label 10250 9350 0    50   ~ 0
d1
Text Label 10250 9250 0    50   ~ 0
d0
Text Label 9250 9250 2    50   ~ 0
~card_detect
Text Label 9250 9350 2    50   ~ 0
write_protect
$Comp
L power:VCC #PWR0205
U 1 1 5FF3C714
P 9750 8950
F 0 "#PWR0205" H 9750 8800 50  0001 C CNN
F 1 "VCC" H 9765 9123 50  0000 C CNN
F 2 "" H 9750 8950 50  0001 C CNN
F 3 "" H 9750 8950 50  0001 C CNN
	1    9750 8950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0183
U 1 1 5FF3F222
P 5100 9950
F 0 "#PWR0183" H 5100 9700 50  0001 C CNN
F 1 "GND" V 5105 9822 50  0000 R CNN
F 2 "" H 5100 9950 50  0001 C CNN
F 3 "" H 5100 9950 50  0001 C CNN
	1    5100 9950
	0    1    1    0   
$EndComp
NoConn ~ 10250 9450
NoConn ~ 10250 9550
NoConn ~ 10250 9650
NoConn ~ 10250 9750
NoConn ~ 10250 9850
NoConn ~ 10250 9950
$Comp
L power:GND #PWR0203
U 1 1 5FF481B4
P 9250 9950
F 0 "#PWR0203" H 9250 9700 50  0001 C CNN
F 1 "GND" V 9255 9822 50  0000 R CNN
F 2 "" H 9250 9950 50  0001 C CNN
F 3 "" H 9250 9950 50  0001 C CNN
	1    9250 9950
	0    1    1    0   
$EndComp
Wire Wire Line
	9250 9950 9250 9850
Connection ~ 9250 9950
Connection ~ 9250 9550
Wire Wire Line
	9250 9550 9250 9450
Connection ~ 9250 9650
Wire Wire Line
	9250 9650 9250 9550
Connection ~ 9250 9750
Wire Wire Line
	9250 9750 9250 9650
Connection ~ 9250 9850
Wire Wire Line
	9250 9850 9250 9750
$Comp
L Device:C C42
U 1 1 5FF4FE49
P 6500 10500
F 0 "C42" H 6615 10546 50  0000 L CNN
F 1 "0.1" H 6615 10455 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 6538 10350 50  0001 C CNN
F 3 "~" H 6500 10500 50  0001 C CNN
	1    6500 10500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0213
U 1 1 5FF502C2
P 6500 10650
F 0 "#PWR0213" H 6500 10400 50  0001 C CNN
F 1 "GND" H 6505 10477 50  0000 C CNN
F 2 "" H 6500 10650 50  0001 C CNN
F 3 "" H 6500 10650 50  0001 C CNN
	1    6500 10650
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0212
U 1 1 5FF506C1
P 6500 10350
F 0 "#PWR0212" H 6500 10200 50  0001 C CNN
F 1 "VCC" H 6515 10523 50  0000 C CNN
F 2 "" H 6500 10350 50  0001 C CNN
F 3 "" H 6500 10350 50  0001 C CNN
	1    6500 10350
	1    0    0    -1  
$EndComp
$Comp
L Device:C C43
U 1 1 5FF51719
P 10700 10500
F 0 "C43" H 10815 10546 50  0000 L CNN
F 1 "0.1" H 10815 10455 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 10738 10350 50  0001 C CNN
F 3 "~" H 10700 10500 50  0001 C CNN
	1    10700 10500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0215
U 1 1 5FF5171F
P 10700 10650
F 0 "#PWR0215" H 10700 10400 50  0001 C CNN
F 1 "GND" H 10705 10477 50  0000 C CNN
F 2 "" H 10700 10650 50  0001 C CNN
F 3 "" H 10700 10650 50  0001 C CNN
	1    10700 10650
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0214
U 1 1 5FF51725
P 10700 10350
F 0 "#PWR0214" H 10700 10200 50  0001 C CNN
F 1 "VCC" H 10715 10523 50  0000 C CNN
F 2 "" H 10700 10350 50  0001 C CNN
F 3 "" H 10700 10350 50  0001 C CNN
	1    10700 10350
	1    0    0    -1  
$EndComp
Text Label 5100 10150 2    50   ~ 0
card_ctl_clk
Wire Wire Line
	5100 9550 5100 9450
Connection ~ 5100 9550
Connection ~ 5100 9950
Wire Wire Line
	5100 9950 5100 9850
Connection ~ 5100 9850
Wire Wire Line
	5100 9850 5100 9750
Connection ~ 5100 9750
Wire Wire Line
	5100 9650 5100 9750
Wire Wire Line
	5100 9650 5100 9550
Connection ~ 5100 9650
$Comp
L 74xx:74LS273 U34
U 1 1 5FF1ADB4
P 5600 9750
F 0 "U34" H 6000 9100 50  0000 C CNN
F 1 "74HC273PW" H 6000 8950 50  0000 C CNN
F 2 "Package_SO:TSSOP-20_4.4x6.5mm_P0.65mm" H 5600 9750 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/1878567.pdf" H 5600 9750 50  0001 C CNN
	1    5600 9750
	1    0    0    -1  
$EndComp
Text Label 9250 10150 2    50   ~ 0
~card_status_oe
Wire Wire Line
	9250 10150 9250 10250
$Comp
L Device:Q_NMOS_GSD Q1
U 1 1 6021BDC6
P 6000 7550
F 0 "Q1" H 6205 7596 50  0000 L CNN
F 1 "2N7002" H 6205 7505 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 6200 7650 50  0001 C CNN
F 3 "~" H 6000 7550 50  0001 C CNN
	1    6000 7550
	-1   0    0    -1  
$EndComp
Connection ~ 5900 7350
$Comp
L 74xx:74LS30 U27
U 1 1 6022739C
P 1250 7600
F 0 "U27" H 1250 8125 50  0000 C CNN
F 1 "74HC30D" H 1250 8034 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 1250 7600 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT30.pdf" H 1250 7600 50  0001 C CNN
	1    1250 7600
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS30 U27
U 2 1 602286DA
P 2650 13600
F 0 "U27" H 2880 13646 50  0000 L CNN
F 1 "74HC30D" H 2880 13555 50  0000 L CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 2650 13600 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT30.pdf" H 2650 13600 50  0001 C CNN
	2    2650 13600
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS139 U37
U 1 1 602FAA53
P 3550 7200
F 0 "U37" H 3550 7567 50  0000 C CNN
F 1 "SN74HC139PW" H 3550 7476 50  0000 C CNN
F 2 "Package_SO:TSSOP-16_4.4x5mm_P0.65mm" H 3550 7200 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn54hc139-sp.pdf" H 3550 7200 50  0001 C CNN
	1    3550 7200
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS139 U37
U 2 1 602FCA57
P 2200 7400
F 0 "U37" H 2200 7767 50  0000 C CNN
F 1 "SN74HC139PW" H 2200 7676 50  0000 C CNN
F 2 "Package_SO:TSSOP-16_4.4x5mm_P0.65mm" H 2200 7400 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn54hc139-sp.pdf" H 2200 7400 50  0001 C CNN
	2    2200 7400
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS139 U37
U 3 1 602FD784
P 3650 13600
F 0 "U37" H 3880 13646 50  0000 L CNN
F 1 "SN74HC139PW" H 3880 13555 50  0000 L CNN
F 2 "Package_SO:TSSOP-16_4.4x5mm_P0.65mm" H 3650 13600 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn54hc139-sp.pdf" H 3650 13600 50  0001 C CNN
	3    3650 13600
	1    0    0    -1  
$EndComp
Text Label 4050 7100 0    50   ~ 0
~ps2_data_sel
Text Label 4050 7200 0    50   ~ 0
~ps2_status_sel
Text Label 4050 7300 0    50   ~ 0
~spi_data_sel
Text Label 4050 7400 0    50   ~ 0
~spi_ctrl_sel
Text Label 5600 2650 2    50   ~ 0
~ps2_data_sel
Text Label 5600 2750 2    50   ~ 0
~ps2_status_sel
Text Label 4550 6100 2    50   ~ 0
~spi_data_sel
Text Label 3050 7200 2    50   ~ 0
a0
Text Label 3050 7100 2    50   ~ 0
a1
Text Label 1700 7400 2    50   ~ 0
a8
Text Label 1700 7300 2    50   ~ 0
a9
Text Label 950  7300 2    50   ~ 0
a10
Text Label 950  7400 2    50   ~ 0
a11
Text Label 950  7500 2    50   ~ 0
a12
Text Label 950  7600 2    50   ~ 0
a13
Text Label 950  7700 2    50   ~ 0
a14
Text Label 950  7800 2    50   ~ 0
a15
Wire Wire Line
	1700 7600 1550 7600
$Comp
L power:VCC #PWR072
U 1 1 6031DFFE
P 950 8000
F 0 "#PWR072" H 950 7850 50  0001 C CNN
F 1 "VCC" V 965 8128 50  0000 L CNN
F 2 "" H 950 8000 50  0001 C CNN
F 3 "" H 950 8000 50  0001 C CNN
	1    950  8000
	0    -1   -1   0   
$EndComp
NoConn ~ 2700 7300
NoConn ~ 2700 7500
NoConn ~ 2700 7600
Wire Wire Line
	8900 10850 9250 10850
Wire Wire Line
	9250 10850 9250 10250
Connection ~ 9250 10250
Text Label 8300 10950 2    50   ~ 0
~spi_ctrl_sel
Wire Wire Line
	4550 10150 5100 10150
Text Label 3950 10250 2    50   ~ 0
~spi_ctrl_sel
Text Label 3950 10050 2    50   ~ 0
~we
Text Label 8300 10750 2    50   ~ 0
~oe
$Comp
L Device:C C25
U 1 1 6034577B
P 2600 15200
F 0 "C25" H 2715 15246 50  0000 L CNN
F 1 "0.1" H 2715 15155 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 2638 15050 50  0001 C CNN
F 3 "~" H 2600 15200 50  0001 C CNN
	1    2600 15200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0147
U 1 1 60345781
P 2600 15350
F 0 "#PWR0147" H 2600 15100 50  0001 C CNN
F 1 "GND" H 2605 15177 50  0000 C CNN
F 2 "" H 2600 15350 50  0001 C CNN
F 3 "" H 2600 15350 50  0001 C CNN
	1    2600 15350
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0146
U 1 1 60345787
P 2600 15050
F 0 "#PWR0146" H 2600 14900 50  0001 C CNN
F 1 "VCC" H 2615 15223 50  0000 C CNN
F 2 "" H 2600 15050 50  0001 C CNN
F 3 "" H 2600 15050 50  0001 C CNN
	1    2600 15050
	1    0    0    -1  
$EndComp
$Comp
L Device:C C44
U 1 1 60347585
P 3600 15150
F 0 "C44" H 3715 15196 50  0000 L CNN
F 1 "0.1" H 3715 15105 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 3638 15000 50  0001 C CNN
F 3 "~" H 3600 15150 50  0001 C CNN
	1    3600 15150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0180
U 1 1 6034758B
P 3600 15300
F 0 "#PWR0180" H 3600 15050 50  0001 C CNN
F 1 "GND" H 3605 15127 50  0000 C CNN
F 2 "" H 3600 15300 50  0001 C CNN
F 3 "" H 3600 15300 50  0001 C CNN
	1    3600 15300
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0165
U 1 1 60347591
P 3600 15000
F 0 "#PWR0165" H 3600 14850 50  0001 C CNN
F 1 "VCC" H 3615 15173 50  0000 C CNN
F 2 "" H 3600 15000 50  0001 C CNN
F 3 "" H 3600 15000 50  0001 C CNN
	1    3600 15000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C45
U 1 1 60349401
P 4450 15200
F 0 "C45" H 4565 15246 50  0000 L CNN
F 1 "0.1" H 4565 15155 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 4488 15050 50  0001 C CNN
F 3 "~" H 4450 15200 50  0001 C CNN
	1    4450 15200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0219
U 1 1 60349407
P 4450 15350
F 0 "#PWR0219" H 4450 15100 50  0001 C CNN
F 1 "GND" H 4455 15177 50  0000 C CNN
F 2 "" H 4450 15350 50  0001 C CNN
F 3 "" H 4450 15350 50  0001 C CNN
	1    4450 15350
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0218
U 1 1 6034940D
P 4450 15050
F 0 "#PWR0218" H 4450 14900 50  0001 C CNN
F 1 "VCC" H 4465 15223 50  0000 C CNN
F 2 "" H 4450 15050 50  0001 C CNN
F 3 "" H 4450 15050 50  0001 C CNN
	1    4450 15050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0149
U 1 1 6034AA58
P 2650 14100
F 0 "#PWR0149" H 2650 13850 50  0001 C CNN
F 1 "GND" H 2655 13927 50  0000 C CNN
F 2 "" H 2650 14100 50  0001 C CNN
F 3 "" H 2650 14100 50  0001 C CNN
	1    2650 14100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0217
U 1 1 6034B314
P 3650 14100
F 0 "#PWR0217" H 3650 13850 50  0001 C CNN
F 1 "GND" H 3655 13927 50  0000 C CNN
F 2 "" H 3650 14100 50  0001 C CNN
F 3 "" H 3650 14100 50  0001 C CNN
	1    3650 14100
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0148
U 1 1 6034B7EC
P 2650 13100
F 0 "#PWR0148" H 2650 12950 50  0001 C CNN
F 1 "VCC" H 2665 13273 50  0000 C CNN
F 2 "" H 2650 13100 50  0001 C CNN
F 3 "" H 2650 13100 50  0001 C CNN
	1    2650 13100
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0216
U 1 1 6034BF31
P 3650 13100
F 0 "#PWR0216" H 3650 12950 50  0001 C CNN
F 1 "VCC" H 3665 13273 50  0000 C CNN
F 2 "" H 3650 13100 50  0001 C CNN
F 3 "" H 3650 13100 50  0001 C CNN
	1    3650 13100
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U38
U 1 1 6034E6D8
P 4250 10150
F 0 "U38" H 4250 10475 50  0000 C CNN
F 1 "SN74HC32PWR" H 4250 10384 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 4250 10150 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/1648978.pdf" H 4250 10150 50  0001 C CNN
	1    4250 10150
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U38
U 2 1 603503BA
P 8600 10850
F 0 "U38" H 8600 11175 50  0000 C CNN
F 1 "SN74HC32PWR" H 8600 11084 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 8600 10850 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/1648978.pdf" H 8600 10850 50  0001 C CNN
	2    8600 10850
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U38
U 3 1 6035209C
P 11700 12600
F 0 "U38" H 11700 12925 50  0000 C CNN
F 1 "SN74HC32PWR" H 11700 12834 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 11700 12600 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/1648978.pdf" H 11700 12600 50  0001 C CNN
	3    11700 12600
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U38
U 4 1 6035479B
P 11100 12600
F 0 "U38" H 11100 12925 50  0000 C CNN
F 1 "SN74HC32PWR" H 11100 12834 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 11100 12600 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/1648978.pdf" H 11100 12600 50  0001 C CNN
	4    11100 12600
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U38
U 5 1 60357EA2
P 4850 13600
F 0 "U38" H 5080 13646 50  0000 L CNN
F 1 "SN74HC32PWR" H 5080 13555 50  0000 L CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 4850 13600 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/1648978.pdf" H 4850 13600 50  0001 C CNN
	5    4850 13600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0221
U 1 1 6035EB9D
P 4850 14100
F 0 "#PWR0221" H 4850 13850 50  0001 C CNN
F 1 "GND" H 4855 13927 50  0000 C CNN
F 2 "" H 4850 14100 50  0001 C CNN
F 3 "" H 4850 14100 50  0001 C CNN
	1    4850 14100
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0220
U 1 1 6035F03D
P 4850 13100
F 0 "#PWR0220" H 4850 12950 50  0001 C CNN
F 1 "VCC" H 4865 13273 50  0000 C CNN
F 2 "" H 4850 13100 50  0001 C CNN
F 3 "" H 4850 13100 50  0001 C CNN
	1    4850 13100
	1    0    0    -1  
$EndComp
Wire Wire Line
	11400 12500 11400 12600
Connection ~ 11400 12600
Wire Wire Line
	11400 12600 11400 12700
NoConn ~ 12000 12600
$Comp
L power:VCC #PWR0222
U 1 1 6036380A
P 10800 12600
F 0 "#PWR0222" H 10800 12450 50  0001 C CNN
F 1 "VCC" H 10815 12773 50  0000 C CNN
F 2 "" H 10800 12600 50  0001 C CNN
F 3 "" H 10800 12600 50  0001 C CNN
	1    10800 12600
	0    -1   -1   0   
$EndComp
Wire Wire Line
	10800 12500 10800 12600
Connection ~ 10800 12600
Wire Wire Line
	10800 12600 10800 12700
Text Label 6250 9250 0    50   ~ 0
~card_cs
Wire Wire Line
	3050 7400 2950 7400
NoConn ~ 2300 3050
NoConn ~ 1800 3050
NoConn ~ 1800 2950
NoConn ~ 2300 2950
NoConn ~ 2300 2850
NoConn ~ 1800 2850
Text Label 950  7900 2    50   ~ 0
ena
$Comp
L Mechanical:MountingHole H1
U 1 1 60387703
P 19400 600
F 0 "H1" H 19500 646 50  0000 L CNN
F 1 "MountingHole" H 19500 555 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 19400 600 50  0001 C CNN
F 3 "~" H 19400 600 50  0001 C CNN
	1    19400 600 
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H2
U 1 1 60387DC7
P 19400 850
F 0 "H2" H 19500 896 50  0000 L CNN
F 1 "MountingHole" H 19500 805 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 19400 850 50  0001 C CNN
F 3 "~" H 19400 850 50  0001 C CNN
	1    19400 850 
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H3
U 1 1 60387F65
P 19400 1150
F 0 "H3" H 19500 1196 50  0000 L CNN
F 1 "MountingHole" H 19500 1105 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 19400 1150 50  0001 C CNN
F 3 "~" H 19400 1150 50  0001 C CNN
	1    19400 1150
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H4
U 1 1 60388301
P 19400 1400
F 0 "H4" H 19500 1446 50  0000 L CNN
F 1 "MountingHole" H 19500 1355 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 19400 1400 50  0001 C CNN
F 3 "~" H 19400 1400 50  0001 C CNN
	1    19400 1400
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D1
U 1 1 6038A92B
P 12350 2950
F 0 "D1" H 12343 2695 50  0000 C CNN
F 1 "LED" H 12343 2786 50  0000 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 12350 2950 50  0001 C CNN
F 3 "~" H 12350 2950 50  0001 C CNN
	1    12350 2950
	-1   0    0    1   
$EndComp
Text Label 12200 2950 2    50   ~ 0
en_3v3
$Comp
L Device:R R18
U 1 1 6038DD0A
P 12650 2950
F 0 "R18" V 12443 2950 50  0000 C CNN
F 1 "620" V 12534 2950 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 12580 2950 50  0001 C CNN
F 3 "~" H 12650 2950 50  0001 C CNN
	1    12650 2950
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0223
U 1 1 6038E61B
P 12800 2950
F 0 "#PWR0223" H 12800 2700 50  0001 C CNN
F 1 "GND" H 12805 2777 50  0000 C CNN
F 2 "" H 12800 2950 50  0001 C CNN
F 3 "" H 12800 2950 50  0001 C CNN
	1    12800 2950
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D4
U 1 1 603BA214
P 3350 8000
F 0 "D4" H 3343 8217 50  0000 C CNN
F 1 "LED" H 3343 8126 50  0000 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 3350 8000 50  0001 C CNN
F 3 "~" H 3350 8000 50  0001 C CNN
	1    3350 8000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R21
U 1 1 603BA21A
P 3650 8000
F 0 "R21" V 3443 8000 50  0000 C CNN
F 1 "620" V 3534 8000 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 3580 8000 50  0001 C CNN
F 3 "~" H 3650 8000 50  0001 C CNN
	1    3650 8000
	0    1    1    0   
$EndComp
Wire Wire Line
	3200 8000 2950 8000
Wire Wire Line
	2950 8000 2950 7400
Connection ~ 2950 7400
Wire Wire Line
	2950 7400 2700 7400
$Comp
L power:VCC #PWR0228
U 1 1 603C0A6B
P 3800 8000
F 0 "#PWR0228" H 3800 7850 50  0001 C CNN
F 1 "VCC" H 3815 8173 50  0000 C CNN
F 2 "" H 3800 8000 50  0001 C CNN
F 3 "" H 3800 8000 50  0001 C CNN
	1    3800 8000
	0    1    1    0   
$EndComp
$Comp
L Device:CP C41
U 1 1 60223FDB
P 750 1850
F 0 "C41" H 868 1896 50  0000 L CNN
F 1 "33.0x10v" H 868 1805 50  0000 L CNN
F 2 "Capacitor_Tantalum_SMD:CP_EIA-3528-21_Kemet-B_Pad1.50x2.35mm_HandSolder" H 788 1700 50  0001 C CNN
F 3 "~" H 750 1850 50  0001 C CNN
	1    750  1850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0230
U 1 1 60223FE1
P 750 2000
F 0 "#PWR0230" H 750 1750 50  0001 C CNN
F 1 "GND" H 755 1827 50  0000 C CNN
F 2 "" H 750 2000 50  0001 C CNN
F 3 "" H 750 2000 50  0001 C CNN
	1    750  2000
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0229
U 1 1 602257F4
P 750 1700
F 0 "#PWR0229" H 750 1550 50  0001 C CNN
F 1 "VCC" V 765 1828 50  0000 L CNN
F 2 "" H 750 1700 50  0001 C CNN
F 3 "" H 750 1700 50  0001 C CNN
	1    750  1700
	1    0    0    -1  
$EndComp
Wire Bus Line
	4200 2150 4200 5750
$EndSCHEMATC
