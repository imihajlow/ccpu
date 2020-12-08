EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A1 23386 33110 portrait
encoding utf-8
Sheet 1 1
Title "VGA controller"
Date "2020-12-07"
Rev "1"
Comp ""
Comment1 "Licensed under the TAPR OHL (www.tapr.org/OHL)"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Mechanical:MountingHole H?
U 1 1 5FCF0826
P 700 650
F 0 "H?" H 800 696 50  0000 L CNN
F 1 "MountingHole" H 800 605 50  0000 L CNN
F 2 "" H 700 650 50  0001 C CNN
F 3 "~" H 700 650 50  0001 C CNN
	1    700  650 
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H?
U 1 1 5FCF0ADA
P 22300 700
F 0 "H?" H 22400 746 50  0000 L CNN
F 1 "MountingHole" H 22400 655 50  0000 L CNN
F 2 "" H 22300 700 50  0001 C CNN
F 3 "~" H 22300 700 50  0001 C CNN
	1    22300 700 
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H?
U 1 1 5FCF11E5
P 800 31300
F 0 "H?" H 900 31346 50  0000 L CNN
F 1 "MountingHole" H 900 31255 50  0000 L CNN
F 2 "" H 800 31300 50  0001 C CNN
F 3 "~" H 800 31300 50  0001 C CNN
	1    800  31300
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H?
U 1 1 5FCF189A
P 22150 31000
F 0 "H?" H 22250 31046 50  0000 L CNN
F 1 "MountingHole" H 22250 30955 50  0000 L CNN
F 2 "" H 22150 31000 50  0001 C CNN
F 3 "~" H 22150 31000 50  0001 C CNN
	1    22150 31000
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x20_Odd_Even J?
U 1 1 5FD0EDE0
P 1750 6050
F 0 "J?" H 1800 7167 50  0000 C CNN
F 1 "Conn_02x20_Odd_Even" H 1800 7076 50  0000 C CNN
F 2 "" H 1750 6050 50  0001 C CNN
F 3 "~" H 1750 6050 50  0001 C CNN
	1    1750 6050
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5FD14F11
P 1550 5150
F 0 "#PWR?" H 1550 5000 50  0001 C CNN
F 1 "VCC" V 1565 5277 50  0000 L CNN
F 2 "" H 1550 5150 50  0001 C CNN
F 3 "" H 1550 5150 50  0001 C CNN
	1    1550 5150
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5FD157A1
P 2050 7050
F 0 "#PWR?" H 2050 6900 50  0001 C CNN
F 1 "VCC" V 2065 7178 50  0000 L CNN
F 2 "" H 2050 7050 50  0001 C CNN
F 3 "" H 2050 7050 50  0001 C CNN
	1    2050 7050
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FD16672
P 1550 7050
F 0 "#PWR?" H 1550 6800 50  0001 C CNN
F 1 "GND" V 1555 6922 50  0000 R CNN
F 2 "" H 1550 7050 50  0001 C CNN
F 3 "" H 1550 7050 50  0001 C CNN
	1    1550 7050
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FD16BED
P 2050 5150
F 0 "#PWR?" H 2050 4900 50  0001 C CNN
F 1 "GND" V 2055 5022 50  0000 R CNN
F 2 "" H 2050 5150 50  0001 C CNN
F 3 "" H 2050 5150 50  0001 C CNN
	1    2050 5150
	0    -1   -1   0   
$EndComp
Text Label 2050 5250 0    50   ~ 0
~rst
Text Label 2050 5350 0    50   ~ 0
ena
Text Label 2050 5450 0    50   ~ 0
~we
Text Label 2050 5650 0    50   ~ 0
d1
Text Label 2050 5750 0    50   ~ 0
d3
Text Label 1550 5850 2    50   ~ 0
d4
Text Label 2050 5850 0    50   ~ 0
d5
Text Label 2050 5950 0    50   ~ 0
d7
Text Label 2050 6250 0    50   ~ 0
a1
Text Label 2050 6350 0    50   ~ 0
a3
Text Label 2050 6450 0    50   ~ 0
a5
Text Label 2050 6550 0    50   ~ 0
a7
Text Label 2050 6650 0    50   ~ 0
a9
Text Label 2050 6750 0    50   ~ 0
a11
Text Label 2050 6850 0    50   ~ 0
a13
Text Label 2050 6950 0    50   ~ 0
a15
Text Label 1550 5350 2    50   ~ 0
~rdy
Text Label 1550 5450 2    50   ~ 0
~oe
Text Label 1550 5650 2    50   ~ 0
d0
Text Label 1550 5750 2    50   ~ 0
d2
Text Label 1550 5950 2    50   ~ 0
d6
Text Label 1550 6250 2    50   ~ 0
a0
Text Label 1550 6350 2    50   ~ 0
a2
Text Label 1550 6450 2    50   ~ 0
a4
Text Label 1550 6550 2    50   ~ 0
a6
Text Label 1550 6650 2    50   ~ 0
a8
Text Label 1550 6750 2    50   ~ 0
a10
Text Label 1550 6850 2    50   ~ 0
a12
Text Label 1550 6950 2    50   ~ 0
a14
NoConn ~ 1550 5250
NoConn ~ 1550 5550
NoConn ~ 1550 6050
NoConn ~ 1550 6150
NoConn ~ 2050 5550
NoConn ~ 2050 6050
NoConn ~ 2050 6150
$Comp
L missing:62256-TSOP U?
U 1 1 5FD1C056
P 7000 5450
F 0 "U?" H 7500 4450 50  0000 C CNN
F 1 "62256-TSOP" H 7550 4300 50  0000 C CNN
F 2 "Package_SO:TSOP-I-28_11.8x8mm_P0.55mm" H 7000 6300 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/1674430.pdf" H 7000 6300 50  0001 C CNN
	1    7000 5450
	1    0    0    -1  
$EndComp
$Comp
L missing:62256-TSOP U?
U 1 1 5FD2039D
P 7000 8900
F 0 "U?" H 7500 7900 50  0000 C CNN
F 1 "62256-TSOP" H 7550 7750 50  0000 C CNN
F 2 "Package_SO:TSOP-I-28_11.8x8mm_P0.55mm" H 7000 9750 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/1674430.pdf" H 7000 9750 50  0001 C CNN
	1    7000 8900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FD27BF6
P 7000 6550
F 0 "#PWR?" H 7000 6300 50  0001 C CNN
F 1 "GND" H 7005 6377 50  0000 C CNN
F 2 "" H 7000 6550 50  0001 C CNN
F 3 "" H 7000 6550 50  0001 C CNN
	1    7000 6550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FD28144
P 7000 10000
F 0 "#PWR?" H 7000 9750 50  0001 C CNN
F 1 "GND" H 7005 9827 50  0000 C CNN
F 2 "" H 7000 10000 50  0001 C CNN
F 3 "" H 7000 10000 50  0001 C CNN
	1    7000 10000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6500 5900 6400 5900
Wire Wire Line
	6500 5800 6400 5800
Wire Wire Line
	6400 5800 6400 5900
Connection ~ 6400 5900
Wire Wire Line
	6500 9350 6400 9350
Wire Wire Line
	6500 9250 6400 9250
Wire Wire Line
	6400 9250 6400 9350
Connection ~ 6400 9350
Entry Wire Line
	6050 4600 6150 4700
Entry Wire Line
	6050 4500 6150 4600
Entry Wire Line
	6050 4700 6150 4800
Entry Wire Line
	6050 4800 6150 4900
Entry Wire Line
	6050 4900 6150 5000
Entry Wire Line
	6050 5000 6150 5100
Entry Wire Line
	6050 5100 6150 5200
Entry Wire Line
	6050 5200 6150 5300
Entry Wire Line
	6050 5300 6150 5400
Entry Wire Line
	6050 5400 6150 5500
Entry Wire Line
	6050 5500 6150 5600
Entry Wire Line
	6050 5600 6150 5700
Wire Wire Line
	6500 5700 6150 5700
Wire Wire Line
	6150 5600 6500 5600
Wire Wire Line
	6500 5500 6150 5500
Wire Wire Line
	6150 5400 6500 5400
Wire Wire Line
	6500 5300 6150 5300
Wire Wire Line
	6150 5200 6500 5200
Wire Wire Line
	6500 5100 6150 5100
Wire Wire Line
	6150 5000 6500 5000
Wire Wire Line
	6500 4900 6150 4900
Wire Wire Line
	6150 4800 6500 4800
Wire Wire Line
	6500 4700 6150 4700
Wire Wire Line
	6150 4600 6500 4600
Text Label 6200 4600 0    50   ~ 0
char_a0
Text Label 6200 4700 0    50   ~ 0
char_a1
Text Label 6200 4800 0    50   ~ 0
char_a2
Text Label 6200 4900 0    50   ~ 0
char_a3
Text Label 6200 5000 0    50   ~ 0
char_a4
Text Label 6200 5100 0    50   ~ 0
char_a5
Text Label 6200 5200 0    50   ~ 0
char_a6
Text Label 6200 5300 0    50   ~ 0
char_a7
Text Label 6200 5400 0    50   ~ 0
char_a8
Text Label 6200 5500 0    50   ~ 0
char_a9
Text Label 6150 5600 0    50   ~ 0
char_a10
Text Label 6150 5700 0    50   ~ 0
char_a11
Entry Wire Line
	6050 8050 6150 8150
Entry Wire Line
	6050 7950 6150 8050
Entry Wire Line
	6050 8150 6150 8250
Entry Wire Line
	6050 8250 6150 8350
Entry Wire Line
	6050 8350 6150 8450
Entry Wire Line
	6050 8450 6150 8550
Entry Wire Line
	6050 8550 6150 8650
Entry Wire Line
	6050 8650 6150 8750
Entry Wire Line
	6050 8750 6150 8850
Entry Wire Line
	6050 8850 6150 8950
Entry Wire Line
	6050 8950 6150 9050
Entry Wire Line
	6050 9050 6150 9150
Wire Wire Line
	6500 9150 6150 9150
Wire Wire Line
	6150 9050 6500 9050
Wire Wire Line
	6500 8950 6150 8950
Wire Wire Line
	6150 8850 6500 8850
Wire Wire Line
	6500 8750 6150 8750
Wire Wire Line
	6150 8650 6500 8650
Wire Wire Line
	6500 8550 6150 8550
Wire Wire Line
	6150 8450 6500 8450
Wire Wire Line
	6500 8350 6150 8350
Wire Wire Line
	6150 8250 6500 8250
Wire Wire Line
	6500 8150 6150 8150
Wire Wire Line
	6150 8050 6500 8050
Text Label 6200 8050 0    50   ~ 0
char_a0
Text Label 6200 8150 0    50   ~ 0
char_a1
Text Label 6200 8250 0    50   ~ 0
char_a2
Text Label 6200 8350 0    50   ~ 0
char_a3
Text Label 6200 8450 0    50   ~ 0
char_a4
Text Label 6200 8550 0    50   ~ 0
char_a5
Text Label 6200 8650 0    50   ~ 0
char_a6
Text Label 6200 8750 0    50   ~ 0
char_a7
Text Label 6200 8850 0    50   ~ 0
char_a8
Text Label 6200 8950 0    50   ~ 0
char_a9
Text Label 6150 9050 0    50   ~ 0
char_a10
Text Label 6150 9150 0    50   ~ 0
char_a11
Text Notes 7000 5800 0    50   ~ 0
text
Text Notes 7000 9400 0    50   ~ 0
color
$Comp
L power:VCC #PWR?
U 1 1 5FD32974
P 7000 7850
F 0 "#PWR?" H 7000 7700 50  0001 C CNN
F 1 "VCC" H 7015 8023 50  0000 C CNN
F 2 "" H 7000 7850 50  0001 C CNN
F 3 "" H 7000 7850 50  0001 C CNN
	1    7000 7850
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5FD3383A
P 7000 4400
F 0 "#PWR?" H 7000 4250 50  0001 C CNN
F 1 "VCC" H 7015 4573 50  0000 C CNN
F 2 "" H 7000 4400 50  0001 C CNN
F 3 "" H 7000 4400 50  0001 C CNN
	1    7000 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	6500 6000 6400 6000
Wire Wire Line
	6400 6000 6400 5900
Wire Wire Line
	6500 9450 6400 9450
Wire Wire Line
	6400 9450 6400 9350
Entry Wire Line
	7900 4600 8000 4700
Entry Wire Line
	7900 4700 8000 4800
Entry Wire Line
	7900 4800 8000 4900
Entry Wire Line
	7900 4900 8000 5000
Entry Wire Line
	7900 5000 8000 5100
Entry Wire Line
	7900 5100 8000 5200
Entry Wire Line
	7900 5200 8000 5300
Entry Wire Line
	7900 5300 8000 5400
Wire Wire Line
	7900 5300 7500 5300
Wire Wire Line
	7500 5200 7900 5200
Wire Wire Line
	7900 5100 7500 5100
Wire Wire Line
	7500 5000 7900 5000
Wire Wire Line
	7500 4900 7900 4900
Wire Wire Line
	7500 4800 7900 4800
Wire Wire Line
	7500 4700 7900 4700
Wire Wire Line
	7500 4600 7900 4600
Text Label 7600 4600 0    50   ~ 0
text_d0
Text Label 7600 4700 0    50   ~ 0
text_d1
Text Label 7600 4800 0    50   ~ 0
text_d2
Text Label 7600 4900 0    50   ~ 0
text_d3
Text Label 7600 5000 0    50   ~ 0
text_d4
Text Label 7600 5100 0    50   ~ 0
text_d5
Text Label 7600 5200 0    50   ~ 0
text_d6
Text Label 7600 5300 0    50   ~ 0
text_d7
$Comp
L 74xx:74HC244 U?
U 1 1 5FD4FC71
P 7000 2250
F 0 "U?" H 7400 1650 50  0000 C CNN
F 1 "74HC244" H 7400 1550 50  0000 C CNN
F 2 "" H 7000 2250 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT244.pdf" H 7000 2250 50  0001 C CNN
	1    7000 2250
	1    0    0    -1  
$EndComp
Entry Wire Line
	7900 1750 8000 1850
Entry Wire Line
	7900 1850 8000 1950
Entry Wire Line
	7900 1950 8000 2050
Entry Wire Line
	7900 2050 8000 2150
Entry Wire Line
	7900 2150 8000 2250
Entry Wire Line
	7900 2250 8000 2350
Entry Wire Line
	7900 2350 8000 2450
Entry Wire Line
	7900 2450 8000 2550
Wire Wire Line
	7900 2450 7500 2450
Wire Wire Line
	7500 2350 7900 2350
Wire Wire Line
	7900 2250 7500 2250
Wire Wire Line
	7500 2150 7900 2150
Wire Wire Line
	7500 2050 7900 2050
Wire Wire Line
	7500 1950 7900 1950
Wire Wire Line
	7500 1850 7900 1850
Wire Wire Line
	7500 1750 7900 1750
Text Label 7600 1750 0    50   ~ 0
text_d0
Text Label 7600 1850 0    50   ~ 0
text_d1
Text Label 7600 1950 0    50   ~ 0
text_d2
Text Label 7600 2050 0    50   ~ 0
text_d3
Text Label 7600 2150 0    50   ~ 0
text_d4
Text Label 7600 2250 0    50   ~ 0
text_d5
Text Label 7600 2350 0    50   ~ 0
text_d6
Text Label 7600 2450 0    50   ~ 0
text_d7
$Comp
L power:VCC #PWR?
U 1 1 5FD551D1
P 7000 1450
F 0 "#PWR?" H 7000 1300 50  0001 C CNN
F 1 "VCC" H 7015 1623 50  0000 C CNN
F 2 "" H 7000 1450 50  0001 C CNN
F 3 "" H 7000 1450 50  0001 C CNN
	1    7000 1450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FD55F10
P 7000 3050
F 0 "#PWR?" H 7000 2800 50  0001 C CNN
F 1 "GND" H 7005 2877 50  0000 C CNN
F 2 "" H 7000 3050 50  0001 C CNN
F 3 "" H 7000 3050 50  0001 C CNN
	1    7000 3050
	1    0    0    -1  
$EndComp
Entry Wire Line
	7900 8050 8000 8150
Entry Wire Line
	7900 8150 8000 8250
Entry Wire Line
	7900 8250 8000 8350
Entry Wire Line
	7900 8350 8000 8450
Entry Wire Line
	7900 8450 8000 8550
Entry Wire Line
	7900 8550 8000 8650
Entry Wire Line
	7900 8650 8000 8750
Entry Wire Line
	7900 8750 8000 8850
Wire Wire Line
	7900 8750 7500 8750
Wire Wire Line
	7500 8650 7900 8650
Wire Wire Line
	7900 8550 7500 8550
Wire Wire Line
	7500 8450 7900 8450
Wire Wire Line
	7500 8350 7900 8350
Wire Wire Line
	7500 8250 7900 8250
Wire Wire Line
	7500 8150 7900 8150
Wire Wire Line
	7500 8050 7900 8050
Text Label 7600 8050 0    50   ~ 0
color_d0
Text Label 7600 8150 0    50   ~ 0
color_d1
Text Label 7600 8250 0    50   ~ 0
color_d2
Text Label 7600 8350 0    50   ~ 0
color_d3
Text Label 7600 8450 0    50   ~ 0
color_d4
Text Label 7600 8550 0    50   ~ 0
color_d5
Text Label 7600 8650 0    50   ~ 0
color_d6
Text Label 7600 8750 0    50   ~ 0
color_d7
$Comp
L 74xx:74HC244 U?
U 1 1 5FCEA5B3
P 9450 2250
F 0 "U?" H 9850 1650 50  0000 C CNN
F 1 "74HC244" H 9850 1550 50  0000 C CNN
F 2 "" H 9450 2250 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT244.pdf" H 9450 2250 50  0001 C CNN
	1    9450 2250
	1    0    0    -1  
$EndComp
Entry Wire Line
	10350 1750 10450 1850
Entry Wire Line
	10350 1850 10450 1950
Entry Wire Line
	10350 1950 10450 2050
Entry Wire Line
	10350 2050 10450 2150
Entry Wire Line
	10350 2150 10450 2250
Entry Wire Line
	10350 2250 10450 2350
Entry Wire Line
	10350 2350 10450 2450
Entry Wire Line
	10350 2450 10450 2550
Wire Wire Line
	10350 2450 9950 2450
Wire Wire Line
	9950 2350 10350 2350
Wire Wire Line
	10350 2250 9950 2250
Wire Wire Line
	9950 2150 10350 2150
Wire Wire Line
	9950 2050 10350 2050
Wire Wire Line
	9950 1950 10350 1950
Wire Wire Line
	9950 1850 10350 1850
Wire Wire Line
	9950 1750 10350 1750
Text Label 10050 1750 0    50   ~ 0
color_d0
Text Label 10050 1850 0    50   ~ 0
color_d1
Text Label 10050 1950 0    50   ~ 0
color_d2
Text Label 10050 2050 0    50   ~ 0
color_d3
Text Label 10050 2150 0    50   ~ 0
color_d4
Text Label 10050 2250 0    50   ~ 0
color_d5
Text Label 10050 2350 0    50   ~ 0
color_d6
Text Label 10050 2450 0    50   ~ 0
color_d7
Wire Bus Line
	8000 7150 10450 7150
Entry Wire Line
	8600 1750 8700 1850
Entry Wire Line
	8600 1650 8700 1750
Entry Wire Line
	8600 1850 8700 1950
Entry Wire Line
	8600 1950 8700 2050
Entry Wire Line
	8600 2050 8700 2150
Entry Wire Line
	8600 2150 8700 2250
Entry Wire Line
	8600 2250 8700 2350
Entry Wire Line
	8600 2350 8700 2450
Wire Wire Line
	8700 1750 8950 1750
Wire Wire Line
	8950 1850 8700 1850
Wire Wire Line
	8700 1950 8950 1950
Wire Wire Line
	8950 2050 8700 2050
Wire Wire Line
	8700 2150 8950 2150
Wire Wire Line
	8950 2250 8700 2250
Wire Wire Line
	8700 2350 8950 2350
Wire Wire Line
	8950 2450 8700 2450
Text Label 8750 1750 0    50   ~ 0
d0
Text Label 8750 1850 0    50   ~ 0
d1
Text Label 8750 1950 0    50   ~ 0
d2
Text Label 8750 2050 0    50   ~ 0
d3
Text Label 8750 2150 0    50   ~ 0
d4
Text Label 8750 2250 0    50   ~ 0
d5
Text Label 8750 2350 0    50   ~ 0
d6
Text Label 8750 2450 0    50   ~ 0
d7
Entry Wire Line
	6150 1750 6250 1850
Entry Wire Line
	6150 1650 6250 1750
Entry Wire Line
	6150 1850 6250 1950
Entry Wire Line
	6150 1950 6250 2050
Entry Wire Line
	6150 2050 6250 2150
Entry Wire Line
	6150 2150 6250 2250
Entry Wire Line
	6150 2250 6250 2350
Entry Wire Line
	6150 2350 6250 2450
Wire Wire Line
	6250 1750 6500 1750
Wire Wire Line
	6500 1850 6250 1850
Wire Wire Line
	6250 1950 6500 1950
Wire Wire Line
	6500 2050 6250 2050
Wire Wire Line
	6250 2150 6500 2150
Wire Wire Line
	6500 2250 6250 2250
Wire Wire Line
	6250 2350 6500 2350
Wire Wire Line
	6500 2450 6250 2450
Text Label 6300 1750 0    50   ~ 0
d0
Text Label 6300 1850 0    50   ~ 0
d1
Text Label 6300 1950 0    50   ~ 0
d2
Text Label 6300 2050 0    50   ~ 0
d3
Text Label 6300 2150 0    50   ~ 0
d4
Text Label 6300 2250 0    50   ~ 0
d5
Text Label 6300 2350 0    50   ~ 0
d6
Text Label 6300 2450 0    50   ~ 0
d7
$Comp
L power:VCC #PWR?
U 1 1 5FD0C1AF
P 9450 1450
F 0 "#PWR?" H 9450 1300 50  0001 C CNN
F 1 "VCC" H 9465 1623 50  0000 C CNN
F 2 "" H 9450 1450 50  0001 C CNN
F 3 "" H 9450 1450 50  0001 C CNN
	1    9450 1450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FD0C6AD
P 9450 3050
F 0 "#PWR?" H 9450 2800 50  0001 C CNN
F 1 "GND" H 9455 2877 50  0000 C CNN
F 2 "" H 9450 3050 50  0001 C CNN
F 3 "" H 9450 3050 50  0001 C CNN
	1    9450 3050
	1    0    0    -1  
$EndComp
Wire Bus Line
	8600 1100 6150 1100
Wire Bus Line
	6150 1100 5950 1100
Connection ~ 6150 1100
Text Label 5950 1100 2    50   ~ 0
d[0..7]
$Comp
L missing:AT28C256-PLCC32 U?
U 1 1 5FD15217
P 11950 5550
F 0 "U?" H 12400 4600 50  0000 C CNN
F 1 "AT28C256-PLCC32" H 12400 4450 50  0000 C CNN
F 2 "" H 12200 5900 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/doc0006.pdf" H 12200 5900 50  0001 C CNN
	1    11950 5550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FD189C4
P 11950 6650
F 0 "#PWR?" H 11950 6400 50  0001 C CNN
F 1 "GND" H 11955 6477 50  0000 C CNN
F 2 "" H 11950 6650 50  0001 C CNN
F 3 "" H 11950 6650 50  0001 C CNN
	1    11950 6650
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5FD18EC1
P 11950 4450
F 0 "#PWR?" H 11950 4300 50  0001 C CNN
F 1 "VCC" H 11965 4623 50  0000 C CNN
F 2 "" H 11950 4450 50  0001 C CNN
F 3 "" H 11950 4450 50  0001 C CNN
	1    11950 4450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FD1982F
P 11550 6450
F 0 "#PWR?" H 11550 6200 50  0001 C CNN
F 1 "GND" V 11555 6277 50  0000 C CNN
F 2 "" H 11550 6450 50  0001 C CNN
F 3 "" H 11550 6450 50  0001 C CNN
	1    11550 6450
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FD19FDE
P 11550 6250
F 0 "#PWR?" H 11550 6000 50  0001 C CNN
F 1 "GND" V 11555 6077 50  0000 C CNN
F 2 "" H 11550 6250 50  0001 C CNN
F 3 "" H 11550 6250 50  0001 C CNN
	1    11550 6250
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5FD1A58F
P 11550 6350
F 0 "#PWR?" H 11550 6200 50  0001 C CNN
F 1 "VCC" V 11550 6550 50  0000 C CNN
F 2 "" H 11550 6350 50  0001 C CNN
F 3 "" H 11550 6350 50  0001 C CNN
	1    11550 6350
	0    -1   -1   0   
$EndComp
Entry Wire Line
	11150 5050 11050 5150
Entry Wire Line
	11150 5150 11050 5250
Entry Wire Line
	11150 5250 11050 5350
Entry Wire Line
	11150 5350 11050 5450
Entry Wire Line
	11150 5450 11050 5550
Entry Wire Line
	11150 5550 11050 5650
Entry Wire Line
	11150 5650 11050 5750
Entry Wire Line
	11150 5750 11050 5850
Wire Wire Line
	11150 5750 11550 5750
Wire Wire Line
	11550 5650 11150 5650
Wire Wire Line
	11150 5550 11550 5550
Wire Wire Line
	11550 5450 11150 5450
Wire Wire Line
	11550 5350 11150 5350
Wire Wire Line
	11550 5250 11150 5250
Wire Wire Line
	11550 5150 11150 5150
Wire Wire Line
	11550 5050 11150 5050
Text Label 11450 5050 2    50   ~ 0
text_d0
Text Label 11450 5150 2    50   ~ 0
text_d1
Text Label 11450 5250 2    50   ~ 0
text_d2
Text Label 11450 5350 2    50   ~ 0
text_d3
Text Label 11450 5450 2    50   ~ 0
text_d4
Text Label 11450 5550 2    50   ~ 0
text_d5
Text Label 11450 5650 2    50   ~ 0
text_d6
Text Label 11450 5750 2    50   ~ 0
text_d7
Wire Bus Line
	11050 5850 8000 5850
Wire Wire Line
	11550 6050 11450 6050
Wire Wire Line
	11450 6050 11450 5950
Wire Wire Line
	11450 5850 11550 5850
Wire Wire Line
	11550 5950 11450 5950
Connection ~ 11450 5950
Wire Wire Line
	11450 5950 11450 5850
Text Label 11350 4650 2    50   ~ 0
vy0
Text Label 11350 4750 2    50   ~ 0
vy1
Text Label 11350 4850 2    50   ~ 0
vy2
Text Label 11350 4950 2    50   ~ 0
vy3
$Comp
L 74xx:74HC273 U?
U 1 1 5FD56F7F
P 13750 5150
F 0 "U?" H 14150 4550 50  0000 C CNN
F 1 "74HC273" H 14150 4450 50  0000 C CNN
F 2 "" H 13750 5150 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT273.pdf" H 13750 5150 50  0001 C CNN
	1    13750 5150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FD59AF2
P 13750 5950
F 0 "#PWR?" H 13750 5700 50  0001 C CNN
F 1 "GND" H 13755 5777 50  0000 C CNN
F 2 "" H 13750 5950 50  0001 C CNN
F 3 "" H 13750 5950 50  0001 C CNN
	1    13750 5950
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5FD5A15D
P 13750 4350
F 0 "#PWR?" H 13750 4200 50  0001 C CNN
F 1 "VCC" H 13765 4523 50  0000 C CNN
F 2 "" H 13750 4350 50  0001 C CNN
F 3 "" H 13750 4350 50  0001 C CNN
	1    13750 4350
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC273 U?
U 1 1 5FD60D8B
P 13750 7800
F 0 "U?" H 14150 7200 50  0000 C CNN
F 1 "74HC273" H 14150 7100 50  0000 C CNN
F 2 "" H 13750 7800 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT273.pdf" H 13750 7800 50  0001 C CNN
	1    13750 7800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FD60D91
P 13750 8600
F 0 "#PWR?" H 13750 8350 50  0001 C CNN
F 1 "GND" H 13755 8427 50  0000 C CNN
F 2 "" H 13750 8600 50  0001 C CNN
F 3 "" H 13750 8600 50  0001 C CNN
	1    13750 8600
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5FD60D97
P 13750 7000
F 0 "#PWR?" H 13750 6850 50  0001 C CNN
F 1 "VCC" H 13765 7173 50  0000 C CNN
F 2 "" H 13750 7000 50  0001 C CNN
F 3 "" H 13750 7000 50  0001 C CNN
	1    13750 7000
	1    0    0    -1  
$EndComp
Wire Wire Line
	12350 4650 13250 4650
Wire Wire Line
	12350 4750 13250 4750
Wire Wire Line
	12350 4850 13250 4850
Wire Wire Line
	12350 4950 13250 4950
Wire Wire Line
	12350 5050 13250 5050
Wire Wire Line
	12350 5150 13250 5150
Wire Wire Line
	12350 5250 13250 5250
Wire Wire Line
	12350 5350 13250 5350
Entry Wire Line
	12850 7300 12750 7400
Entry Wire Line
	12850 7400 12750 7500
Entry Wire Line
	12850 7500 12750 7600
Entry Wire Line
	12850 7600 12750 7700
Entry Wire Line
	12850 7700 12750 7800
Entry Wire Line
	12850 7800 12750 7900
Entry Wire Line
	12850 7900 12750 8000
Entry Wire Line
	12850 8000 12750 8100
Wire Wire Line
	12850 8000 13250 8000
Wire Wire Line
	13250 7900 12850 7900
Wire Wire Line
	12850 7800 13250 7800
Wire Wire Line
	13250 7700 12850 7700
Wire Wire Line
	13250 7600 12850 7600
Wire Wire Line
	13250 7500 12850 7500
Wire Wire Line
	13250 7400 12850 7400
Wire Wire Line
	13250 7300 12850 7300
Text Label 13150 7300 2    50   ~ 0
color_d0
Text Label 13150 7400 2    50   ~ 0
color_d1
Text Label 13150 7500 2    50   ~ 0
color_d2
Text Label 13150 7600 2    50   ~ 0
color_d3
Text Label 13150 7700 2    50   ~ 0
color_d4
Text Label 13150 7800 2    50   ~ 0
color_d5
Text Label 13150 7900 2    50   ~ 0
color_d6
Text Label 13150 8000 2    50   ~ 0
color_d7
Wire Bus Line
	12750 7150 10450 7150
Connection ~ 10450 7150
Text Label 12600 4650 0    50   ~ 0
cgrom_d0
Text Label 12600 4750 0    50   ~ 0
cgrom_d1
Text Label 12600 4850 0    50   ~ 0
cgrom_d2
Text Label 12600 4950 0    50   ~ 0
cgrom_d3
Text Label 12600 5050 0    50   ~ 0
cgrom_d4
Text Label 12600 5150 0    50   ~ 0
cgrom_d5
Text Label 12600 5250 0    50   ~ 0
cgrom_d6
Text Label 12600 5350 0    50   ~ 0
cgrom_d7
$Comp
L 74xx:74LS157 U?
U 1 1 5FDA1050
P 4850 5150
F 0 "U?" H 5200 4300 50  0000 C CNN
F 1 "74LS157" H 5200 4200 50  0000 C CNN
F 2 "" H 4850 5150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS157" H 4850 5150 50  0001 C CNN
	1    4850 5150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FDA47FB
P 4850 6150
F 0 "#PWR?" H 4850 5900 50  0001 C CNN
F 1 "GND" H 4855 5977 50  0000 C CNN
F 2 "" H 4850 6150 50  0001 C CNN
F 3 "" H 4850 6150 50  0001 C CNN
	1    4850 6150
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5FDA4BE1
P 4850 4250
F 0 "#PWR?" H 4850 4100 50  0001 C CNN
F 1 "VCC" H 4865 4423 50  0000 C CNN
F 2 "" H 4850 4250 50  0001 C CNN
F 3 "" H 4850 4250 50  0001 C CNN
	1    4850 4250
	1    0    0    -1  
$EndComp
Entry Wire Line
	5950 4550 6050 4650
Entry Wire Line
	5950 4850 6050 4950
Entry Wire Line
	5950 5150 6050 5250
Entry Wire Line
	5950 5450 6050 5550
Wire Wire Line
	5350 4550 5950 4550
Wire Wire Line
	5950 4850 5350 4850
Wire Wire Line
	5350 5150 5950 5150
Wire Wire Line
	5950 5450 5350 5450
Text Label 5500 4550 0    50   ~ 0
char_a0
Text Label 5500 4850 0    50   ~ 0
char_a1
Text Label 5500 5150 0    50   ~ 0
char_a2
Text Label 5500 5450 0    50   ~ 0
char_a3
$Comp
L 74xx:74LS157 U?
U 1 1 5FDCF974
P 4850 7500
F 0 "U?" H 5200 6650 50  0000 C CNN
F 1 "74LS157" H 5200 6550 50  0000 C CNN
F 2 "" H 4850 7500 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS157" H 4850 7500 50  0001 C CNN
	1    4850 7500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FDCF97A
P 4850 8500
F 0 "#PWR?" H 4850 8250 50  0001 C CNN
F 1 "GND" H 4855 8327 50  0000 C CNN
F 2 "" H 4850 8500 50  0001 C CNN
F 3 "" H 4850 8500 50  0001 C CNN
	1    4850 8500
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5FDCF980
P 4850 6600
F 0 "#PWR?" H 4850 6450 50  0001 C CNN
F 1 "VCC" H 4865 6773 50  0000 C CNN
F 2 "" H 4850 6600 50  0001 C CNN
F 3 "" H 4850 6600 50  0001 C CNN
	1    4850 6600
	1    0    0    -1  
$EndComp
Entry Wire Line
	5950 6900 6050 7000
Entry Wire Line
	5950 7200 6050 7300
Entry Wire Line
	5950 7500 6050 7600
Entry Wire Line
	5950 7800 6050 7900
Wire Wire Line
	5350 6900 5950 6900
Wire Wire Line
	5950 7200 5350 7200
Wire Wire Line
	5350 7500 5950 7500
Wire Wire Line
	5950 7800 5350 7800
Text Label 5500 6900 0    50   ~ 0
char_a4
Text Label 5500 7200 0    50   ~ 0
char_a5
Text Label 5500 7500 0    50   ~ 0
char_a6
Text Label 5500 7800 0    50   ~ 0
char_a7
$Comp
L 74xx:74LS157 U?
U 1 1 5FDD802B
P 4850 9850
F 0 "U?" H 5200 9000 50  0000 C CNN
F 1 "74LS157" H 5200 8900 50  0000 C CNN
F 2 "" H 4850 9850 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS157" H 4850 9850 50  0001 C CNN
	1    4850 9850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FDD8031
P 4850 10850
F 0 "#PWR?" H 4850 10600 50  0001 C CNN
F 1 "GND" H 4855 10677 50  0000 C CNN
F 2 "" H 4850 10850 50  0001 C CNN
F 3 "" H 4850 10850 50  0001 C CNN
	1    4850 10850
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5FDD8037
P 4850 8950
F 0 "#PWR?" H 4850 8800 50  0001 C CNN
F 1 "VCC" H 4865 9123 50  0000 C CNN
F 2 "" H 4850 8950 50  0001 C CNN
F 3 "" H 4850 8950 50  0001 C CNN
	1    4850 8950
	1    0    0    -1  
$EndComp
Entry Wire Line
	5950 9250 6050 9350
Entry Wire Line
	5950 9550 6050 9650
Entry Wire Line
	5950 9850 6050 9950
Entry Wire Line
	5950 10150 6050 10250
Wire Wire Line
	5350 9250 5950 9250
Wire Wire Line
	5950 9550 5350 9550
Wire Wire Line
	5350 9850 5950 9850
Wire Wire Line
	5950 10150 5350 10150
Text Label 5500 9250 0    50   ~ 0
char_a8
Text Label 5500 9550 0    50   ~ 0
char_a9
Text Label 5500 9850 0    50   ~ 0
char_a10
Text Label 5500 10150 0    50   ~ 0
char_a11
Text Label 4350 4650 2    50   ~ 0
a0
Text Label 4350 4950 2    50   ~ 0
a1
Text Label 4350 5250 2    50   ~ 0
a2
Text Label 4350 5550 2    50   ~ 0
a3
Text Label 4350 7000 2    50   ~ 0
a4
Text Label 4350 7300 2    50   ~ 0
a5
Text Label 4350 7600 2    50   ~ 0
a6
Text Label 4350 7900 2    50   ~ 0
a7
Text Label 4350 9350 2    50   ~ 0
a8
Text Label 4350 9650 2    50   ~ 0
a9
Text Label 4350 9950 2    50   ~ 0
a10
Text Label 4350 10250 2    50   ~ 0
a11
Entry Wire Line
	3850 4450 3950 4550
Entry Wire Line
	3850 4750 3950 4850
Entry Wire Line
	3850 5050 3950 5150
Entry Wire Line
	3850 5350 3950 5450
Wire Wire Line
	3950 4550 4350 4550
Wire Wire Line
	4350 4850 3950 4850
Wire Wire Line
	3950 5150 4350 5150
Wire Wire Line
	4350 5450 3950 5450
Text Label 4000 4550 0    50   ~ 0
int_a0
Text Label 4000 4850 0    50   ~ 0
int_a1
Text Label 4000 5150 0    50   ~ 0
int_a2
Text Label 4000 5450 0    50   ~ 0
int_a3
Entry Wire Line
	3850 6800 3950 6900
Entry Wire Line
	3850 7100 3950 7200
Entry Wire Line
	3850 7400 3950 7500
Entry Wire Line
	3850 7700 3950 7800
Wire Wire Line
	3950 6900 4350 6900
Wire Wire Line
	4350 7200 3950 7200
Wire Wire Line
	3950 7500 4350 7500
Wire Wire Line
	4350 7800 3950 7800
Text Label 4000 6900 0    50   ~ 0
int_a4
Text Label 4000 7200 0    50   ~ 0
int_a5
Text Label 4000 7500 0    50   ~ 0
int_a6
Text Label 4000 7800 0    50   ~ 0
int_a7
Entry Wire Line
	3850 9150 3950 9250
Entry Wire Line
	3850 9450 3950 9550
Entry Wire Line
	3850 9750 3950 9850
Entry Wire Line
	3850 10050 3950 10150
Wire Wire Line
	3950 9250 4350 9250
Wire Wire Line
	4350 9550 3950 9550
Wire Wire Line
	3950 9850 4350 9850
Wire Wire Line
	4350 10150 3950 10150
Text Label 4000 9250 0    50   ~ 0
int_a8
Text Label 4000 9550 0    50   ~ 0
int_a9
Text Label 4000 9850 0    50   ~ 0
int_a10
Text Label 4000 10150 0    50   ~ 0
int_a11
Entry Wire Line
	3750 10950 3850 11050
Entry Wire Line
	3750 11050 3850 11150
Entry Wire Line
	3750 11150 3850 11250
Entry Wire Line
	3750 11250 3850 11350
Entry Wire Line
	3750 11350 3850 11450
Entry Wire Line
	3750 11450 3850 11550
Entry Wire Line
	3750 11550 3850 11650
Entry Wire Line
	3750 11950 3850 12050
Entry Wire Line
	3750 12050 3850 12150
Entry Wire Line
	3750 12150 3850 12250
Entry Wire Line
	3750 12250 3850 12350
Entry Wire Line
	3750 12350 3850 12450
Wire Wire Line
	3050 10950 3750 10950
Wire Wire Line
	3050 11050 3750 11050
Wire Wire Line
	3050 11150 3750 11150
Wire Wire Line
	3050 11250 3750 11250
Wire Wire Line
	3050 11350 3750 11350
Wire Wire Line
	3050 11450 3750 11450
Wire Wire Line
	3050 11550 3750 11550
Wire Wire Line
	3050 11950 3750 11950
Wire Wire Line
	3050 12050 3750 12050
Wire Wire Line
	3050 12150 3750 12150
Wire Wire Line
	3050 12250 3750 12250
Wire Wire Line
	3050 12350 3750 12350
Text Label 3750 10950 2    50   ~ 0
int_a0
Text Label 3750 11050 2    50   ~ 0
int_a1
Text Label 3750 11150 2    50   ~ 0
int_a2
Text Label 3750 11250 2    50   ~ 0
int_a3
Text Label 3750 11350 2    50   ~ 0
int_a4
Text Label 3750 11450 2    50   ~ 0
int_a5
Text Label 3750 11550 2    50   ~ 0
int_a6
Text Label 3750 11950 2    50   ~ 0
int_a7
Text Label 3750 12050 2    50   ~ 0
int_a8
Text Label 3750 12150 2    50   ~ 0
int_a9
Text Label 3750 12250 2    50   ~ 0
int_a10
Text Label 3750 12350 2    50   ~ 0
int_a11
Text Label 3400 11950 2    50   ~ 0
crow0
Text Label 3400 12050 2    50   ~ 0
crow1
Text Label 3400 12150 2    50   ~ 0
crow2
Text Label 3400 12250 2    50   ~ 0
crow3
Text Label 3400 12350 2    50   ~ 0
crow4
Text Label 3050 11950 2    50   ~ 0
vy4
Text Label 3050 12050 2    50   ~ 0
vy5
Text Label 3050 12150 2    50   ~ 0
vy6
Text Label 3050 12250 2    50   ~ 0
vy7
Text Label 3050 12350 2    50   ~ 0
vy8
Text Label 3050 10950 2    50   ~ 0
ccol0
Text Label 3050 11050 2    50   ~ 0
ccol1
Text Label 3050 11150 2    50   ~ 0
ccol2
Text Label 3050 11250 2    50   ~ 0
ccol3
Text Label 3050 11350 2    50   ~ 0
ccol4
Text Label 3050 11450 2    50   ~ 0
ccol5
Text Label 3050 11550 2    50   ~ 0
ccol6
$Comp
L power:GND #PWR?
U 1 1 5FE9ACC4
P 4350 5850
F 0 "#PWR?" H 4350 5600 50  0001 C CNN
F 1 "GND" H 4355 5677 50  0000 C CNN
F 2 "" H 4350 5850 50  0001 C CNN
F 3 "" H 4350 5850 50  0001 C CNN
	1    4350 5850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FE9B011
P 4350 8200
F 0 "#PWR?" H 4350 7950 50  0001 C CNN
F 1 "GND" H 4355 8027 50  0000 C CNN
F 2 "" H 4350 8200 50  0001 C CNN
F 3 "" H 4350 8200 50  0001 C CNN
	1    4350 8200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FE9B693
P 4350 10550
F 0 "#PWR?" H 4350 10300 50  0001 C CNN
F 1 "GND" H 4355 10377 50  0000 C CNN
F 2 "" H 4350 10550 50  0001 C CNN
F 3 "" H 4350 10550 50  0001 C CNN
	1    4350 10550
	1    0    0    -1  
$EndComp
Wire Wire Line
	4350 5750 4100 5750
Wire Wire Line
	4100 5750 4100 8100
Wire Wire Line
	4350 10450 4100 10450
Connection ~ 4100 10450
Wire Wire Line
	4100 10450 4100 11100
Wire Wire Line
	4350 8100 4100 8100
Connection ~ 4100 8100
Wire Wire Line
	4100 8100 4100 10450
Text Label 4100 11100 3    50   ~ 0
a_sel
Wire Wire Line
	11550 4650 11350 4650
Wire Wire Line
	11350 4750 11550 4750
Wire Wire Line
	11550 4850 11350 4850
Wire Wire Line
	11350 4950 11550 4950
Text Label 6350 2700 2    50   ~ 0
~d_to_text_oe
Wire Wire Line
	6350 2700 6500 2700
Wire Wire Line
	6500 2700 6500 2650
Wire Wire Line
	6500 2750 6500 2700
Connection ~ 6500 2700
Text Label 8800 2700 2    50   ~ 0
~d_to_color_oe
Wire Wire Line
	8800 2700 8950 2700
Wire Wire Line
	8950 2700 8950 2650
Wire Wire Line
	8950 2700 8950 2750
Connection ~ 8950 2700
Text Label 6500 6200 2    50   ~ 0
~text_ram_we
Text Label 6500 6300 2    50   ~ 0
~text_ram_oe
Text Label 6500 6400 2    50   ~ 0
~text_ram_cs
Text Label 6500 9650 2    50   ~ 0
~color_ram_we
Text Label 6500 9750 2    50   ~ 0
~color_ram_oe
Text Label 6500 9850 2    50   ~ 0
~color_ram_cs
Text Label 13250 5650 2    50   ~ 0
~rst
Text Label 13250 8300 2    50   ~ 0
~rst
Wire Wire Line
	13250 5550 13000 5550
Wire Wire Line
	13000 5550 13000 8200
Wire Wire Line
	13000 8200 13250 8200
Wire Wire Line
	13000 8200 13000 8600
Connection ~ 13000 8200
Text Label 13000 8600 3    50   ~ 0
buf_clk
$Comp
L 74xx:74LS151 U?
U 1 1 5FF79203
P 15850 5250
F 0 "U?" H 16250 4500 50  0000 C CNN
F 1 "74LS151" H 16200 4350 50  0000 C CNN
F 2 "" H 15850 5250 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS151" H 15850 5250 50  0001 C CNN
	1    15850 5250
	1    0    0    -1  
$EndComp
Wire Wire Line
	14250 4650 15350 4650
Wire Wire Line
	14250 4750 15350 4750
Wire Wire Line
	14250 4850 15350 4850
Wire Wire Line
	14250 4950 15350 4950
Wire Wire Line
	14250 5050 15350 5050
Wire Wire Line
	14250 5150 15350 5150
Wire Wire Line
	14250 5250 15350 5250
Wire Wire Line
	14250 5350 15350 5350
Text Label 14400 4650 0    50   ~ 0
stored_pixel0
Text Label 14400 4750 0    50   ~ 0
stored_pixel1
Text Label 14400 4850 0    50   ~ 0
stored_pixel2
Text Label 14400 4950 0    50   ~ 0
stored_pixel3
Text Label 14400 5050 0    50   ~ 0
stored_pixel4
Text Label 14400 5150 0    50   ~ 0
stored_pixel5
Text Label 14400 5250 0    50   ~ 0
stored_pixel6
Text Label 14400 5350 0    50   ~ 0
stored_pixel7
NoConn ~ 16350 4750
Text Label 15350 5550 2    50   ~ 0
hx0
Text Label 15350 5650 2    50   ~ 0
hx1
Text Label 15350 5750 2    50   ~ 0
hx2
Text Label 17450 5950 2    50   ~ 0
~pixel_ena
$Comp
L power:GND #PWR?
U 1 1 6000AF94
P 15850 6250
F 0 "#PWR?" H 15850 6000 50  0001 C CNN
F 1 "GND" H 15855 6077 50  0000 C CNN
F 2 "" H 15850 6250 50  0001 C CNN
F 3 "" H 15850 6250 50  0001 C CNN
	1    15850 6250
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 6000B347
P 15850 4350
F 0 "#PWR?" H 15850 4200 50  0001 C CNN
F 1 "VCC" H 15865 4523 50  0000 C CNN
F 2 "" H 15850 4350 50  0001 C CNN
F 3 "" H 15850 4350 50  0001 C CNN
	1    15850 4350
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS157 U?
U 1 1 6000BE47
P 17950 5250
F 0 "U?" H 18300 4400 50  0000 C CNN
F 1 "74LS157" H 18300 4300 50  0000 C CNN
F 2 "" H 17950 5250 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS157" H 17950 5250 50  0001 C CNN
	1    17950 5250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 6000EF9E
P 17950 6250
F 0 "#PWR?" H 17950 6000 50  0001 C CNN
F 1 "GND" H 17955 6077 50  0000 C CNN
F 2 "" H 17950 6250 50  0001 C CNN
F 3 "" H 17950 6250 50  0001 C CNN
	1    17950 6250
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 6000F3B7
P 17950 4350
F 0 "#PWR?" H 17950 4200 50  0001 C CNN
F 1 "VCC" H 17965 4523 50  0000 C CNN
F 2 "" H 17950 4350 50  0001 C CNN
F 3 "" H 17950 4350 50  0001 C CNN
	1    17950 4350
	1    0    0    -1  
$EndComp
Text Label 14250 7300 0    50   ~ 0
stored_color0
Text Label 14250 7400 0    50   ~ 0
stored_color1
Text Label 14250 7500 0    50   ~ 0
stored_color2
Text Label 14250 7600 0    50   ~ 0
stored_color3
Text Label 14250 7700 0    50   ~ 0
stored_color4
Text Label 14250 7800 0    50   ~ 0
stored_color5
Text Label 14250 7900 0    50   ~ 0
stored_color6
Text Label 14250 8000 0    50   ~ 0
stored_color7
Text Label 17450 4750 2    50   ~ 0
stored_color0
Text Label 17450 5050 2    50   ~ 0
stored_color1
Text Label 17450 5350 2    50   ~ 0
stored_color2
Text Label 17450 5650 2    50   ~ 0
stored_color3
Text Label 17450 4650 2    50   ~ 0
stored_color4
Text Label 17450 4950 2    50   ~ 0
stored_color5
Text Label 17450 5250 2    50   ~ 0
stored_color6
Text Label 17450 5550 2    50   ~ 0
stored_color7
$Comp
L power:GND #PWR?
U 1 1 60039A1B
P 15350 5950
F 0 "#PWR?" H 15350 5700 50  0001 C CNN
F 1 "GND" H 15355 5777 50  0000 C CNN
F 2 "" H 15350 5950 50  0001 C CNN
F 3 "" H 15350 5950 50  0001 C CNN
	1    15350 5950
	0    1    1    0   
$EndComp
Wire Wire Line
	16350 4650 16700 4650
Wire Wire Line
	16700 4650 16700 5850
Wire Wire Line
	16700 5850 17450 5850
Text Label 16700 4650 2    50   ~ 0
pixel_out
$Comp
L 74xx:74LS161 U?
U 1 1 6004D240
P 3700 13850
F 0 "U?" H 4100 13250 50  0000 C CNN
F 1 "74LS161" H 4100 13150 50  0000 C CNN
F 2 "" H 3700 13850 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS161" H 3700 13850 50  0001 C CNN
	1    3700 13850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 60053D63
P 3700 14650
F 0 "#PWR?" H 3700 14400 50  0001 C CNN
F 1 "GND" H 3705 14477 50  0000 C CNN
F 2 "" H 3700 14650 50  0001 C CNN
F 3 "" H 3700 14650 50  0001 C CNN
	1    3700 14650
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 600547BD
P 3700 13050
F 0 "#PWR?" H 3700 12900 50  0001 C CNN
F 1 "VCC" H 3715 13223 50  0000 C CNN
F 2 "" H 3700 13050 50  0001 C CNN
F 3 "" H 3700 13050 50  0001 C CNN
	1    3700 13050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 60055037
P 3100 13500
F 0 "#PWR?" H 3100 13250 50  0001 C CNN
F 1 "GND" H 3105 13327 50  0000 C CNN
F 2 "" H 3100 13500 50  0001 C CNN
F 3 "" H 3100 13500 50  0001 C CNN
	1    3100 13500
	0    1    1    0   
$EndComp
Wire Wire Line
	3200 13350 3200 13450
Connection ~ 3200 13450
Wire Wire Line
	3200 13450 3200 13500
Connection ~ 3200 13550
Wire Wire Line
	3200 13550 3200 13650
Wire Wire Line
	3100 13500 3200 13500
Connection ~ 3200 13500
Wire Wire Line
	3200 13500 3200 13550
$Comp
L power:VCC #PWR?
U 1 1 600764C8
P 3200 13850
F 0 "#PWR?" H 3200 13700 50  0001 C CNN
F 1 "VCC" V 3215 14023 50  0000 C CNN
F 2 "" H 3200 13850 50  0001 C CNN
F 3 "" H 3200 13850 50  0001 C CNN
	1    3200 13850
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 600772B8
P 3200 13950
F 0 "#PWR?" H 3200 13800 50  0001 C CNN
F 1 "VCC" V 3215 14123 50  0000 C CNN
F 2 "" H 3200 13950 50  0001 C CNN
F 3 "" H 3200 13950 50  0001 C CNN
	1    3200 13950
	0    -1   -1   0   
$EndComp
$Comp
L 74xx:74LS161 U?
U 1 1 6007D21B
P 5400 13850
F 0 "U?" H 5800 13250 50  0000 C CNN
F 1 "74LS161" H 5800 13150 50  0000 C CNN
F 2 "" H 5400 13850 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS161" H 5400 13850 50  0001 C CNN
	1    5400 13850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 6007D221
P 5400 14650
F 0 "#PWR?" H 5400 14400 50  0001 C CNN
F 1 "GND" H 5405 14477 50  0000 C CNN
F 2 "" H 5400 14650 50  0001 C CNN
F 3 "" H 5400 14650 50  0001 C CNN
	1    5400 14650
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 6007D227
P 5400 13050
F 0 "#PWR?" H 5400 12900 50  0001 C CNN
F 1 "VCC" H 5415 13223 50  0000 C CNN
F 2 "" H 5400 13050 50  0001 C CNN
F 3 "" H 5400 13050 50  0001 C CNN
	1    5400 13050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 6007D22D
P 4800 13500
F 0 "#PWR?" H 4800 13250 50  0001 C CNN
F 1 "GND" H 4805 13327 50  0000 C CNN
F 2 "" H 4800 13500 50  0001 C CNN
F 3 "" H 4800 13500 50  0001 C CNN
	1    4800 13500
	0    1    1    0   
$EndComp
Wire Wire Line
	4900 13350 4900 13450
Connection ~ 4900 13450
Wire Wire Line
	4900 13450 4900 13500
Connection ~ 4900 13550
Wire Wire Line
	4900 13550 4900 13650
Wire Wire Line
	4800 13500 4900 13500
Connection ~ 4900 13500
Wire Wire Line
	4900 13500 4900 13550
$Comp
L power:VCC #PWR?
U 1 1 6007D23B
P 4900 13850
F 0 "#PWR?" H 4900 13700 50  0001 C CNN
F 1 "VCC" V 4915 14023 50  0000 C CNN
F 2 "" H 4900 13850 50  0001 C CNN
F 3 "" H 4900 13850 50  0001 C CNN
	1    4900 13850
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 6007D241
P 4900 13950
F 0 "#PWR?" H 4900 13800 50  0001 C CNN
F 1 "VCC" V 4915 14123 50  0000 C CNN
F 2 "" H 4900 13950 50  0001 C CNN
F 3 "" H 4900 13950 50  0001 C CNN
	1    4900 13950
	0    -1   -1   0   
$EndComp
$Comp
L 74xx:74LS161 U?
U 1 1 6008F72C
P 7100 13850
F 0 "U?" H 7500 13250 50  0000 C CNN
F 1 "74LS161" H 7500 13150 50  0000 C CNN
F 2 "" H 7100 13850 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS161" H 7100 13850 50  0001 C CNN
	1    7100 13850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 6008F732
P 7100 14650
F 0 "#PWR?" H 7100 14400 50  0001 C CNN
F 1 "GND" H 7105 14477 50  0000 C CNN
F 2 "" H 7100 14650 50  0001 C CNN
F 3 "" H 7100 14650 50  0001 C CNN
	1    7100 14650
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 6008F738
P 7100 13050
F 0 "#PWR?" H 7100 12900 50  0001 C CNN
F 1 "VCC" H 7115 13223 50  0000 C CNN
F 2 "" H 7100 13050 50  0001 C CNN
F 3 "" H 7100 13050 50  0001 C CNN
	1    7100 13050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 6008F73E
P 6500 13500
F 0 "#PWR?" H 6500 13250 50  0001 C CNN
F 1 "GND" H 6505 13327 50  0000 C CNN
F 2 "" H 6500 13500 50  0001 C CNN
F 3 "" H 6500 13500 50  0001 C CNN
	1    6500 13500
	0    1    1    0   
$EndComp
Wire Wire Line
	6600 13350 6600 13450
Connection ~ 6600 13450
Wire Wire Line
	6600 13450 6600 13500
Connection ~ 6600 13550
Wire Wire Line
	6600 13550 6600 13650
Wire Wire Line
	6500 13500 6600 13500
Connection ~ 6600 13500
Wire Wire Line
	6600 13500 6600 13550
$Comp
L power:VCC #PWR?
U 1 1 6008F74C
P 6600 13850
F 0 "#PWR?" H 6600 13700 50  0001 C CNN
F 1 "VCC" V 6615 14023 50  0000 C CNN
F 2 "" H 6600 13850 50  0001 C CNN
F 3 "" H 6600 13850 50  0001 C CNN
	1    6600 13850
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 6008F752
P 6600 13950
F 0 "#PWR?" H 6600 13800 50  0001 C CNN
F 1 "VCC" V 6615 14123 50  0000 C CNN
F 2 "" H 6600 13950 50  0001 C CNN
F 3 "" H 6600 13950 50  0001 C CNN
	1    6600 13950
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4200 13850 4500 13850
Wire Wire Line
	4500 13850 4500 14050
Wire Wire Line
	4500 14050 4900 14050
Wire Wire Line
	5900 13850 6200 13850
Wire Wire Line
	6200 13850 6200 14050
Wire Wire Line
	6200 14050 6600 14050
NoConn ~ 7600 13850
$Comp
L power:VCC #PWR?
U 1 1 600D63C5
P 3200 14050
F 0 "#PWR?" H 3200 13900 50  0001 C CNN
F 1 "VCC" V 3215 14223 50  0000 C CNN
F 2 "" H 3200 14050 50  0001 C CNN
F 3 "" H 3200 14050 50  0001 C CNN
	1    3200 14050
	0    -1   -1   0   
$EndComp
Text Label 4200 13350 0    50   ~ 0
hx0
Text Label 4200 13450 0    50   ~ 0
hx1
Text Label 4200 13550 0    50   ~ 0
hx2
Text Label 4200 13650 0    50   ~ 0
hx3
Text Label 5900 13350 0    50   ~ 0
hx4
Text Label 5900 13450 0    50   ~ 0
hx5
Text Label 5900 13550 0    50   ~ 0
hx6
Text Label 5900 13650 0    50   ~ 0
hx7
Text Label 7600 13350 0    50   ~ 0
hx8
Text Label 7600 13450 0    50   ~ 0
hx9
Text Label 3200 14150 2    50   ~ 0
pixel_clk
Text Label 4900 14150 2    50   ~ 0
pixel_clk
Text Label 6600 14150 2    50   ~ 0
pixel_clk
Text Label 3200 14350 2    50   ~ 0
~h_rst
Text Label 4900 14350 2    50   ~ 0
~h_rst
Text Label 6600 14350 2    50   ~ 0
~h_rst
NoConn ~ 7600 13550
NoConn ~ 7600 13650
$Comp
L 74xx:74LS161 U?
U 1 1 60110649
P 3700 16150
F 0 "U?" H 4100 15550 50  0000 C CNN
F 1 "74LS161" H 4100 15450 50  0000 C CNN
F 2 "" H 3700 16150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS161" H 3700 16150 50  0001 C CNN
	1    3700 16150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 6011064F
P 3700 16950
F 0 "#PWR?" H 3700 16700 50  0001 C CNN
F 1 "GND" H 3705 16777 50  0000 C CNN
F 2 "" H 3700 16950 50  0001 C CNN
F 3 "" H 3700 16950 50  0001 C CNN
	1    3700 16950
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 60110655
P 3700 15350
F 0 "#PWR?" H 3700 15200 50  0001 C CNN
F 1 "VCC" H 3715 15523 50  0000 C CNN
F 2 "" H 3700 15350 50  0001 C CNN
F 3 "" H 3700 15350 50  0001 C CNN
	1    3700 15350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 6011065B
P 3100 15800
F 0 "#PWR?" H 3100 15550 50  0001 C CNN
F 1 "GND" H 3105 15627 50  0000 C CNN
F 2 "" H 3100 15800 50  0001 C CNN
F 3 "" H 3100 15800 50  0001 C CNN
	1    3100 15800
	0    1    1    0   
$EndComp
Wire Wire Line
	3200 15650 3200 15750
Connection ~ 3200 15750
Wire Wire Line
	3200 15750 3200 15800
Connection ~ 3200 15850
Wire Wire Line
	3200 15850 3200 15950
Wire Wire Line
	3100 15800 3200 15800
Connection ~ 3200 15800
Wire Wire Line
	3200 15800 3200 15850
$Comp
L power:VCC #PWR?
U 1 1 60110669
P 3200 16150
F 0 "#PWR?" H 3200 16000 50  0001 C CNN
F 1 "VCC" V 3215 16323 50  0000 C CNN
F 2 "" H 3200 16150 50  0001 C CNN
F 3 "" H 3200 16150 50  0001 C CNN
	1    3200 16150
	0    -1   -1   0   
$EndComp
$Comp
L 74xx:74LS161 U?
U 1 1 60110675
P 5400 16150
F 0 "U?" H 5800 15550 50  0000 C CNN
F 1 "74LS161" H 5800 15450 50  0000 C CNN
F 2 "" H 5400 16150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS161" H 5400 16150 50  0001 C CNN
	1    5400 16150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 6011067B
P 5400 16950
F 0 "#PWR?" H 5400 16700 50  0001 C CNN
F 1 "GND" H 5405 16777 50  0000 C CNN
F 2 "" H 5400 16950 50  0001 C CNN
F 3 "" H 5400 16950 50  0001 C CNN
	1    5400 16950
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 60110681
P 5400 15350
F 0 "#PWR?" H 5400 15200 50  0001 C CNN
F 1 "VCC" H 5415 15523 50  0000 C CNN
F 2 "" H 5400 15350 50  0001 C CNN
F 3 "" H 5400 15350 50  0001 C CNN
	1    5400 15350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 60110687
P 4800 15800
F 0 "#PWR?" H 4800 15550 50  0001 C CNN
F 1 "GND" H 4805 15627 50  0000 C CNN
F 2 "" H 4800 15800 50  0001 C CNN
F 3 "" H 4800 15800 50  0001 C CNN
	1    4800 15800
	0    1    1    0   
$EndComp
Wire Wire Line
	4900 15650 4900 15750
Connection ~ 4900 15750
Wire Wire Line
	4900 15750 4900 15800
Connection ~ 4900 15850
Wire Wire Line
	4900 15850 4900 15950
Wire Wire Line
	4800 15800 4900 15800
Connection ~ 4900 15800
Wire Wire Line
	4900 15800 4900 15850
$Comp
L power:VCC #PWR?
U 1 1 60110695
P 4900 16150
F 0 "#PWR?" H 4900 16000 50  0001 C CNN
F 1 "VCC" V 4915 16323 50  0000 C CNN
F 2 "" H 4900 16150 50  0001 C CNN
F 3 "" H 4900 16150 50  0001 C CNN
	1    4900 16150
	0    -1   -1   0   
$EndComp
$Comp
L 74xx:74LS161 U?
U 1 1 601106A1
P 7100 16150
F 0 "U?" H 7500 15550 50  0000 C CNN
F 1 "74LS161" H 7500 15450 50  0000 C CNN
F 2 "" H 7100 16150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS161" H 7100 16150 50  0001 C CNN
	1    7100 16150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 601106A7
P 7100 16950
F 0 "#PWR?" H 7100 16700 50  0001 C CNN
F 1 "GND" H 7105 16777 50  0000 C CNN
F 2 "" H 7100 16950 50  0001 C CNN
F 3 "" H 7100 16950 50  0001 C CNN
	1    7100 16950
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 601106AD
P 7100 15350
F 0 "#PWR?" H 7100 15200 50  0001 C CNN
F 1 "VCC" H 7115 15523 50  0000 C CNN
F 2 "" H 7100 15350 50  0001 C CNN
F 3 "" H 7100 15350 50  0001 C CNN
	1    7100 15350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 601106B3
P 6500 15800
F 0 "#PWR?" H 6500 15550 50  0001 C CNN
F 1 "GND" H 6505 15627 50  0000 C CNN
F 2 "" H 6500 15800 50  0001 C CNN
F 3 "" H 6500 15800 50  0001 C CNN
	1    6500 15800
	0    1    1    0   
$EndComp
Wire Wire Line
	6600 15650 6600 15750
Connection ~ 6600 15750
Wire Wire Line
	6600 15750 6600 15800
Connection ~ 6600 15850
Wire Wire Line
	6600 15850 6600 15950
Wire Wire Line
	6500 15800 6600 15800
Connection ~ 6600 15800
Wire Wire Line
	6600 15800 6600 15850
$Comp
L power:VCC #PWR?
U 1 1 601106C1
P 6600 16150
F 0 "#PWR?" H 6600 16000 50  0001 C CNN
F 1 "VCC" V 6615 16323 50  0000 C CNN
F 2 "" H 6600 16150 50  0001 C CNN
F 3 "" H 6600 16150 50  0001 C CNN
	1    6600 16150
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4200 16150 4500 16150
Wire Wire Line
	4500 16150 4500 16350
Wire Wire Line
	4500 16350 4900 16350
Wire Wire Line
	5900 16150 6200 16150
Wire Wire Line
	6200 16150 6200 16350
Wire Wire Line
	6200 16350 6600 16350
NoConn ~ 7600 16150
$Comp
L power:VCC #PWR?
U 1 1 601106D4
P 3200 16350
F 0 "#PWR?" H 3200 16200 50  0001 C CNN
F 1 "VCC" V 3215 16523 50  0000 C CNN
F 2 "" H 3200 16350 50  0001 C CNN
F 3 "" H 3200 16350 50  0001 C CNN
	1    3200 16350
	0    -1   -1   0   
$EndComp
Text Label 3200 16450 2    50   ~ 0
pixel_clk
Text Label 4900 16450 2    50   ~ 0
pixel_clk
Text Label 6600 16450 2    50   ~ 0
pixel_clk
Text Label 3200 16650 2    50   ~ 0
~v_rst
Text Label 4900 16650 2    50   ~ 0
~v_rst
NoConn ~ 7600 15850
NoConn ~ 7600 15950
$Comp
L 74xx:74LS161 U?
U 1 1 6012E395
P 3700 18500
F 0 "U?" H 4100 17900 50  0000 C CNN
F 1 "74LS161" H 4100 17800 50  0000 C CNN
F 2 "" H 3700 18500 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS161" H 3700 18500 50  0001 C CNN
	1    3700 18500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 6012E39B
P 3700 19300
F 0 "#PWR?" H 3700 19050 50  0001 C CNN
F 1 "GND" H 3705 19127 50  0000 C CNN
F 2 "" H 3700 19300 50  0001 C CNN
F 3 "" H 3700 19300 50  0001 C CNN
	1    3700 19300
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 6012E3A1
P 3700 17700
F 0 "#PWR?" H 3700 17550 50  0001 C CNN
F 1 "VCC" H 3715 17873 50  0000 C CNN
F 2 "" H 3700 17700 50  0001 C CNN
F 3 "" H 3700 17700 50  0001 C CNN
	1    3700 17700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 6012E3A7
P 3100 18150
F 0 "#PWR?" H 3100 17900 50  0001 C CNN
F 1 "GND" H 3105 17977 50  0000 C CNN
F 2 "" H 3100 18150 50  0001 C CNN
F 3 "" H 3100 18150 50  0001 C CNN
	1    3100 18150
	0    1    1    0   
$EndComp
Wire Wire Line
	3200 18000 3200 18100
Connection ~ 3200 18100
Wire Wire Line
	3200 18100 3200 18150
Connection ~ 3200 18200
Wire Wire Line
	3200 18200 3200 18300
Wire Wire Line
	3100 18150 3200 18150
Connection ~ 3200 18150
Wire Wire Line
	3200 18150 3200 18200
$Comp
L power:VCC #PWR?
U 1 1 6012E3B5
P 3200 18500
F 0 "#PWR?" H 3200 18350 50  0001 C CNN
F 1 "VCC" V 3215 18673 50  0000 C CNN
F 2 "" H 3200 18500 50  0001 C CNN
F 3 "" H 3200 18500 50  0001 C CNN
	1    3200 18500
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 6012E3BB
P 3200 18600
F 0 "#PWR?" H 3200 18450 50  0001 C CNN
F 1 "VCC" V 3215 18773 50  0000 C CNN
F 2 "" H 3200 18600 50  0001 C CNN
F 3 "" H 3200 18600 50  0001 C CNN
	1    3200 18600
	0    -1   -1   0   
$EndComp
$Comp
L 74xx:74LS161 U?
U 1 1 6012E3C1
P 5400 18500
F 0 "U?" H 5800 17900 50  0000 C CNN
F 1 "74LS161" H 5800 17800 50  0000 C CNN
F 2 "" H 5400 18500 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS161" H 5400 18500 50  0001 C CNN
	1    5400 18500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 6012E3C7
P 5400 19300
F 0 "#PWR?" H 5400 19050 50  0001 C CNN
F 1 "GND" H 5405 19127 50  0000 C CNN
F 2 "" H 5400 19300 50  0001 C CNN
F 3 "" H 5400 19300 50  0001 C CNN
	1    5400 19300
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 6012E3CD
P 5400 17700
F 0 "#PWR?" H 5400 17550 50  0001 C CNN
F 1 "VCC" H 5415 17873 50  0000 C CNN
F 2 "" H 5400 17700 50  0001 C CNN
F 3 "" H 5400 17700 50  0001 C CNN
	1    5400 17700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 6012E3D3
P 4800 18150
F 0 "#PWR?" H 4800 17900 50  0001 C CNN
F 1 "GND" H 4805 17977 50  0000 C CNN
F 2 "" H 4800 18150 50  0001 C CNN
F 3 "" H 4800 18150 50  0001 C CNN
	1    4800 18150
	0    1    1    0   
$EndComp
Wire Wire Line
	4900 18000 4900 18100
Connection ~ 4900 18100
Wire Wire Line
	4900 18100 4900 18150
Connection ~ 4900 18200
Wire Wire Line
	4900 18200 4900 18300
Wire Wire Line
	4800 18150 4900 18150
Connection ~ 4900 18150
Wire Wire Line
	4900 18150 4900 18200
$Comp
L power:VCC #PWR?
U 1 1 6012E3E1
P 4900 18500
F 0 "#PWR?" H 4900 18350 50  0001 C CNN
F 1 "VCC" V 4915 18673 50  0000 C CNN
F 2 "" H 4900 18500 50  0001 C CNN
F 3 "" H 4900 18500 50  0001 C CNN
	1    4900 18500
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 6012E3E7
P 4900 18600
F 0 "#PWR?" H 4900 18450 50  0001 C CNN
F 1 "VCC" V 4915 18773 50  0000 C CNN
F 2 "" H 4900 18600 50  0001 C CNN
F 3 "" H 4900 18600 50  0001 C CNN
	1    4900 18600
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4200 18500 4500 18500
Wire Wire Line
	4500 18500 4500 18700
Wire Wire Line
	4500 18700 4900 18700
$Comp
L power:VCC #PWR?
U 1 1 6012E420
P 3200 18700
F 0 "#PWR?" H 3200 18550 50  0001 C CNN
F 1 "VCC" V 3215 18873 50  0000 C CNN
F 2 "" H 3200 18700 50  0001 C CNN
F 3 "" H 3200 18700 50  0001 C CNN
	1    3200 18700
	0    -1   -1   0   
$EndComp
Text Label 3200 18800 2    50   ~ 0
ccol_clk
Text Label 4900 18800 2    50   ~ 0
ccol_clk
Text Label 3200 19000 2    50   ~ 0
~ccol_rst
Text Label 4900 19000 2    50   ~ 0
~ccol_rst
Text Label 4200 15650 0    50   ~ 0
vy0
Text Label 4200 15750 0    50   ~ 0
vy1
Text Label 4200 15850 0    50   ~ 0
vy2
Text Label 4200 15950 0    50   ~ 0
vy3
Text Label 5900 15650 0    50   ~ 0
vy4
Text Label 5900 15750 0    50   ~ 0
vy5
Text Label 5900 15850 0    50   ~ 0
vy6
Text Label 5900 15950 0    50   ~ 0
vy7
Text Label 7600 15650 0    50   ~ 0
vy8
Text Label 7600 15750 0    50   ~ 0
vy9
Text Label 6600 16650 2    50   ~ 0
~v_rst
NoConn ~ 5900 18500
Text Label 4200 18000 0    50   ~ 0
ccol0
Text Label 4200 18100 0    50   ~ 0
ccol1
Text Label 4200 18200 0    50   ~ 0
ccol2
Text Label 4200 18300 0    50   ~ 0
ccol3
Text Label 5900 18000 0    50   ~ 0
ccol4
Text Label 5900 18100 0    50   ~ 0
ccol5
Text Label 5900 18200 0    50   ~ 0
ccol6
NoConn ~ 5900 18300
$Comp
L Oscillator:CXO_DIP8 X?
U 1 1 6022AE12
P 1600 13850
F 0 "X?" H 1850 13700 50  0000 L CNN
F 1 "MXO45HS-3C-25M1750 " H 1800 13600 50  0000 L CNN
F 2 "Oscillator:Oscillator_DIP-8" H 2050 13500 50  0001 C CNN
F 3 "http://cdn-reichelt.de/documents/datenblatt/B400/OSZI.pdf" H 1500 13850 50  0001 C CNN
	1    1600 13850
	1    0    0    -1  
$EndComp
NoConn ~ 1300 13850
$Comp
L power:GND #PWR?
U 1 1 60242521
P 1600 14150
F 0 "#PWR?" H 1600 13900 50  0001 C CNN
F 1 "GND" H 1605 13977 50  0000 C CNN
F 2 "" H 1600 14150 50  0001 C CNN
F 3 "" H 1600 14150 50  0001 C CNN
	1    1600 14150
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 60242B02
P 1600 13550
F 0 "#PWR?" H 1600 13400 50  0001 C CNN
F 1 "VCC" H 1615 13723 50  0000 C CNN
F 2 "" H 1600 13550 50  0001 C CNN
F 3 "" H 1600 13550 50  0001 C CNN
	1    1600 13550
	1    0    0    -1  
$EndComp
Text Label 1900 13850 0    50   ~ 0
pixel_clk
Text Label 3200 16250 2    50   ~ 0
v_cnt_ena
Text Label 4900 16250 2    50   ~ 0
v_cnt_ena
Text Label 6600 16250 2    50   ~ 0
v_cnt_ena
$Comp
L power:VCC #PWR?
U 1 1 60246556
P 6400 5900
F 0 "#PWR?" H 6400 5750 50  0001 C CNN
F 1 "VCC" H 6415 6073 50  0000 C CNN
F 2 "" H 6400 5900 50  0001 C CNN
F 3 "" H 6400 5900 50  0001 C CNN
	1    6400 5900
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 60246BEF
P 6400 9350
F 0 "#PWR?" H 6400 9200 50  0001 C CNN
F 1 "VCC" H 6415 9523 50  0000 C CNN
F 2 "" H 6400 9350 50  0001 C CNN
F 3 "" H 6400 9350 50  0001 C CNN
	1    6400 9350
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FD3C2BF
P 11450 5950
F 0 "#PWR?" H 11450 5700 50  0001 C CNN
F 1 "GND" V 11455 5777 50  0000 C CNN
F 2 "" H 11450 5950 50  0001 C CNN
F 3 "" H 11450 5950 50  0001 C CNN
	1    11450 5950
	0    1    1    0   
$EndComp
Text Label 18450 5550 0    50   ~ 0
color_out_i
Text Label 18450 5250 0    50   ~ 0
color_out_r
Text Label 18450 4950 0    50   ~ 0
color_out_g
Text Label 18450 4650 0    50   ~ 0
color_out_b
Wire Bus Line
	11050 5150 11050 5850
Wire Bus Line
	12750 7150 12750 8100
Wire Bus Line
	6150 1100 6150 2350
Wire Bus Line
	8600 1100 8600 2350
Wire Bus Line
	10450 1850 10450 7150
Wire Bus Line
	8000 7150 8000 8850
Wire Bus Line
	3850 4450 3850 12450
Wire Bus Line
	8000 1850 8000 5850
Wire Bus Line
	6050 4500 6050 10250
$EndSCHEMATC
