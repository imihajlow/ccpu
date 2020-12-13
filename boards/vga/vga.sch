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
L Mechanical:MountingHole H1
U 1 1 5FCF0826
P 700 650
F 0 "H1" H 800 696 50  0000 L CNN
F 1 "MountingHole" H 800 605 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 700 650 50  0001 C CNN
F 3 "~" H 700 650 50  0001 C CNN
	1    700  650 
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H4
U 1 1 5FCF0ADA
P 22300 700
F 0 "H4" H 22400 746 50  0000 L CNN
F 1 "MountingHole" H 22400 655 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 22300 700 50  0001 C CNN
F 3 "~" H 22300 700 50  0001 C CNN
	1    22300 700 
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H2
U 1 1 5FCF11E5
P 800 31300
F 0 "H2" H 900 31346 50  0000 L CNN
F 1 "MountingHole" H 900 31255 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 800 31300 50  0001 C CNN
F 3 "~" H 800 31300 50  0001 C CNN
	1    800  31300
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H3
U 1 1 5FCF189A
P 22150 31000
F 0 "H3" H 22250 31046 50  0000 L CNN
F 1 "MountingHole" H 22250 30955 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 22150 31000 50  0001 C CNN
F 3 "~" H 22150 31000 50  0001 C CNN
	1    22150 31000
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x20_Odd_Even J1
U 1 1 5FD0EDE0
P 1750 6050
F 0 "J1" H 1800 7167 50  0000 C CNN
F 1 "Conn_02x20_Odd_Even" H 1800 7076 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x20_P2.54mm_Horizontal" H 1750 6050 50  0001 C CNN
F 3 "~" H 1750 6050 50  0001 C CNN
	1    1750 6050
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR01
U 1 1 5FD14F11
P 1550 5150
F 0 "#PWR01" H 1550 5000 50  0001 C CNN
F 1 "VCC" V 1565 5277 50  0000 L CNN
F 2 "" H 1550 5150 50  0001 C CNN
F 3 "" H 1550 5150 50  0001 C CNN
	1    1550 5150
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR06
U 1 1 5FD157A1
P 2050 7050
F 0 "#PWR06" H 2050 6900 50  0001 C CNN
F 1 "VCC" V 2065 7178 50  0000 L CNN
F 2 "" H 2050 7050 50  0001 C CNN
F 3 "" H 2050 7050 50  0001 C CNN
	1    2050 7050
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR02
U 1 1 5FD16672
P 1550 7050
F 0 "#PWR02" H 1550 6800 50  0001 C CNN
F 1 "GND" V 1555 6922 50  0000 R CNN
F 2 "" H 1550 7050 50  0001 C CNN
F 3 "" H 1550 7050 50  0001 C CNN
	1    1550 7050
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR05
U 1 1 5FD16BED
P 2050 5150
F 0 "#PWR05" H 2050 4900 50  0001 C CNN
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
L missing:62256-TSOP U9
U 1 1 5FD1C056
P 7000 5450
F 0 "U9" H 7500 4450 50  0000 C CNN
F 1 "62256-TSOP" H 7550 4300 50  0000 C CNN
F 2 "Package_SO:TSOP-I-28_11.8x8mm_P0.55mm" H 7000 6300 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/1674430.pdf" H 7000 6300 50  0001 C CNN
	1    7000 5450
	1    0    0    -1  
$EndComp
$Comp
L missing:62256-TSOP U10
U 1 1 5FD2039D
P 7000 8900
F 0 "U10" H 7500 7900 50  0000 C CNN
F 1 "62256-TSOP" H 7550 7750 50  0000 C CNN
F 2 "Package_SO:TSOP-I-28_11.8x8mm_P0.55mm" H 7000 9750 50  0001 C CNN
F 3 "http://www.farnell.com/datasheets/1674430.pdf" H 7000 9750 50  0001 C CNN
	1    7000 8900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR046
U 1 1 5FD27BF6
P 7000 6550
F 0 "#PWR046" H 7000 6300 50  0001 C CNN
F 1 "GND" H 7005 6377 50  0000 C CNN
F 2 "" H 7000 6550 50  0001 C CNN
F 3 "" H 7000 6550 50  0001 C CNN
	1    7000 6550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR048
U 1 1 5FD28144
P 7000 10000
F 0 "#PWR048" H 7000 9750 50  0001 C CNN
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
L power:VCC #PWR047
U 1 1 5FD32974
P 7000 7850
F 0 "#PWR047" H 7000 7700 50  0001 C CNN
F 1 "VCC" H 7015 8023 50  0000 C CNN
F 2 "" H 7000 7850 50  0001 C CNN
F 3 "" H 7000 7850 50  0001 C CNN
	1    7000 7850
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR045
U 1 1 5FD3383A
P 7000 4400
F 0 "#PWR045" H 7000 4250 50  0001 C CNN
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
L 74xx:74HC244 U8
U 1 1 5FD4FC71
P 7000 2250
F 0 "U8" H 7400 1650 50  0000 C CNN
F 1 "SN74LV244APW" H 7400 1550 50  0000 C CNN
F 2 "Package_SO:TSSOP-20_4.4x6.5mm_P0.65mm" H 7000 2250 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv244a.pdf" H 7000 2250 50  0001 C CNN
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
L power:VCC #PWR043
U 1 1 5FD551D1
P 7000 1450
F 0 "#PWR043" H 7000 1300 50  0001 C CNN
F 1 "VCC" H 7015 1623 50  0000 C CNN
F 2 "" H 7000 1450 50  0001 C CNN
F 3 "" H 7000 1450 50  0001 C CNN
	1    7000 1450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR044
U 1 1 5FD55F10
P 7000 3050
F 0 "#PWR044" H 7000 2800 50  0001 C CNN
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
L 74xx:74HC244 U13
U 1 1 5FCEA5B3
P 9450 2250
F 0 "U13" H 9850 1650 50  0000 C CNN
F 1 "SN74LV244APW" H 9850 1550 50  0000 C CNN
F 2 "Package_SO:TSSOP-20_4.4x6.5mm_P0.65mm" H 9450 2250 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv244a.pdf" H 9450 2250 50  0001 C CNN
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
L power:VCC #PWR053
U 1 1 5FD0C1AF
P 9450 1450
F 0 "#PWR053" H 9450 1300 50  0001 C CNN
F 1 "VCC" H 9465 1623 50  0000 C CNN
F 2 "" H 9450 1450 50  0001 C CNN
F 3 "" H 9450 1450 50  0001 C CNN
	1    9450 1450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR054
U 1 1 5FD0C6AD
P 9450 3050
F 0 "#PWR054" H 9450 2800 50  0001 C CNN
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
L missing:AT28C256-PLCC32 U17
U 1 1 5FD15217
P 11950 5550
F 0 "U17" H 12400 4600 50  0000 C CNN
F 1 "AT28C256-PLCC32" H 12400 4450 50  0000 C CNN
F 2 "missing:PLCC-32_SMD_Socket" H 12200 5900 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/doc0006.pdf" H 12200 5900 50  0001 C CNN
	1    11950 5550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR060
U 1 1 5FD189C4
P 11950 6650
F 0 "#PWR060" H 11950 6400 50  0001 C CNN
F 1 "GND" H 11955 6477 50  0000 C CNN
F 2 "" H 11950 6650 50  0001 C CNN
F 3 "" H 11950 6650 50  0001 C CNN
	1    11950 6650
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR059
U 1 1 5FD18EC1
P 11950 4450
F 0 "#PWR059" H 11950 4300 50  0001 C CNN
F 1 "VCC" H 11965 4623 50  0000 C CNN
F 2 "" H 11950 4450 50  0001 C CNN
F 3 "" H 11950 4450 50  0001 C CNN
	1    11950 4450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR058
U 1 1 5FD1982F
P 11550 6450
F 0 "#PWR058" H 11550 6200 50  0001 C CNN
F 1 "GND" V 11555 6277 50  0000 C CNN
F 2 "" H 11550 6450 50  0001 C CNN
F 3 "" H 11550 6450 50  0001 C CNN
	1    11550 6450
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR056
U 1 1 5FD19FDE
P 11550 6250
F 0 "#PWR056" H 11550 6000 50  0001 C CNN
F 1 "GND" V 11555 6077 50  0000 C CNN
F 2 "" H 11550 6250 50  0001 C CNN
F 3 "" H 11550 6250 50  0001 C CNN
	1    11550 6250
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR057
U 1 1 5FD1A58F
P 11550 6350
F 0 "#PWR057" H 11550 6200 50  0001 C CNN
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
L 74xx:74HC273 U18
U 1 1 5FD56F7F
P 13750 5150
F 0 "U18" H 14150 4550 50  0000 C CNN
F 1 "SN74LV273APW" H 14150 4450 50  0000 C CNN
F 2 "Package_SO:TSSOP-20_4.4x6.5mm_P0.65mm" H 13750 5150 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv273a.pdf?" H 13750 5150 50  0001 C CNN
	1    13750 5150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR062
U 1 1 5FD59AF2
P 13750 5950
F 0 "#PWR062" H 13750 5700 50  0001 C CNN
F 1 "GND" H 13755 5777 50  0000 C CNN
F 2 "" H 13750 5950 50  0001 C CNN
F 3 "" H 13750 5950 50  0001 C CNN
	1    13750 5950
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR061
U 1 1 5FD5A15D
P 13750 4350
F 0 "#PWR061" H 13750 4200 50  0001 C CNN
F 1 "VCC" H 13765 4523 50  0000 C CNN
F 2 "" H 13750 4350 50  0001 C CNN
F 3 "" H 13750 4350 50  0001 C CNN
	1    13750 4350
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC273 U19
U 1 1 5FD60D8B
P 13750 7800
F 0 "U19" H 14150 7200 50  0000 C CNN
F 1 "SN74LV273APW" H 14150 7100 50  0000 C CNN
F 2 "Package_SO:TSSOP-20_4.4x6.5mm_P0.65mm" H 13750 7800 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv273a.pdf?" H 13750 7800 50  0001 C CNN
	1    13750 7800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR064
U 1 1 5FD60D91
P 13750 8600
F 0 "#PWR064" H 13750 8350 50  0001 C CNN
F 1 "GND" H 13755 8427 50  0000 C CNN
F 2 "" H 13750 8600 50  0001 C CNN
F 3 "" H 13750 8600 50  0001 C CNN
	1    13750 8600
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR063
U 1 1 5FD60D97
P 13750 7000
F 0 "#PWR063" H 13750 6850 50  0001 C CNN
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
L 74xx:74LS157 U3
U 1 1 5FDA1050
P 4850 5150
F 0 "U3" H 5200 4300 50  0000 C CNN
F 1 "SN74LV157APW" H 5200 4200 50  0000 C CNN
F 2 "Package_SO:TSSOP-16_4.4x5mm_P0.65mm" H 4850 5150 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv157a.pdf" H 4850 5150 50  0001 C CNN
	1    4850 5150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR024
U 1 1 5FDA47FB
P 4850 6150
F 0 "#PWR024" H 4850 5900 50  0001 C CNN
F 1 "GND" H 4855 5977 50  0000 C CNN
F 2 "" H 4850 6150 50  0001 C CNN
F 3 "" H 4850 6150 50  0001 C CNN
	1    4850 6150
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR023
U 1 1 5FDA4BE1
P 4850 4250
F 0 "#PWR023" H 4850 4100 50  0001 C CNN
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
L 74xx:74LS157 U4
U 1 1 5FDCF974
P 4850 7500
F 0 "U4" H 5200 6650 50  0000 C CNN
F 1 "SN74LV157APW" H 5200 6550 50  0000 C CNN
F 2 "Package_SO:TSSOP-16_4.4x5mm_P0.65mm" H 4850 7500 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv157a.pdf" H 4850 7500 50  0001 C CNN
	1    4850 7500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR026
U 1 1 5FDCF97A
P 4850 8500
F 0 "#PWR026" H 4850 8250 50  0001 C CNN
F 1 "GND" H 4855 8327 50  0000 C CNN
F 2 "" H 4850 8500 50  0001 C CNN
F 3 "" H 4850 8500 50  0001 C CNN
	1    4850 8500
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR025
U 1 1 5FDCF980
P 4850 6600
F 0 "#PWR025" H 4850 6450 50  0001 C CNN
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
L 74xx:74LS157 U5
U 1 1 5FDD802B
P 4850 9850
F 0 "U5" H 5200 9000 50  0000 C CNN
F 1 "SN74LV157APW" H 5200 8900 50  0000 C CNN
F 2 "Package_SO:TSSOP-16_4.4x5mm_P0.65mm" H 4850 9850 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv157a.pdf" H 4850 9850 50  0001 C CNN
	1    4850 9850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR028
U 1 1 5FDD8031
P 4850 10850
F 0 "#PWR028" H 4850 10600 50  0001 C CNN
F 1 "GND" H 4855 10677 50  0000 C CNN
F 2 "" H 4850 10850 50  0001 C CNN
F 3 "" H 4850 10850 50  0001 C CNN
	1    4850 10850
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR027
U 1 1 5FDD8037
P 4850 8950
F 0 "#PWR027" H 4850 8800 50  0001 C CNN
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
hx3
Text Label 3050 11050 2    50   ~ 0
hx4
Text Label 3050 11150 2    50   ~ 0
hx5
Text Label 3050 11250 2    50   ~ 0
hx6
Text Label 3050 11350 2    50   ~ 0
hx7
Text Label 3050 11450 2    50   ~ 0
hx8
Text Label 3050 11550 2    50   ~ 0
hx9
$Comp
L power:GND #PWR018
U 1 1 5FE9ACC4
P 4350 5850
F 0 "#PWR018" H 4350 5600 50  0001 C CNN
F 1 "GND" H 4355 5677 50  0000 C CNN
F 2 "" H 4350 5850 50  0001 C CNN
F 3 "" H 4350 5850 50  0001 C CNN
	1    4350 5850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR019
U 1 1 5FE9B011
P 4350 8200
F 0 "#PWR019" H 4350 7950 50  0001 C CNN
F 1 "GND" H 4355 8027 50  0000 C CNN
F 2 "" H 4350 8200 50  0001 C CNN
F 3 "" H 4350 8200 50  0001 C CNN
	1    4350 8200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR020
U 1 1 5FE9B693
P 4350 10550
F 0 "#PWR020" H 4350 10300 50  0001 C CNN
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
Connection ~ 13000 8200
Text Label 13000 8600 3    50   ~ 0
buf_clk
$Comp
L 74xx:74LS151 U20
U 1 1 5FF79203
P 15850 5250
F 0 "U20" H 16250 4500 50  0000 C CNN
F 1 "CD74AC151M96" H 16200 4350 50  0000 C CNN
F 2 "Package_SO:SOIC-16_3.9x9.9mm_P1.27mm" H 15850 5250 50  0001 C CNN
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
L power:GND #PWR067
U 1 1 6000AF94
P 15850 6250
F 0 "#PWR067" H 15850 6000 50  0001 C CNN
F 1 "GND" H 15855 6077 50  0000 C CNN
F 2 "" H 15850 6250 50  0001 C CNN
F 3 "" H 15850 6250 50  0001 C CNN
	1    15850 6250
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR066
U 1 1 6000B347
P 15850 4350
F 0 "#PWR066" H 15850 4200 50  0001 C CNN
F 1 "VCC" H 15865 4523 50  0000 C CNN
F 2 "" H 15850 4350 50  0001 C CNN
F 3 "" H 15850 4350 50  0001 C CNN
	1    15850 4350
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS157 U21
U 1 1 6000BE47
P 17950 5250
F 0 "U21" H 18300 4400 50  0000 C CNN
F 1 "SN74LV157APW" H 18300 4300 50  0000 C CNN
F 2 "Package_SO:TSSOP-16_4.4x5mm_P0.65mm" H 17950 5250 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv157a.pdf" H 17950 5250 50  0001 C CNN
	1    17950 5250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR069
U 1 1 6000EF9E
P 17950 6250
F 0 "#PWR069" H 17950 6000 50  0001 C CNN
F 1 "GND" H 17955 6077 50  0000 C CNN
F 2 "" H 17950 6250 50  0001 C CNN
F 3 "" H 17950 6250 50  0001 C CNN
	1    17950 6250
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR068
U 1 1 6000F3B7
P 17950 4350
F 0 "#PWR068" H 17950 4200 50  0001 C CNN
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
L power:GND #PWR065
U 1 1 60039A1B
P 15350 5950
F 0 "#PWR065" H 15350 5700 50  0001 C CNN
F 1 "GND" H 15355 5777 50  0000 C CNN
F 2 "" H 15350 5950 50  0001 C CNN
F 3 "" H 15350 5950 50  0001 C CNN
	1    15350 5950
	0    1    1    0   
$EndComp
Wire Wire Line
	16350 4650 16700 4650
Wire Wire Line
	16700 5850 17450 5850
Text Label 16700 4650 2    50   ~ 0
pixel_out
$Comp
L 74xx:74LS161 U1
U 1 1 6004D240
P 3700 13850
F 0 "U1" H 4100 13250 50  0000 C CNN
F 1 "SN74LV161APW" H 4100 13150 50  0000 C CNN
F 2 "Package_SO:TSSOP-16_4.4x5mm_P0.65mm" H 3700 13850 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv161a.pdf" H 3700 13850 50  0001 C CNN
	1    3700 13850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR015
U 1 1 60053D63
P 3700 14650
F 0 "#PWR015" H 3700 14400 50  0001 C CNN
F 1 "GND" H 3705 14477 50  0000 C CNN
F 2 "" H 3700 14650 50  0001 C CNN
F 3 "" H 3700 14650 50  0001 C CNN
	1    3700 14650
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR014
U 1 1 600547BD
P 3700 13050
F 0 "#PWR014" H 3700 12900 50  0001 C CNN
F 1 "VCC" H 3715 13223 50  0000 C CNN
F 2 "" H 3700 13050 50  0001 C CNN
F 3 "" H 3700 13050 50  0001 C CNN
	1    3700 13050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR07
U 1 1 60055037
P 3100 13500
F 0 "#PWR07" H 3100 13250 50  0001 C CNN
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
L power:VCC #PWR09
U 1 1 600764C8
P 3200 13850
F 0 "#PWR09" H 3200 13700 50  0001 C CNN
F 1 "VCC" V 3215 14023 50  0000 C CNN
F 2 "" H 3200 13850 50  0001 C CNN
F 3 "" H 3200 13850 50  0001 C CNN
	1    3200 13850
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR010
U 1 1 600772B8
P 3200 13950
F 0 "#PWR010" H 3200 13800 50  0001 C CNN
F 1 "VCC" V 3215 14123 50  0000 C CNN
F 2 "" H 3200 13950 50  0001 C CNN
F 3 "" H 3200 13950 50  0001 C CNN
	1    3200 13950
	0    -1   -1   0   
$EndComp
$Comp
L 74xx:74LS161 U6
U 1 1 6007D21B
P 5400 13850
F 0 "U6" H 5800 13250 50  0000 C CNN
F 1 "SN74LV161APW" H 5800 13150 50  0000 C CNN
F 2 "Package_SO:TSSOP-16_4.4x5mm_P0.65mm" H 5400 13850 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv161a.pdf" H 5400 13850 50  0001 C CNN
	1    5400 13850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR033
U 1 1 6007D221
P 5400 14650
F 0 "#PWR033" H 5400 14400 50  0001 C CNN
F 1 "GND" H 5405 14477 50  0000 C CNN
F 2 "" H 5400 14650 50  0001 C CNN
F 3 "" H 5400 14650 50  0001 C CNN
	1    5400 14650
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR032
U 1 1 6007D227
P 5400 13050
F 0 "#PWR032" H 5400 12900 50  0001 C CNN
F 1 "VCC" H 5415 13223 50  0000 C CNN
F 2 "" H 5400 13050 50  0001 C CNN
F 3 "" H 5400 13050 50  0001 C CNN
	1    5400 13050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR021
U 1 1 6007D22D
P 4800 13500
F 0 "#PWR021" H 4800 13250 50  0001 C CNN
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
L power:VCC #PWR029
U 1 1 6007D23B
P 4900 13850
F 0 "#PWR029" H 4900 13700 50  0001 C CNN
F 1 "VCC" V 4915 14023 50  0000 C CNN
F 2 "" H 4900 13850 50  0001 C CNN
F 3 "" H 4900 13850 50  0001 C CNN
	1    4900 13850
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR030
U 1 1 6007D241
P 4900 13950
F 0 "#PWR030" H 4900 13800 50  0001 C CNN
F 1 "VCC" V 4915 14123 50  0000 C CNN
F 2 "" H 4900 13950 50  0001 C CNN
F 3 "" H 4900 13950 50  0001 C CNN
	1    4900 13950
	0    -1   -1   0   
$EndComp
$Comp
L 74xx:74LS161 U11
U 1 1 6008F72C
P 7100 13850
F 0 "U11" H 7500 13250 50  0000 C CNN
F 1 "SN74LV161APW" H 7500 13150 50  0000 C CNN
F 2 "Package_SO:TSSOP-16_4.4x5mm_P0.65mm" H 7100 13850 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv161a.pdf" H 7100 13850 50  0001 C CNN
	1    7100 13850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR050
U 1 1 6008F732
P 7100 14650
F 0 "#PWR050" H 7100 14400 50  0001 C CNN
F 1 "GND" H 7105 14477 50  0000 C CNN
F 2 "" H 7100 14650 50  0001 C CNN
F 3 "" H 7100 14650 50  0001 C CNN
	1    7100 14650
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR049
U 1 1 6008F738
P 7100 13050
F 0 "#PWR049" H 7100 12900 50  0001 C CNN
F 1 "VCC" H 7115 13223 50  0000 C CNN
F 2 "" H 7100 13050 50  0001 C CNN
F 3 "" H 7100 13050 50  0001 C CNN
	1    7100 13050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR038
U 1 1 6008F73E
P 6500 13500
F 0 "#PWR038" H 6500 13250 50  0001 C CNN
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
L power:VCC #PWR040
U 1 1 6008F74C
P 6600 13850
F 0 "#PWR040" H 6600 13700 50  0001 C CNN
F 1 "VCC" V 6615 14023 50  0000 C CNN
F 2 "" H 6600 13850 50  0001 C CNN
F 3 "" H 6600 13850 50  0001 C CNN
	1    6600 13850
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR041
U 1 1 6008F752
P 6600 13950
F 0 "#PWR041" H 6600 13800 50  0001 C CNN
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
L power:VCC #PWR011
U 1 1 600D63C5
P 3200 14050
F 0 "#PWR011" H 3200 13900 50  0001 C CNN
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
L 74xx:74LS161 U2
U 1 1 60110649
P 3700 16150
F 0 "U2" H 4100 15550 50  0000 C CNN
F 1 "SN74LV161APW" H 4100 15450 50  0000 C CNN
F 2 "Package_SO:TSSOP-16_4.4x5mm_P0.65mm" H 3700 16150 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv161a.pdf" H 3700 16150 50  0001 C CNN
	1    3700 16150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR017
U 1 1 6011064F
P 3700 16950
F 0 "#PWR017" H 3700 16700 50  0001 C CNN
F 1 "GND" H 3705 16777 50  0000 C CNN
F 2 "" H 3700 16950 50  0001 C CNN
F 3 "" H 3700 16950 50  0001 C CNN
	1    3700 16950
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR016
U 1 1 60110655
P 3700 15350
F 0 "#PWR016" H 3700 15200 50  0001 C CNN
F 1 "VCC" H 3715 15523 50  0000 C CNN
F 2 "" H 3700 15350 50  0001 C CNN
F 3 "" H 3700 15350 50  0001 C CNN
	1    3700 15350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR08
U 1 1 6011065B
P 3100 15800
F 0 "#PWR08" H 3100 15550 50  0001 C CNN
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
L power:VCC #PWR012
U 1 1 60110669
P 3200 16150
F 0 "#PWR012" H 3200 16000 50  0001 C CNN
F 1 "VCC" V 3215 16323 50  0000 C CNN
F 2 "" H 3200 16150 50  0001 C CNN
F 3 "" H 3200 16150 50  0001 C CNN
	1    3200 16150
	0    -1   -1   0   
$EndComp
$Comp
L 74xx:74LS161 U7
U 1 1 60110675
P 5400 16150
F 0 "U7" H 5800 15550 50  0000 C CNN
F 1 "SN74LV161APW" H 5800 15450 50  0000 C CNN
F 2 "Package_SO:TSSOP-16_4.4x5mm_P0.65mm" H 5400 16150 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv161a.pdf" H 5400 16150 50  0001 C CNN
	1    5400 16150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR035
U 1 1 6011067B
P 5400 16950
F 0 "#PWR035" H 5400 16700 50  0001 C CNN
F 1 "GND" H 5405 16777 50  0000 C CNN
F 2 "" H 5400 16950 50  0001 C CNN
F 3 "" H 5400 16950 50  0001 C CNN
	1    5400 16950
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR034
U 1 1 60110681
P 5400 15350
F 0 "#PWR034" H 5400 15200 50  0001 C CNN
F 1 "VCC" H 5415 15523 50  0000 C CNN
F 2 "" H 5400 15350 50  0001 C CNN
F 3 "" H 5400 15350 50  0001 C CNN
	1    5400 15350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR022
U 1 1 60110687
P 4800 15800
F 0 "#PWR022" H 4800 15550 50  0001 C CNN
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
L power:VCC #PWR031
U 1 1 60110695
P 4900 16150
F 0 "#PWR031" H 4900 16000 50  0001 C CNN
F 1 "VCC" V 4915 16323 50  0000 C CNN
F 2 "" H 4900 16150 50  0001 C CNN
F 3 "" H 4900 16150 50  0001 C CNN
	1    4900 16150
	0    -1   -1   0   
$EndComp
$Comp
L 74xx:74LS161 U12
U 1 1 601106A1
P 7100 16150
F 0 "U12" H 7500 15550 50  0000 C CNN
F 1 "SN74LV161APW" H 7500 15450 50  0000 C CNN
F 2 "Package_SO:TSSOP-16_4.4x5mm_P0.65mm" H 7100 16150 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv161a.pdf" H 7100 16150 50  0001 C CNN
	1    7100 16150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR052
U 1 1 601106A7
P 7100 16950
F 0 "#PWR052" H 7100 16700 50  0001 C CNN
F 1 "GND" H 7105 16777 50  0000 C CNN
F 2 "" H 7100 16950 50  0001 C CNN
F 3 "" H 7100 16950 50  0001 C CNN
	1    7100 16950
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR051
U 1 1 601106AD
P 7100 15350
F 0 "#PWR051" H 7100 15200 50  0001 C CNN
F 1 "VCC" H 7115 15523 50  0000 C CNN
F 2 "" H 7100 15350 50  0001 C CNN
F 3 "" H 7100 15350 50  0001 C CNN
	1    7100 15350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR039
U 1 1 601106B3
P 6500 15800
F 0 "#PWR039" H 6500 15550 50  0001 C CNN
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
L power:VCC #PWR042
U 1 1 601106C1
P 6600 16150
F 0 "#PWR042" H 6600 16000 50  0001 C CNN
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
L power:VCC #PWR013
U 1 1 601106D4
P 3200 16350
F 0 "#PWR013" H 3200 16200 50  0001 C CNN
F 1 "VCC" V 3215 16523 50  0000 C CNN
F 2 "" H 3200 16350 50  0001 C CNN
F 3 "" H 3200 16350 50  0001 C CNN
	1    3200 16350
	0    -1   -1   0   
$EndComp
Text Label 3200 16450 2    50   ~ 0
v_clk
Text Label 4900 16450 2    50   ~ 0
v_clk
Text Label 6600 16450 2    50   ~ 0
v_clk
Text Label 3200 16650 2    50   ~ 0
~v_rst
Text Label 4900 16650 2    50   ~ 0
~v_rst
NoConn ~ 7600 15850
NoConn ~ 7600 15950
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
$Comp
L Oscillator:CXO_DIP8 X1
U 1 1 6022AE12
P 1600 13850
F 0 "X1" H 1850 13700 50  0000 L CNN
F 1 "MXO45HS-3C-25M1750 " H 1800 13600 50  0000 L CNN
F 2 "Oscillator:Oscillator_DIP-8" H 2050 13500 50  0001 C CNN
F 3 "http://cdn-reichelt.de/documents/datenblatt/B400/OSZI.pdf" H 1500 13850 50  0001 C CNN
	1    1600 13850
	1    0    0    -1  
$EndComp
NoConn ~ 1300 13850
$Comp
L power:GND #PWR04
U 1 1 60242521
P 1600 14150
F 0 "#PWR04" H 1600 13900 50  0001 C CNN
F 1 "GND" H 1605 13977 50  0000 C CNN
F 2 "" H 1600 14150 50  0001 C CNN
F 3 "" H 1600 14150 50  0001 C CNN
	1    1600 14150
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR03
U 1 1 60242B02
P 1600 13550
F 0 "#PWR03" H 1600 13400 50  0001 C CNN
F 1 "VCC" H 1615 13723 50  0000 C CNN
F 2 "" H 1600 13550 50  0001 C CNN
F 3 "" H 1600 13550 50  0001 C CNN
	1    1600 13550
	1    0    0    -1  
$EndComp
Text Label 1900 13850 0    50   ~ 0
pixel_clk
$Comp
L power:VCC #PWR036
U 1 1 60246556
P 6400 5900
F 0 "#PWR036" H 6400 5750 50  0001 C CNN
F 1 "VCC" H 6415 6073 50  0000 C CNN
F 2 "" H 6400 5900 50  0001 C CNN
F 3 "" H 6400 5900 50  0001 C CNN
	1    6400 5900
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR037
U 1 1 60246BEF
P 6400 9350
F 0 "#PWR037" H 6400 9200 50  0001 C CNN
F 1 "VCC" H 6415 9523 50  0000 C CNN
F 2 "" H 6400 9350 50  0001 C CNN
F 3 "" H 6400 9350 50  0001 C CNN
	1    6400 9350
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR055
U 1 1 5FD3C2BF
P 11450 5950
F 0 "#PWR055" H 11450 5700 50  0001 C CNN
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
$Comp
L 74xx:74LS20 U14
U 1 1 5FD29DA6
P 11950 11050
F 0 "U14" H 11950 11425 50  0000 C CNN
F 1 "SN74LV20APW" H 11950 11334 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 11950 11050 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv20a.pdf" H 11950 11050 50  0001 C CNN
	1    11950 11050
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS20 U14
U 2 1 5FD2B747
P 14800 10950
F 0 "U14" H 14800 11325 50  0000 C CNN
F 1 "SN74LV20APW" H 14800 11234 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 14800 10950 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv20a.pdf" H 14800 10950 50  0001 C CNN
	2    14800 10950
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS20 U14
U 3 1 5FD2D7B5
P 9950 16150
F 0 "U14" H 10180 16196 50  0000 L CNN
F 1 "SN74LV20APW" H 10180 16105 50  0000 L CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 9950 16150 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv20a.pdf" H 9950 16150 50  0001 C CNN
	3    9950 16150
	1    0    0    -1  
$EndComp
Text Label 10150 10800 2    50   ~ 0
hx6
Text Label 10150 10900 2    50   ~ 0
hx5
Text Label 10150 11000 2    50   ~ 0
hx4
Text Label 13050 11050 0    50   ~ 0
hsync_out
$Comp
L 74xx:74LS32 U15
U 3 1 5FD56C92
P 10450 12600
F 0 "U15" H 10450 12925 50  0000 C CNN
F 1 "74LV32APWJ" H 10450 12834 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 10450 12600 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/916/74LV32A-1597772.pdf" H 10450 12600 50  0001 C CNN
	3    10450 12600
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U15
U 5 1 5FD5A30B
P 11100 16150
F 0 "U15" H 11330 16196 50  0000 L CNN
F 1 "74LV32APWJ" H 11330 16105 50  0000 L CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 11100 16150 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/916/74LV32A-1597772.pdf" H 11100 16150 50  0001 C CNN
	5    11100 16150
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U15
U 4 1 5FD5D326
P 19000 14300
F 0 "U15" H 19000 14625 50  0000 C CNN
F 1 "74LV32APWJ" H 19000 14534 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 19000 14300 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/916/74LV32A-1597772.pdf" H 19000 14300 50  0001 C CNN
	4    19000 14300
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U16
U 1 1 5FDABCEF
P 17600 19800
F 0 "U16" H 17600 20125 50  0000 C CNN
F 1 "74LV08APWJ" H 17600 20034 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 17600 19800 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/916/74LV08A-1598136.pdf" H 17600 19800 50  0001 C CNN
	1    17600 19800
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U16
U 2 1 5FDAD7C5
P 11200 12700
F 0 "U16" H 11200 13025 50  0000 C CNN
F 1 "74LV08APWJ" H 11200 12934 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 11200 12700 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/916/74LV08A-1598136.pdf" H 11200 12700 50  0001 C CNN
	2    11200 12700
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U16
U 3 1 5FDAF64C
P 15600 11050
F 0 "U16" H 15600 11375 50  0000 C CNN
F 1 "74LV08APWJ" H 15600 11284 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 15600 11050 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/916/74LV08A-1598136.pdf" H 15600 11050 50  0001 C CNN
	3    15600 11050
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U16
U 5 1 5FDB4188
P 12150 16150
F 0 "U16" H 12380 16196 50  0000 L CNN
F 1 "74LV08APWJ" H 12380 16105 50  0000 L CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 12150 16150 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/916/74LV08A-1598136.pdf" H 12150 16150 50  0001 C CNN
	5    12150 16150
	1    0    0    -1  
$EndComp
Text Label 10750 11750 2    50   ~ 0
hx4
$Comp
L 74xx:74LS08 U16
U 4 1 5FDB1ED3
P 15600 12150
F 0 "U16" H 15600 12475 50  0000 C CNN
F 1 "74LV08APWJ" H 15600 12384 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 15600 12150 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/916/74LV08A-1598136.pdf" H 15600 12150 50  0001 C CNN
	4    15600 12150
	1    0    0    -1  
$EndComp
Text Label 10150 11650 2    50   ~ 0
hx5
Text Label 10150 11450 2    50   ~ 0
hx6
$Comp
L 74xx:74LS32 U15
U 2 1 5FD54259
P 11050 11650
F 0 "U15" H 11050 11975 50  0000 C CNN
F 1 "74LV32APWJ" H 11050 11884 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 11050 11650 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/916/74LV32A-1597772.pdf" H 11050 11650 50  0001 C CNN
	2    11050 11650
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U15
U 1 1 5FD51A44
P 10450 11550
F 0 "U15" H 10450 11875 50  0000 C CNN
F 1 "74LV32APWJ" H 10450 11784 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 10450 11550 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/916/74LV32A-1597772.pdf" H 10450 11550 50  0001 C CNN
	1    10450 11550
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS10 U22
U 1 1 5FE72215
P 10450 10900
F 0 "U22" H 10450 11225 50  0000 C CNN
F 1 "SN74LV10APW" H 10450 11134 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 10450 10900 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv10a.pdf" H 10450 10900 50  0001 C CNN
	1    10450 10900
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS10 U22
U 2 1 5FE75295
P 11250 13950
F 0 "U22" H 11250 14275 50  0000 C CNN
F 1 "SN74LV10APW" H 11250 14184 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 11250 13950 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv10a.pdf" H 11250 13950 50  0001 C CNN
	2    11250 13950
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS10 U22
U 3 1 5FE7897B
P 14800 12050
F 0 "U22" H 14800 12375 50  0000 C CNN
F 1 "SN74LV10APW" H 14800 12284 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 14800 12050 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv10a.pdf" H 14800 12050 50  0001 C CNN
	3    14800 12050
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS10 U22
U 4 1 5FE7AE89
P 13100 16150
F 0 "U22" H 13330 16196 50  0000 L CNN
F 1 "SN74LV10APW" H 13330 16105 50  0000 L CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 13100 16150 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv10a.pdf" H 13100 16150 50  0001 C CNN
	4    13100 16150
	1    0    0    -1  
$EndComp
Wire Wire Line
	10750 10900 11650 10900
Wire Wire Line
	11350 11650 11500 11650
Wire Wire Line
	11500 11650 11500 11200
Wire Wire Line
	11500 11200 11650 11200
Text Label 11500 11200 3    50   ~ 0
hx_or_654
Text Label 11650 11000 2    50   ~ 0
hx9
Text Label 11650 11100 2    50   ~ 0
hx7
$Comp
L 74xx:74LS74 U23
U 1 1 5FEE1857
P 12750 11150
F 0 "U23" H 13050 10950 50  0000 C CNN
F 1 "SN74LV74APW" H 13100 10850 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 12750 11150 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv74a.pdf" H 12750 11150 50  0001 C CNN
	1    12750 11150
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS74 U23
U 2 1 5FEE34FB
P 12750 12900
F 0 "U23" H 13000 12600 50  0000 C CNN
F 1 "SN74LV74APW" H 13000 12500 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 12750 12900 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv74a.pdf" H 12750 12900 50  0001 C CNN
	2    12750 12900
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS74 U23
U 3 1 5FEE51D2
P 14150 16150
F 0 "U23" H 14380 16196 50  0000 L CNN
F 1 "SN74LV74APW" H 14380 16105 50  0000 L CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 14150 16150 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv74a.pdf" H 14150 16150 50  0001 C CNN
	3    14150 16150
	1    0    0    -1  
$EndComp
Wire Wire Line
	12250 11050 12450 11050
$Comp
L power:VCC #PWR070
U 1 1 5FEFC9CD
P 12750 11450
F 0 "#PWR070" H 12750 11300 50  0001 C CNN
F 1 "VCC" H 12765 11623 50  0000 C CNN
F 2 "" H 12750 11450 50  0001 C CNN
F 3 "" H 12750 11450 50  0001 C CNN
	1    12750 11450
	-1   0    0    1   
$EndComp
Text Label 13050 11250 0    50   ~ 0
~hsync_out
Text Label 12300 10250 0    50   ~ 0
~hx2
Text Label 10750 10900 0    50   ~ 0
hx_6_0_lt_1110000
Text Label 10750 11550 1    50   ~ 0
hx_or_65
Text Label 12750 10850 2    50   ~ 0
~rst
$Comp
L 74xx:74LS00 U24
U 1 1 5FF202D9
P 20500 13800
F 0 "U24" H 20500 14125 50  0000 C CNN
F 1 "SN74LV00APW" H 20500 14034 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 20500 13800 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv00a.pdf" H 20500 13800 50  0001 C CNN
	1    20500 13800
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS00 U24
U 2 1 5FF22D1F
P 18150 14200
F 0 "U24" H 18150 14525 50  0000 C CNN
F 1 "SN74LV00APW" H 18150 14434 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 18150 14200 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv00a.pdf" H 18150 14200 50  0001 C CNN
	2    18150 14200
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS00 U24
U 3 1 5FF26C74
P 18200 12950
F 0 "U24" H 18200 13275 50  0000 C CNN
F 1 "SN74LV00APW" H 18200 13184 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 18200 12950 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv00a.pdf" H 18200 12950 50  0001 C CNN
	3    18200 12950
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS00 U24
U 4 1 5FF2A47A
P 11950 10250
F 0 "U24" H 11950 10575 50  0000 C CNN
F 1 "SN74LV00APW" H 11950 10484 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 11950 10250 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv00a.pdf" H 11950 10250 50  0001 C CNN
	4    11950 10250
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS00 U24
U 5 1 5FF2D8A0
P 15200 16150
F 0 "U24" H 15430 16196 50  0000 L CNN
F 1 "SN74LV00APW" H 15430 16105 50  0000 L CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 15200 16150 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv00a.pdf" H 15200 16150 50  0001 C CNN
	5    15200 16150
	1    0    0    -1  
$EndComp
Text Label 10150 12500 2    50   ~ 0
hx8
Text Label 10150 12700 2    50   ~ 0
hx7
Wire Wire Line
	10750 12600 10900 12600
Text Label 10800 12600 1    50   ~ 0
hx_or_87
Text Label 10900 12800 2    50   ~ 0
hx9
Text Label 11500 12700 1    50   ~ 0
~hx_lt_640
Text Label 11450 12950 3    50   ~ 0
~vy_lt_480
Wire Wire Line
	12450 12800 12100 12800
Text Label 12750 12600 2    50   ~ 0
~rst
Text Label 12200 12800 1    50   ~ 0
~pixel_ena_int
Text Label 13050 12800 0    50   ~ 0
~pixel_ena
Text Label 13050 13000 0    50   ~ 0
pixel_ena
$Comp
L 74xx:74LS32 U25
U 1 1 5FF7A749
P 11250 14650
F 0 "U25" H 11250 14975 50  0000 C CNN
F 1 "74LV32APWJ" H 11250 14884 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 11250 14650 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/916/74LV32A-1597772.pdf" H 11250 14650 50  0001 C CNN
	1    11250 14650
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U25
U 2 1 5FF7BC2E
P 11850 14550
F 0 "U25" H 11850 14233 50  0000 C CNN
F 1 "74LV32APWJ" H 11850 14324 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 11850 14550 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/916/74LV32A-1597772.pdf" H 11850 14550 50  0001 C CNN
	2    11850 14550
	1    0    0    1   
$EndComp
$Comp
L 74xx:74LS32 U25
U 3 1 5FF7E121
P 19000 13150
F 0 "U25" H 19200 13000 50  0000 C CNN
F 1 "74LV32APWJ" H 19100 12900 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 19000 13150 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/916/74LV32A-1597772.pdf" H 19000 13150 50  0001 C CNN
	3    19000 13150
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U25
U 4 1 5FF80BF7
P 18200 13350
F 0 "U25" H 18200 13000 50  0000 C CNN
F 1 "74LV32APWJ" H 18250 13100 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 18200 13350 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/916/74LV32A-1597772.pdf" H 18200 13350 50  0001 C CNN
	4    18200 13350
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U25
U 5 1 5FF8285A
P 16200 16150
F 0 "U25" H 16430 16196 50  0000 L CNN
F 1 "74LV32APWJ" H 16430 16105 50  0000 L CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 16200 16150 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/916/74LV32A-1597772.pdf" H 16200 16150 50  0001 C CNN
	5    16200 16150
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS21 U26
U 1 1 5FFBBAB6
P 10350 13850
F 0 "U26" H 10350 14225 50  0000 C CNN
F 1 "SN74LV21APW" H 10350 14134 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 10350 13850 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv21a.pdf" H 10350 13850 50  0001 C CNN
	1    10350 13850
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS21 U26
U 2 1 5FFBEEF7
P 16050 12850
F 0 "U26" H 16050 13225 50  0000 C CNN
F 1 "SN74LV21APW" H 16050 13134 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 16050 12850 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv21a.pdf" H 16050 12850 50  0001 C CNN
	2    16050 12850
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS21 U26
U 3 1 5FFC14A1
P 17150 16150
F 0 "U26" H 17380 16196 50  0000 L CNN
F 1 "SN74LV21APW" H 17380 16105 50  0000 L CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 17150 16150 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv21a.pdf" H 17150 16150 50  0001 C CNN
	3    17150 16150
	1    0    0    -1  
$EndComp
Text Label 10050 13700 2    50   ~ 0
vy8
Text Label 10050 13800 2    50   ~ 0
vy7
Text Label 10050 13900 2    50   ~ 0
vy6
Text Label 10050 14000 2    50   ~ 0
vy5
Text Label 10950 13950 2    50   ~ 0
vy3
Text Label 10950 14050 2    50   ~ 0
vy1
Text Label 10750 13850 1    50   ~ 0
vy_8765
Text Label 10950 14550 2    50   ~ 0
vy4
Text Label 10950 14750 2    50   ~ 0
vy2
Wire Wire Line
	11550 13950 11550 14450
Text Label 11550 14000 3    50   ~ 0
vy_nand_3
Text Label 12150 14550 0    50   ~ 0
vsync_out
Wire Wire Line
	11500 12900 11450 12900
Wire Wire Line
	11450 13400 11400 13400
Text Label 10800 13300 2    50   ~ 0
vy9
Wire Wire Line
	10650 13850 10800 13850
Wire Wire Line
	10800 13500 10800 13850
Connection ~ 10800 13850
Wire Wire Line
	10800 13850 10950 13850
Wire Wire Line
	11450 12900 11450 13400
Text Label 14500 10800 2    50   ~ 0
vy9
Text Label 14500 10900 2    50   ~ 0
vy3
Text Label 14500 11000 2    50   ~ 0
vy2
Text Label 14500 11100 2    50   ~ 0
vy0
Text Label 15300 11150 2    50   ~ 0
~rst
Wire Wire Line
	15100 10950 15300 10950
Text Label 15900 11050 0    50   ~ 0
~v_rst
Text Label 15200 10950 1    50   ~ 0
vy_nand_9320
Text Label 14500 11950 2    50   ~ 0
hx9
Text Label 14500 12050 2    50   ~ 0
hx8
Text Label 14500 12150 2    50   ~ 0
hx5
Wire Wire Line
	15300 12050 15100 12050
Text Label 15300 12250 2    50   ~ 0
~rst
Text Label 15900 12150 0    50   ~ 0
~h_rst
$Comp
L power:VCC #PWR074
U 1 1 601F5AE2
P 6600 16250
F 0 "#PWR074" H 6600 16100 50  0001 C CNN
F 1 "VCC" V 6615 16423 50  0000 C CNN
F 2 "" H 6600 16250 50  0001 C CNN
F 3 "" H 6600 16250 50  0001 C CNN
	1    6600 16250
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR073
U 1 1 601F5DA1
P 4900 16250
F 0 "#PWR073" H 4900 16100 50  0001 C CNN
F 1 "VCC" V 4915 16423 50  0000 C CNN
F 2 "" H 4900 16250 50  0001 C CNN
F 3 "" H 4900 16250 50  0001 C CNN
	1    4900 16250
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR072
U 1 1 601F60DE
P 3200 16250
F 0 "#PWR072" H 3200 16100 50  0001 C CNN
F 1 "VCC" V 3215 16423 50  0000 C CNN
F 2 "" H 3200 16250 50  0001 C CNN
F 3 "" H 3200 16250 50  0001 C CNN
	1    3200 16250
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R1
U 1 1 6022A27C
P 13600 11250
F 0 "R1" V 13807 11250 50  0000 C CNN
F 1 "50" V 13716 11250 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 13530 11250 50  0001 C CNN
F 3 "~" H 13600 11250 50  0001 C CNN
	1    13600 11250
	0    -1   -1   0   
$EndComp
Wire Wire Line
	13450 11250 13050 11250
Text Label 13750 11250 0    50   ~ 0
v_clk
Text Label 14500 12750 2    50   ~ 0
a12
Text Label 14500 12650 2    50   ~ 0
a13
Text Label 15050 12700 0    50   ~ 0
a_13_xor_12
Wire Wire Line
	15750 12700 15050 12700
Text Label 15750 12800 2    50   ~ 0
a15
Text Label 15750 12900 2    50   ~ 0
a14
Text Label 15750 13000 2    50   ~ 0
ena
Text Label 16350 12850 0    50   ~ 0
ext_sel
$Comp
L Device:Q_PMOS_GSD Q1
U 1 1 5FD7375C
P 21800 13800
F 0 "Q1" H 22005 13754 50  0000 L CNN
F 1 "BSS84AK" H 22005 13845 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 22000 13900 50  0001 C CNN
F 3 "~" H 21800 13800 50  0001 C CNN
	1    21800 13800
	1    0    0    1   
$EndComp
$Comp
L power:VCC #PWR077
U 1 1 5FDA5A8E
P 21900 13600
F 0 "#PWR077" H 21900 13450 50  0001 C CNN
F 1 "VCC" H 21915 13773 50  0000 C CNN
F 2 "" H 21900 13600 50  0001 C CNN
F 3 "" H 21900 13600 50  0001 C CNN
	1    21900 13600
	1    0    0    -1  
$EndComp
Text Label 21900 14000 3    50   ~ 0
~rdy
Text Label 17900 13450 2    50   ~ 0
~we
Text Label 17900 13250 2    50   ~ 0
a12
Wire Wire Line
	18500 13350 18600 13350
Wire Wire Line
	18600 13350 18600 13250
Wire Wire Line
	18600 13250 18700 13250
Wire Wire Line
	18700 13050 18600 13050
Wire Wire Line
	18600 13050 18600 12950
Wire Wire Line
	18600 12950 18500 12950
Text Label 19300 13150 0    50   ~ 0
~text_ram_we
$Comp
L 74xx:74LS32 U28
U 1 1 5FE22FD1
P 11100 13400
F 0 "U28" H 11100 13725 50  0000 C CNN
F 1 "74LV32APWJ" H 11100 13634 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 11100 13400 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/916/74LV32A-1597772.pdf" H 11100 13400 50  0001 C CNN
	1    11100 13400
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U28
U 4 1 5FE24763
P 16050 14100
F 0 "U28" H 16050 14425 50  0000 C CNN
F 1 "74LV32APWJ" H 16050 14334 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 16050 14100 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/916/74LV32A-1597772.pdf" H 16050 14100 50  0001 C CNN
	4    16050 14100
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U28
U 3 1 5FE25CD1
P 16400 19800
F 0 "U28" H 16400 20125 50  0000 C CNN
F 1 "74LV32APWJ" H 16400 20034 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 16400 19800 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/916/74LV32A-1597772.pdf" H 16400 19800 50  0001 C CNN
	3    16400 19800
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U28
U 2 1 5FE27575
P 11800 12800
F 0 "U28" H 11800 13125 50  0000 C CNN
F 1 "74LV32APWJ" H 11800 13034 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 11800 12800 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/916/74LV32A-1597772.pdf" H 11800 12800 50  0001 C CNN
	2    11800 12800
	1    0    0    1   
$EndComp
$Comp
L 74xx:74LS32 U28
U 5 1 5FE29620
P 18200 16150
F 0 "U28" H 18430 16196 50  0000 L CNN
F 1 "74LV32APWJ" H 18430 16105 50  0000 L CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 18200 16150 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/916/74LV32A-1597772.pdf" H 18200 16150 50  0001 C CNN
	5    18200 16150
	1    0    0    -1  
$EndComp
Text Label 17850 14300 2    50   ~ 0
a12
Wire Wire Line
	18700 14200 18450 14200
Text Label 18700 14400 2    50   ~ 0
~we
Text Label 19300 14300 0    50   ~ 0
~color_ram_we
Wire Wire Line
	17900 12950 17900 12850
Wire Wire Line
	17900 13050 17900 12950
Connection ~ 17900 12950
$Comp
L 74xGxx:74LVC1G86 U27
U 1 1 5FF0AC09
P 14800 12700
F 0 "U27" H 14150 12600 50  0000 C CNN
F 1 "SN74AHC1G86DBVR" H 14150 12500 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-5" H 14800 12700 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74ahc1g86.pdf" H 14800 12700 50  0001 C CNN
	1    14800 12700
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG01
U 1 1 5FF1F77B
P 1600 19200
F 0 "#FLG01" H 1600 19275 50  0001 C CNN
F 1 "PWR_FLAG" H 1600 19373 50  0000 C CNN
F 2 "" H 1600 19200 50  0001 C CNN
F 3 "~" H 1600 19200 50  0001 C CNN
	1    1600 19200
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG02
U 1 1 5FF1F876
P 2000 19250
F 0 "#FLG02" H 2000 19325 50  0001 C CNN
F 1 "PWR_FLAG" H 2000 19423 50  0000 C CNN
F 2 "" H 2000 19250 50  0001 C CNN
F 3 "~" H 2000 19250 50  0001 C CNN
	1    2000 19250
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR075
U 1 1 5FF20231
P 1600 19200
F 0 "#PWR075" H 1600 18950 50  0001 C CNN
F 1 "GND" H 1605 19027 50  0000 C CNN
F 2 "" H 1600 19200 50  0001 C CNN
F 3 "" H 1600 19200 50  0001 C CNN
	1    1600 19200
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR076
U 1 1 5FF2076C
P 2000 19250
F 0 "#PWR076" H 2000 19100 50  0001 C CNN
F 1 "VCC" H 2015 19423 50  0000 C CNN
F 2 "" H 2000 19250 50  0001 C CNN
F 3 "" H 2000 19250 50  0001 C CNN
	1    2000 19250
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U29
U 1 1 5FF4011A
P 16050 13500
F 0 "U29" H 16050 13825 50  0000 C CNN
F 1 "74LV08APWJ" H 16050 13734 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 16050 13500 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/916/74LV08A-1598136.pdf" H 16050 13500 50  0001 C CNN
	1    16050 13500
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U29
U 4 1 5FF41395
P 20500 13250
F 0 "U29" H 20500 13575 50  0000 C CNN
F 1 "74LV08APWJ" H 20500 13484 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 20500 13250 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/916/74LV08A-1598136.pdf" H 20500 13250 50  0001 C CNN
	4    20500 13250
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U29
U 3 1 5FF43F60
P 20500 14400
F 0 "U29" H 20500 14725 50  0000 C CNN
F 1 "74LV08APWJ" H 20500 14634 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 20500 14400 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/916/74LV08A-1598136.pdf" H 20500 14400 50  0001 C CNN
	3    20500 14400
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U29
U 2 1 5FF46BB2
P 17050 12950
F 0 "U29" H 17050 13275 50  0000 C CNN
F 1 "74LV08APWJ" H 17050 13184 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 17050 12950 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/916/74LV08A-1598136.pdf" H 17050 12950 50  0001 C CNN
	2    17050 12950
	1    0    0    1   
$EndComp
$Comp
L 74xx:74LS08 U29
U 5 1 5FF4B757
P 19150 16150
F 0 "U29" H 19380 16196 50  0000 L CNN
F 1 "74LV08APWJ" H 19380 16105 50  0000 L CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 19150 16150 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/916/74LV08A-1598136.pdf" H 19150 16150 50  0001 C CNN
	5    19150 16150
	1    0    0    -1  
$EndComp
Text Label 12350 11050 1    50   ~ 0
hsync_int
Wire Wire Line
	16750 12850 16700 12850
Wire Wire Line
	16350 13500 16500 13500
Wire Wire Line
	16500 13500 16500 13050
Wire Wire Line
	16500 13050 16750 13050
Text Label 16500 13500 1    50   ~ 0
ext_acc_ena
Text Label 15500 13400 2    50   ~ 0
~pixel_ena_int
Text Label 17350 12950 0    50   ~ 0
acc_req
$Comp
L 74xx:74LS74 U30
U 1 1 5FE46D7C
P 14800 14100
F 0 "U30" H 15100 13900 50  0000 C CNN
F 1 "SN74LV74APW" H 15150 13800 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 14800 14100 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv74a.pdf" H 14800 14100 50  0001 C CNN
	1    14800 14100
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS74 U30
U 2 1 5FE477DE
P 20550 19900
F 0 "U30" H 20800 19600 50  0000 C CNN
F 1 "SN74LV74APW" H 20800 19500 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 20550 19900 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv74a.pdf" H 20550 19900 50  0001 C CNN
	2    20550 19900
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS74 U30
U 3 1 5FE47E77
P 20100 16150
F 0 "U30" H 20330 16196 50  0000 L CNN
F 1 "SN74LV74APW" H 20330 16105 50  0000 L CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 20100 16150 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lv74a.pdf" H 20100 16150 50  0001 C CNN
	3    20100 16150
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR071
U 1 1 5FF73A79
P 12750 13200
F 0 "#PWR071" H 12750 13050 50  0001 C CNN
F 1 "VCC" H 12765 13373 50  0000 C CNN
F 2 "" H 12750 13200 50  0001 C CNN
F 3 "" H 12750 13200 50  0001 C CNN
	1    12750 13200
	-1   0    0    1   
$EndComp
$Comp
L power:VCC #PWR0132
U 1 1 5FE9FD37
P 14800 14400
F 0 "#PWR0132" H 14800 14250 50  0001 C CNN
F 1 "VCC" H 14815 14573 50  0000 C CNN
F 2 "" H 14800 14400 50  0001 C CNN
F 3 "" H 14800 14400 50  0001 C CNN
	1    14800 14400
	-1   0    0    1   
$EndComp
Text Label 14800 13800 2    50   ~ 0
~rst
Text Label 14500 14100 2    50   ~ 0
a_sel_clk
Text Label 15100 14000 0    50   ~ 0
buf_a_sel
Text Label 14500 14000 2    50   ~ 0
~pixel_ena_int
Wire Wire Line
	15750 13600 15500 13600
Wire Wire Line
	15500 13600 15500 14000
Wire Wire Line
	15500 14000 15100 14000
NoConn ~ 15100 14200
Wire Wire Line
	15500 14000 15750 14000
Connection ~ 15500 14000
Wire Wire Line
	15500 13400 15650 13400
Wire Wire Line
	15750 14200 15650 14200
Wire Wire Line
	15650 14200 15650 13400
Connection ~ 15650 13400
Wire Wire Line
	15650 13400 15750 13400
Text Label 16350 14100 0    50   ~ 0
a_sel
Text Label 18600 13350 3    50   ~ 0
or_a12_nwe
Text Label 18500 12950 0    50   ~ 0
~acc_req
Wire Wire Line
	20200 13150 19800 13150
Wire Wire Line
	20200 14300 19950 14300
Text Label 20800 13250 0    50   ~ 0
~text_ram_cs
Text Label 20800 14400 0    50   ~ 0
~color_ram_cs
Text Label 20200 13350 2    50   ~ 0
a_sel
Text Label 20200 14500 2    50   ~ 0
a_sel
Wire Wire Line
	20200 13700 19800 13700
Wire Wire Line
	19800 13700 19800 13150
Connection ~ 19800 13150
Wire Wire Line
	19800 13150 19300 13150
Wire Wire Line
	20200 13900 19950 13900
Wire Wire Line
	19950 13900 19950 14300
Connection ~ 19950 14300
Wire Wire Line
	19950 14300 19300 14300
Text Label 20800 13800 0    50   ~ 0
rdy_out
Wire Wire Line
	21600 13800 20800 13800
Wire Wire Line
	12250 10250 12400 10250
Wire Wire Line
	12400 10250 12400 11150
Wire Wire Line
	12400 11150 12450 11150
Wire Wire Line
	12400 11150 12400 12900
Wire Wire Line
	12400 12900 12450 12900
Connection ~ 12400 11150
Text Label 11550 10250 2    50   ~ 0
hx2
Wire Wire Line
	11550 10250 11650 10250
Wire Wire Line
	11650 10250 11650 10150
Wire Wire Line
	11650 10350 11650 10250
Connection ~ 11650 10250
Wire Wire Line
	17350 12950 17600 12950
Wire Wire Line
	17850 14100 17600 14100
Wire Wire Line
	17600 14100 17600 12950
Connection ~ 17600 12950
Wire Wire Line
	17600 12950 17900 12950
$Comp
L power:VCC #PWR0146
U 1 1 601A70B0
P 17250 19800
F 0 "#PWR0146" H 17250 19650 50  0001 C CNN
F 1 "VCC" H 17265 19973 50  0000 C CNN
F 2 "" H 17250 19800 50  0001 C CNN
F 3 "" H 17250 19800 50  0001 C CNN
	1    17250 19800
	0    -1   -1   0   
$EndComp
Wire Wire Line
	17300 19900 17300 19800
Wire Wire Line
	17250 19800 17300 19800
Connection ~ 17300 19800
Wire Wire Line
	17300 19800 17300 19700
NoConn ~ 17900 19800
NoConn ~ 16700 19800
NoConn ~ 20850 20000
NoConn ~ 20850 19800
$Comp
L power:VCC #PWR0165
U 1 1 60251D4C
P 20550 20200
F 0 "#PWR0165" H 20550 20050 50  0001 C CNN
F 1 "VCC" H 20565 20373 50  0000 C CNN
F 2 "" H 20550 20200 50  0001 C CNN
F 3 "" H 20550 20200 50  0001 C CNN
	1    20550 20200
	-1   0    0    1   
$EndComp
$Comp
L power:VCC #PWR0164
U 1 1 6025314A
P 20550 19600
F 0 "#PWR0164" H 20550 19450 50  0001 C CNN
F 1 "VCC" H 20565 19773 50  0000 C CNN
F 2 "" H 20550 19600 50  0001 C CNN
F 3 "" H 20550 19600 50  0001 C CNN
	1    20550 19600
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0161
U 1 1 6025389C
P 20150 19850
F 0 "#PWR0161" H 20150 19700 50  0001 C CNN
F 1 "VCC" H 20165 20023 50  0000 C CNN
F 2 "" H 20150 19850 50  0001 C CNN
F 3 "" H 20150 19850 50  0001 C CNN
	1    20150 19850
	0    -1   -1   0   
$EndComp
Wire Wire Line
	20250 19800 20250 19850
Wire Wire Line
	20150 19850 20250 19850
Connection ~ 20250 19850
Wire Wire Line
	20250 19850 20250 19900
$Comp
L power:VCC #PWR0137
U 1 1 6028F0DF
P 16050 19800
F 0 "#PWR0137" H 16050 19650 50  0001 C CNN
F 1 "VCC" H 16065 19973 50  0000 C CNN
F 2 "" H 16050 19800 50  0001 C CNN
F 3 "" H 16050 19800 50  0001 C CNN
	1    16050 19800
	0    -1   -1   0   
$EndComp
Wire Wire Line
	16050 19800 16100 19800
Wire Wire Line
	16100 19800 16100 19700
Wire Wire Line
	16100 19900 16100 19800
Connection ~ 16100 19800
$Comp
L Device:R R2
U 1 1 602D3BA5
P 4350 13000
F 0 "R2" V 4557 13000 50  0000 C CNN
F 1 "50" V 4466 13000 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 4280 13000 50  0001 C CNN
F 3 "~" H 4350 13000 50  0001 C CNN
	1    4350 13000
	0    -1   -1   0   
$EndComp
Text Label 4500 13000 0    50   ~ 0
a_sel_clk
Wire Wire Line
	4200 13000 4200 13350
Text Label 16700 15000 0    50   ~ 0
~text_ram_oe
Text Label 16350 15000 2    50   ~ 0
a_sel
Text Label 16700 15300 0    50   ~ 0
~color_ram_oe
Wire Wire Line
	16350 15000 16700 15000
Wire Wire Line
	16700 15000 16700 15300
Text Label 19600 14800 0    50   ~ 0
~d_to_text_oe
Text Label 19600 15100 0    50   ~ 0
~d_to_color_oe
Text Label 19350 14800 2    50   ~ 0
~text_ram_we
Text Label 19350 15100 2    50   ~ 0
~color_ram_we
Wire Wire Line
	19350 14800 19600 14800
Wire Wire Line
	19600 15100 19350 15100
$Comp
L power:VCC #PWR0102
U 1 1 603ADA15
P 9950 15650
F 0 "#PWR0102" H 9950 15500 50  0001 C CNN
F 1 "VCC" H 9965 15823 50  0000 C CNN
F 2 "" H 9950 15650 50  0001 C CNN
F 3 "" H 9950 15650 50  0001 C CNN
	1    9950 15650
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0110
U 1 1 603AE51C
P 11100 15650
F 0 "#PWR0110" H 11100 15500 50  0001 C CNN
F 1 "VCC" H 11115 15823 50  0000 C CNN
F 2 "" H 11100 15650 50  0001 C CNN
F 3 "" H 11100 15650 50  0001 C CNN
	1    11100 15650
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0114
U 1 1 603AEE26
P 12150 15650
F 0 "#PWR0114" H 12150 15500 50  0001 C CNN
F 1 "VCC" H 12165 15823 50  0000 C CNN
F 2 "" H 12150 15650 50  0001 C CNN
F 3 "" H 12150 15650 50  0001 C CNN
	1    12150 15650
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0120
U 1 1 603AF3EA
P 13100 15650
F 0 "#PWR0120" H 13100 15500 50  0001 C CNN
F 1 "VCC" H 13115 15823 50  0000 C CNN
F 2 "" H 13100 15650 50  0001 C CNN
F 3 "" H 13100 15650 50  0001 C CNN
	1    13100 15650
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0128
U 1 1 603AF9DB
P 14150 15750
F 0 "#PWR0128" H 14150 15600 50  0001 C CNN
F 1 "VCC" H 14165 15923 50  0000 C CNN
F 2 "" H 14150 15750 50  0001 C CNN
F 3 "" H 14150 15750 50  0001 C CNN
	1    14150 15750
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0133
U 1 1 603AFEE2
P 15200 15650
F 0 "#PWR0133" H 15200 15500 50  0001 C CNN
F 1 "VCC" H 15215 15823 50  0000 C CNN
F 2 "" H 15200 15650 50  0001 C CNN
F 3 "" H 15200 15650 50  0001 C CNN
	1    15200 15650
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0140
U 1 1 603B0632
P 16200 15650
F 0 "#PWR0140" H 16200 15500 50  0001 C CNN
F 1 "VCC" H 16215 15823 50  0000 C CNN
F 2 "" H 16200 15650 50  0001 C CNN
F 3 "" H 16200 15650 50  0001 C CNN
	1    16200 15650
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0144
U 1 1 603B0D1A
P 17150 15650
F 0 "#PWR0144" H 17150 15500 50  0001 C CNN
F 1 "VCC" H 17165 15823 50  0000 C CNN
F 2 "" H 17150 15650 50  0001 C CNN
F 3 "" H 17150 15650 50  0001 C CNN
	1    17150 15650
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0149
U 1 1 603B1626
P 18200 15650
F 0 "#PWR0149" H 18200 15500 50  0001 C CNN
F 1 "VCC" H 18215 15823 50  0000 C CNN
F 2 "" H 18200 15650 50  0001 C CNN
F 3 "" H 18200 15650 50  0001 C CNN
	1    18200 15650
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0155
U 1 1 603B1CF9
P 19150 15650
F 0 "#PWR0155" H 19150 15500 50  0001 C CNN
F 1 "VCC" H 19165 15823 50  0000 C CNN
F 2 "" H 19150 15650 50  0001 C CNN
F 3 "" H 19150 15650 50  0001 C CNN
	1    19150 15650
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0159
U 1 1 603CEFB3
P 20100 15750
F 0 "#PWR0159" H 20100 15600 50  0001 C CNN
F 1 "VCC" H 20115 15923 50  0000 C CNN
F 2 "" H 20100 15750 50  0001 C CNN
F 3 "" H 20100 15750 50  0001 C CNN
	1    20100 15750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0103
U 1 1 603D1562
P 9950 16650
F 0 "#PWR0103" H 9950 16400 50  0001 C CNN
F 1 "GND" H 9955 16477 50  0000 C CNN
F 2 "" H 9950 16650 50  0001 C CNN
F 3 "" H 9950 16650 50  0001 C CNN
	1    9950 16650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0111
U 1 1 603D200A
P 11100 16650
F 0 "#PWR0111" H 11100 16400 50  0001 C CNN
F 1 "GND" H 11105 16477 50  0000 C CNN
F 2 "" H 11100 16650 50  0001 C CNN
F 3 "" H 11100 16650 50  0001 C CNN
	1    11100 16650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0115
U 1 1 603D24CC
P 12150 16650
F 0 "#PWR0115" H 12150 16400 50  0001 C CNN
F 1 "GND" H 12155 16477 50  0000 C CNN
F 2 "" H 12150 16650 50  0001 C CNN
F 3 "" H 12150 16650 50  0001 C CNN
	1    12150 16650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0121
U 1 1 603D286F
P 13100 16650
F 0 "#PWR0121" H 13100 16400 50  0001 C CNN
F 1 "GND" H 13105 16477 50  0000 C CNN
F 2 "" H 13100 16650 50  0001 C CNN
F 3 "" H 13100 16650 50  0001 C CNN
	1    13100 16650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0129
U 1 1 603D2D32
P 14150 16550
F 0 "#PWR0129" H 14150 16300 50  0001 C CNN
F 1 "GND" H 14155 16377 50  0000 C CNN
F 2 "" H 14150 16550 50  0001 C CNN
F 3 "" H 14150 16550 50  0001 C CNN
	1    14150 16550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0134
U 1 1 603D323B
P 15200 16650
F 0 "#PWR0134" H 15200 16400 50  0001 C CNN
F 1 "GND" H 15205 16477 50  0000 C CNN
F 2 "" H 15200 16650 50  0001 C CNN
F 3 "" H 15200 16650 50  0001 C CNN
	1    15200 16650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0141
U 1 1 603D36B0
P 16200 16650
F 0 "#PWR0141" H 16200 16400 50  0001 C CNN
F 1 "GND" H 16205 16477 50  0000 C CNN
F 2 "" H 16200 16650 50  0001 C CNN
F 3 "" H 16200 16650 50  0001 C CNN
	1    16200 16650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0145
U 1 1 603D3C56
P 17150 16650
F 0 "#PWR0145" H 17150 16400 50  0001 C CNN
F 1 "GND" H 17155 16477 50  0000 C CNN
F 2 "" H 17150 16650 50  0001 C CNN
F 3 "" H 17150 16650 50  0001 C CNN
	1    17150 16650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0150
U 1 1 603D4035
P 18200 16650
F 0 "#PWR0150" H 18200 16400 50  0001 C CNN
F 1 "GND" H 18205 16477 50  0000 C CNN
F 2 "" H 18200 16650 50  0001 C CNN
F 3 "" H 18200 16650 50  0001 C CNN
	1    18200 16650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0156
U 1 1 603D4491
P 19150 16650
F 0 "#PWR0156" H 19150 16400 50  0001 C CNN
F 1 "GND" H 19155 16477 50  0000 C CNN
F 2 "" H 19150 16650 50  0001 C CNN
F 3 "" H 19150 16650 50  0001 C CNN
	1    19150 16650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0160
U 1 1 603D4A32
P 20100 16550
F 0 "#PWR0160" H 20100 16300 50  0001 C CNN
F 1 "GND" H 20105 16377 50  0000 C CNN
F 2 "" H 20100 16550 50  0001 C CNN
F 3 "" H 20100 16550 50  0001 C CNN
	1    20100 16550
	1    0    0    -1  
$EndComp
Wire Notes Line
	9400 17150 9400 9750
Wire Notes Line
	9400 9750 22550 9750
Wire Notes Line
	22550 9750 22550 17150
Wire Notes Line
	22550 17150 9400 17150
Text Notes 17650 10350 0    197  ~ 0
see /model/vga_ctrl.v
Wire Wire Line
	12400 10250 13000 10250
Wire Wire Line
	13000 8200 13000 10250
Connection ~ 12400 10250
$Comp
L Device:C C13
U 1 1 604933C0
P 1200 14700
F 0 "C13" H 1315 14746 50  0000 L CNN
F 1 "0.1" H 1315 14655 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 1238 14550 50  0001 C CNN
F 3 "~" H 1200 14700 50  0001 C CNN
	1    1200 14700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0105
U 1 1 604939A9
P 1200 14850
F 0 "#PWR0105" H 1200 14600 50  0001 C CNN
F 1 "GND" H 1205 14677 50  0000 C CNN
F 2 "" H 1200 14850 50  0001 C CNN
F 3 "" H 1200 14850 50  0001 C CNN
	1    1200 14850
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0104
U 1 1 6049402E
P 1200 14550
F 0 "#PWR0104" H 1200 14400 50  0001 C CNN
F 1 "VCC" H 1215 14723 50  0000 C CNN
F 2 "" H 1200 14550 50  0001 C CNN
F 3 "" H 1200 14550 50  0001 C CNN
	1    1200 14550
	1    0    0    -1  
$EndComp
$Comp
L Device:C C14
U 1 1 60494C0A
P 10350 15650
F 0 "C14" H 10465 15696 50  0000 L CNN
F 1 "0.1" H 10465 15605 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 10388 15500 50  0001 C CNN
F 3 "~" H 10350 15650 50  0001 C CNN
	1    10350 15650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0107
U 1 1 60494C10
P 10350 15800
F 0 "#PWR0107" H 10350 15550 50  0001 C CNN
F 1 "GND" H 10355 15627 50  0000 C CNN
F 2 "" H 10350 15800 50  0001 C CNN
F 3 "" H 10350 15800 50  0001 C CNN
	1    10350 15800
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0106
U 1 1 60494C16
P 10350 15500
F 0 "#PWR0106" H 10350 15350 50  0001 C CNN
F 1 "VCC" H 10365 15673 50  0000 C CNN
F 2 "" H 10350 15500 50  0001 C CNN
F 3 "" H 10350 15500 50  0001 C CNN
	1    10350 15500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C16
U 1 1 604B24F9
P 11500 15650
F 0 "C16" H 11615 15696 50  0000 L CNN
F 1 "0.1" H 11615 15605 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 11538 15500 50  0001 C CNN
F 3 "~" H 11500 15650 50  0001 C CNN
	1    11500 15650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0113
U 1 1 604B24FF
P 11500 15800
F 0 "#PWR0113" H 11500 15550 50  0001 C CNN
F 1 "GND" H 11505 15627 50  0000 C CNN
F 2 "" H 11500 15800 50  0001 C CNN
F 3 "" H 11500 15800 50  0001 C CNN
	1    11500 15800
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0112
U 1 1 604B2505
P 11500 15500
F 0 "#PWR0112" H 11500 15350 50  0001 C CNN
F 1 "VCC" H 11515 15673 50  0000 C CNN
F 2 "" H 11500 15500 50  0001 C CNN
F 3 "" H 11500 15500 50  0001 C CNN
	1    11500 15500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C18
U 1 1 604CF5AB
P 12500 15650
F 0 "C18" H 12615 15696 50  0000 L CNN
F 1 "0.1" H 12615 15605 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 12538 15500 50  0001 C CNN
F 3 "~" H 12500 15650 50  0001 C CNN
	1    12500 15650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0119
U 1 1 604CF5B1
P 12500 15800
F 0 "#PWR0119" H 12500 15550 50  0001 C CNN
F 1 "GND" H 12505 15627 50  0000 C CNN
F 2 "" H 12500 15800 50  0001 C CNN
F 3 "" H 12500 15800 50  0001 C CNN
	1    12500 15800
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0118
U 1 1 604CF5B7
P 12500 15500
F 0 "#PWR0118" H 12500 15350 50  0001 C CNN
F 1 "VCC" H 12515 15673 50  0000 C CNN
F 2 "" H 12500 15500 50  0001 C CNN
F 3 "" H 12500 15500 50  0001 C CNN
	1    12500 15500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C19
U 1 1 604EC7EC
P 13450 15650
F 0 "C19" H 13565 15696 50  0000 L CNN
F 1 "0.1" H 13565 15605 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 13488 15500 50  0001 C CNN
F 3 "~" H 13450 15650 50  0001 C CNN
	1    13450 15650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0123
U 1 1 604EC7F2
P 13450 15800
F 0 "#PWR0123" H 13450 15550 50  0001 C CNN
F 1 "GND" H 13455 15627 50  0000 C CNN
F 2 "" H 13450 15800 50  0001 C CNN
F 3 "" H 13450 15800 50  0001 C CNN
	1    13450 15800
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0122
U 1 1 604EC7F8
P 13450 15500
F 0 "#PWR0122" H 13450 15350 50  0001 C CNN
F 1 "VCC" H 13465 15673 50  0000 C CNN
F 2 "" H 13450 15500 50  0001 C CNN
F 3 "" H 13450 15500 50  0001 C CNN
	1    13450 15500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C22
U 1 1 6050962B
P 14550 15650
F 0 "C22" H 14665 15696 50  0000 L CNN
F 1 "0.1" H 14665 15605 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 14588 15500 50  0001 C CNN
F 3 "~" H 14550 15650 50  0001 C CNN
	1    14550 15650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0131
U 1 1 60509631
P 14550 15800
F 0 "#PWR0131" H 14550 15550 50  0001 C CNN
F 1 "GND" H 14555 15627 50  0000 C CNN
F 2 "" H 14550 15800 50  0001 C CNN
F 3 "" H 14550 15800 50  0001 C CNN
	1    14550 15800
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0130
U 1 1 60509637
P 14550 15500
F 0 "#PWR0130" H 14550 15350 50  0001 C CNN
F 1 "VCC" H 14565 15673 50  0000 C CNN
F 2 "" H 14550 15500 50  0001 C CNN
F 3 "" H 14550 15500 50  0001 C CNN
	1    14550 15500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C23
U 1 1 60526386
P 15600 15650
F 0 "C23" H 15715 15696 50  0000 L CNN
F 1 "0.1" H 15715 15605 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 15638 15500 50  0001 C CNN
F 3 "~" H 15600 15650 50  0001 C CNN
	1    15600 15650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0136
U 1 1 6052638C
P 15600 15800
F 0 "#PWR0136" H 15600 15550 50  0001 C CNN
F 1 "GND" H 15605 15627 50  0000 C CNN
F 2 "" H 15600 15800 50  0001 C CNN
F 3 "" H 15600 15800 50  0001 C CNN
	1    15600 15800
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0135
U 1 1 60526392
P 15600 15500
F 0 "#PWR0135" H 15600 15350 50  0001 C CNN
F 1 "VCC" H 15615 15673 50  0000 C CNN
F 2 "" H 15600 15500 50  0001 C CNN
F 3 "" H 15600 15500 50  0001 C CNN
	1    15600 15500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C25
U 1 1 605439C9
P 16550 15650
F 0 "C25" H 16665 15696 50  0000 L CNN
F 1 "0.1" H 16665 15605 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 16588 15500 50  0001 C CNN
F 3 "~" H 16550 15650 50  0001 C CNN
	1    16550 15650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0143
U 1 1 605439CF
P 16550 15800
F 0 "#PWR0143" H 16550 15550 50  0001 C CNN
F 1 "GND" H 16555 15627 50  0000 C CNN
F 2 "" H 16550 15800 50  0001 C CNN
F 3 "" H 16550 15800 50  0001 C CNN
	1    16550 15800
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0142
U 1 1 605439D5
P 16550 15500
F 0 "#PWR0142" H 16550 15350 50  0001 C CNN
F 1 "VCC" H 16565 15673 50  0000 C CNN
F 2 "" H 16550 15500 50  0001 C CNN
F 3 "" H 16550 15500 50  0001 C CNN
	1    16550 15500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C26
U 1 1 60561246
P 17500 15650
F 0 "C26" H 17615 15696 50  0000 L CNN
F 1 "0.1" H 17615 15605 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 17538 15500 50  0001 C CNN
F 3 "~" H 17500 15650 50  0001 C CNN
	1    17500 15650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0148
U 1 1 6056124C
P 17500 15800
F 0 "#PWR0148" H 17500 15550 50  0001 C CNN
F 1 "GND" H 17505 15627 50  0000 C CNN
F 2 "" H 17500 15800 50  0001 C CNN
F 3 "" H 17500 15800 50  0001 C CNN
	1    17500 15800
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0147
U 1 1 60561252
P 17500 15500
F 0 "#PWR0147" H 17500 15350 50  0001 C CNN
F 1 "VCC" H 17515 15673 50  0000 C CNN
F 2 "" H 17500 15500 50  0001 C CNN
F 3 "" H 17500 15500 50  0001 C CNN
	1    17500 15500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C28
U 1 1 6057E3DC
P 18550 15700
F 0 "C28" H 18665 15746 50  0000 L CNN
F 1 "0.1" H 18665 15655 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 18588 15550 50  0001 C CNN
F 3 "~" H 18550 15700 50  0001 C CNN
	1    18550 15700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0154
U 1 1 6057E3E2
P 18550 15850
F 0 "#PWR0154" H 18550 15600 50  0001 C CNN
F 1 "GND" H 18555 15677 50  0000 C CNN
F 2 "" H 18550 15850 50  0001 C CNN
F 3 "" H 18550 15850 50  0001 C CNN
	1    18550 15850
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0153
U 1 1 6057E3E8
P 18550 15550
F 0 "#PWR0153" H 18550 15400 50  0001 C CNN
F 1 "VCC" H 18565 15723 50  0000 C CNN
F 2 "" H 18550 15550 50  0001 C CNN
F 3 "" H 18550 15550 50  0001 C CNN
	1    18550 15550
	1    0    0    -1  
$EndComp
$Comp
L Device:C C29
U 1 1 6059B170
P 19500 15700
F 0 "C29" H 19615 15746 50  0000 L CNN
F 1 "0.1" H 19615 15655 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 19538 15550 50  0001 C CNN
F 3 "~" H 19500 15700 50  0001 C CNN
	1    19500 15700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0158
U 1 1 6059B176
P 19500 15850
F 0 "#PWR0158" H 19500 15600 50  0001 C CNN
F 1 "GND" H 19505 15677 50  0000 C CNN
F 2 "" H 19500 15850 50  0001 C CNN
F 3 "" H 19500 15850 50  0001 C CNN
	1    19500 15850
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0157
U 1 1 6059B17C
P 19500 15550
F 0 "#PWR0157" H 19500 15400 50  0001 C CNN
F 1 "VCC" H 19515 15723 50  0000 C CNN
F 2 "" H 19500 15550 50  0001 C CNN
F 3 "" H 19500 15550 50  0001 C CNN
	1    19500 15550
	1    0    0    -1  
$EndComp
$Comp
L Device:C C30
U 1 1 605B8507
P 20450 15700
F 0 "C30" H 20565 15746 50  0000 L CNN
F 1 "0.1" H 20565 15655 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 20488 15550 50  0001 C CNN
F 3 "~" H 20450 15700 50  0001 C CNN
	1    20450 15700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0163
U 1 1 605B850D
P 20450 15850
F 0 "#PWR0163" H 20450 15600 50  0001 C CNN
F 1 "GND" H 20455 15677 50  0000 C CNN
F 2 "" H 20450 15850 50  0001 C CNN
F 3 "" H 20450 15850 50  0001 C CNN
	1    20450 15850
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0162
U 1 1 605B8513
P 20450 15550
F 0 "#PWR0162" H 20450 15400 50  0001 C CNN
F 1 "VCC" H 20465 15723 50  0000 C CNN
F 2 "" H 20450 15550 50  0001 C CNN
F 3 "" H 20450 15550 50  0001 C CNN
	1    20450 15550
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 605F4811
P 3950 15100
F 0 "C1" H 4065 15146 50  0000 L CNN
F 1 "0.1" H 4065 15055 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 3988 14950 50  0001 C CNN
F 3 "~" H 3950 15100 50  0001 C CNN
	1    3950 15100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR079
U 1 1 605F4817
P 3950 15250
F 0 "#PWR079" H 3950 15000 50  0001 C CNN
F 1 "GND" H 3955 15077 50  0000 C CNN
F 2 "" H 3950 15250 50  0001 C CNN
F 3 "" H 3950 15250 50  0001 C CNN
	1    3950 15250
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR078
U 1 1 605F481D
P 3950 14950
F 0 "#PWR078" H 3950 14800 50  0001 C CNN
F 1 "VCC" H 3965 15123 50  0000 C CNN
F 2 "" H 3950 14950 50  0001 C CNN
F 3 "" H 3950 14950 50  0001 C CNN
	1    3950 14950
	1    0    0    -1  
$EndComp
$Comp
L Device:C C5
U 1 1 60611578
P 5650 15150
F 0 "C5" H 5765 15196 50  0000 L CNN
F 1 "0.1" H 5765 15105 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 5688 15000 50  0001 C CNN
F 3 "~" H 5650 15150 50  0001 C CNN
	1    5650 15150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR087
U 1 1 6061157E
P 5650 15300
F 0 "#PWR087" H 5650 15050 50  0001 C CNN
F 1 "GND" H 5655 15127 50  0000 C CNN
F 2 "" H 5650 15300 50  0001 C CNN
F 3 "" H 5650 15300 50  0001 C CNN
	1    5650 15300
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR086
U 1 1 60611584
P 5650 15000
F 0 "#PWR086" H 5650 14850 50  0001 C CNN
F 1 "VCC" H 5665 15173 50  0000 C CNN
F 2 "" H 5650 15000 50  0001 C CNN
F 3 "" H 5650 15000 50  0001 C CNN
	1    5650 15000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C9
U 1 1 6062F068
P 7350 15150
F 0 "C9" H 7465 15196 50  0000 L CNN
F 1 "0.1" H 7465 15105 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 7388 15000 50  0001 C CNN
F 3 "~" H 7350 15150 50  0001 C CNN
	1    7350 15150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR095
U 1 1 6062F06E
P 7350 15300
F 0 "#PWR095" H 7350 15050 50  0001 C CNN
F 1 "GND" H 7355 15127 50  0000 C CNN
F 2 "" H 7350 15300 50  0001 C CNN
F 3 "" H 7350 15300 50  0001 C CNN
	1    7350 15300
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR094
U 1 1 6062F074
P 7350 15000
F 0 "#PWR094" H 7350 14850 50  0001 C CNN
F 1 "VCC" H 7365 15173 50  0000 C CNN
F 2 "" H 7350 15000 50  0001 C CNN
F 3 "" H 7350 15000 50  0001 C CNN
	1    7350 15000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C10
U 1 1 6064D35C
P 7400 12850
F 0 "C10" H 7515 12896 50  0000 L CNN
F 1 "0.1" H 7515 12805 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 7438 12700 50  0001 C CNN
F 3 "~" H 7400 12850 50  0001 C CNN
	1    7400 12850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR097
U 1 1 6064D362
P 7400 13000
F 0 "#PWR097" H 7400 12750 50  0001 C CNN
F 1 "GND" H 7405 12827 50  0000 C CNN
F 2 "" H 7400 13000 50  0001 C CNN
F 3 "" H 7400 13000 50  0001 C CNN
	1    7400 13000
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR096
U 1 1 6064D368
P 7400 12700
F 0 "#PWR096" H 7400 12550 50  0001 C CNN
F 1 "VCC" H 7415 12873 50  0000 C CNN
F 2 "" H 7400 12700 50  0001 C CNN
F 3 "" H 7400 12700 50  0001 C CNN
	1    7400 12700
	1    0    0    -1  
$EndComp
$Comp
L Device:C C8
U 1 1 6066A8F4
P 5700 12850
F 0 "C8" H 5815 12896 50  0000 L CNN
F 1 "0.1" H 5815 12805 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 5738 12700 50  0001 C CNN
F 3 "~" H 5700 12850 50  0001 C CNN
	1    5700 12850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR093
U 1 1 6066A8FA
P 5700 13000
F 0 "#PWR093" H 5700 12750 50  0001 C CNN
F 1 "GND" H 5705 12827 50  0000 C CNN
F 2 "" H 5700 13000 50  0001 C CNN
F 3 "" H 5700 13000 50  0001 C CNN
	1    5700 13000
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR092
U 1 1 6066A900
P 5700 12700
F 0 "#PWR092" H 5700 12550 50  0001 C CNN
F 1 "VCC" H 5715 12873 50  0000 C CNN
F 2 "" H 5700 12700 50  0001 C CNN
F 3 "" H 5700 12700 50  0001 C CNN
	1    5700 12700
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 60687AC3
P 4000 12800
F 0 "C2" H 4115 12846 50  0000 L CNN
F 1 "0.1" H 4115 12755 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 4038 12650 50  0001 C CNN
F 3 "~" H 4000 12800 50  0001 C CNN
	1    4000 12800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR081
U 1 1 60687AC9
P 4000 12950
F 0 "#PWR081" H 4000 12700 50  0001 C CNN
F 1 "GND" H 4005 12777 50  0000 C CNN
F 2 "" H 4000 12950 50  0001 C CNN
F 3 "" H 4000 12950 50  0001 C CNN
	1    4000 12950
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR080
U 1 1 60687ACF
P 4000 12650
F 0 "#PWR080" H 4000 12500 50  0001 C CNN
F 1 "VCC" H 4015 12823 50  0000 C CNN
F 2 "" H 4000 12650 50  0001 C CNN
F 3 "" H 4000 12650 50  0001 C CNN
	1    4000 12650
	1    0    0    -1  
$EndComp
$Comp
L Device:C C3
U 1 1 606A4A1F
P 5150 4000
F 0 "C3" H 5265 4046 50  0000 L CNN
F 1 "0.1" H 5265 3955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 5188 3850 50  0001 C CNN
F 3 "~" H 5150 4000 50  0001 C CNN
	1    5150 4000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR083
U 1 1 606A4A25
P 5150 4150
F 0 "#PWR083" H 5150 3900 50  0001 C CNN
F 1 "GND" H 5155 3977 50  0000 C CNN
F 2 "" H 5150 4150 50  0001 C CNN
F 3 "" H 5150 4150 50  0001 C CNN
	1    5150 4150
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR082
U 1 1 606A4A2B
P 5150 3850
F 0 "#PWR082" H 5150 3700 50  0001 C CNN
F 1 "VCC" H 5165 4023 50  0000 C CNN
F 2 "" H 5150 3850 50  0001 C CNN
F 3 "" H 5150 3850 50  0001 C CNN
	1    5150 3850
	1    0    0    -1  
$EndComp
$Comp
L Device:C C4
U 1 1 606C29F5
P 5650 6400
F 0 "C4" H 5765 6446 50  0000 L CNN
F 1 "0.1" H 5765 6355 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 5688 6250 50  0001 C CNN
F 3 "~" H 5650 6400 50  0001 C CNN
	1    5650 6400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR085
U 1 1 606C29FB
P 5650 6550
F 0 "#PWR085" H 5650 6300 50  0001 C CNN
F 1 "GND" H 5655 6377 50  0000 C CNN
F 2 "" H 5650 6550 50  0001 C CNN
F 3 "" H 5650 6550 50  0001 C CNN
	1    5650 6550
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR084
U 1 1 606C2A01
P 5650 6250
F 0 "#PWR084" H 5650 6100 50  0001 C CNN
F 1 "VCC" H 5665 6423 50  0000 C CNN
F 2 "" H 5650 6250 50  0001 C CNN
F 3 "" H 5650 6250 50  0001 C CNN
	1    5650 6250
	1    0    0    -1  
$EndComp
$Comp
L Device:C C7
U 1 1 606E0038
P 5700 8650
F 0 "C7" H 5815 8696 50  0000 L CNN
F 1 "0.1" H 5815 8605 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 5738 8500 50  0001 C CNN
F 3 "~" H 5700 8650 50  0001 C CNN
	1    5700 8650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR091
U 1 1 606E003E
P 5700 8800
F 0 "#PWR091" H 5700 8550 50  0001 C CNN
F 1 "GND" H 5705 8627 50  0000 C CNN
F 2 "" H 5700 8800 50  0001 C CNN
F 3 "" H 5700 8800 50  0001 C CNN
	1    5700 8800
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR090
U 1 1 606E0044
P 5700 8500
F 0 "#PWR090" H 5700 8350 50  0001 C CNN
F 1 "VCC" H 5715 8673 50  0000 C CNN
F 2 "" H 5700 8500 50  0001 C CNN
F 3 "" H 5700 8500 50  0001 C CNN
	1    5700 8500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C12
U 1 1 606FD55E
P 7450 7550
F 0 "C12" H 7565 7596 50  0000 L CNN
F 1 "0.1" H 7565 7505 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 7488 7400 50  0001 C CNN
F 3 "~" H 7450 7550 50  0001 C CNN
	1    7450 7550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 606FD564
P 7450 7700
F 0 "#PWR0101" H 7450 7450 50  0001 C CNN
F 1 "GND" H 7455 7527 50  0000 C CNN
F 2 "" H 7450 7700 50  0001 C CNN
F 3 "" H 7450 7700 50  0001 C CNN
	1    7450 7700
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0100
U 1 1 606FD56A
P 7450 7400
F 0 "#PWR0100" H 7450 7250 50  0001 C CNN
F 1 "VCC" H 7465 7573 50  0000 C CNN
F 2 "" H 7450 7400 50  0001 C CNN
F 3 "" H 7450 7400 50  0001 C CNN
	1    7450 7400
	1    0    0    -1  
$EndComp
$Comp
L Device:C C11
U 1 1 6071AABD
P 7450 4050
F 0 "C11" H 7565 4096 50  0000 L CNN
F 1 "0.1" H 7565 4005 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 7488 3900 50  0001 C CNN
F 3 "~" H 7450 4050 50  0001 C CNN
	1    7450 4050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR099
U 1 1 6071AAC3
P 7450 4200
F 0 "#PWR099" H 7450 3950 50  0001 C CNN
F 1 "GND" H 7455 4027 50  0000 C CNN
F 2 "" H 7450 4200 50  0001 C CNN
F 3 "" H 7450 4200 50  0001 C CNN
	1    7450 4200
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR098
U 1 1 6071AAC9
P 7450 3900
F 0 "#PWR098" H 7450 3750 50  0001 C CNN
F 1 "VCC" H 7465 4073 50  0000 C CNN
F 2 "" H 7450 3900 50  0001 C CNN
F 3 "" H 7450 3900 50  0001 C CNN
	1    7450 3900
	1    0    0    -1  
$EndComp
$Comp
L Device:C C6
U 1 1 6073B38B
P 5700 1700
F 0 "C6" H 5815 1746 50  0000 L CNN
F 1 "0.1" H 5815 1655 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 5738 1550 50  0001 C CNN
F 3 "~" H 5700 1700 50  0001 C CNN
	1    5700 1700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR089
U 1 1 6073B391
P 5700 1850
F 0 "#PWR089" H 5700 1600 50  0001 C CNN
F 1 "GND" H 5705 1677 50  0000 C CNN
F 2 "" H 5700 1850 50  0001 C CNN
F 3 "" H 5700 1850 50  0001 C CNN
	1    5700 1850
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR088
U 1 1 6073B397
P 5700 1550
F 0 "#PWR088" H 5700 1400 50  0001 C CNN
F 1 "VCC" H 5715 1723 50  0000 C CNN
F 2 "" H 5700 1550 50  0001 C CNN
F 3 "" H 5700 1550 50  0001 C CNN
	1    5700 1550
	1    0    0    -1  
$EndComp
$Comp
L Device:C C15
U 1 1 60758CEC
P 10850 1650
F 0 "C15" H 10965 1696 50  0000 L CNN
F 1 "0.1" H 10965 1605 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 10888 1500 50  0001 C CNN
F 3 "~" H 10850 1650 50  0001 C CNN
	1    10850 1650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0109
U 1 1 60758CF2
P 10850 1800
F 0 "#PWR0109" H 10850 1550 50  0001 C CNN
F 1 "GND" H 10855 1627 50  0000 C CNN
F 2 "" H 10850 1800 50  0001 C CNN
F 3 "" H 10850 1800 50  0001 C CNN
	1    10850 1800
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0108
U 1 1 60758CF8
P 10850 1500
F 0 "#PWR0108" H 10850 1350 50  0001 C CNN
F 1 "VCC" H 10865 1673 50  0000 C CNN
F 2 "" H 10850 1500 50  0001 C CNN
F 3 "" H 10850 1500 50  0001 C CNN
	1    10850 1500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C17
U 1 1 60775AB9
P 12200 4150
F 0 "C17" H 12315 4196 50  0000 L CNN
F 1 "0.1" H 12315 4105 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 12238 4000 50  0001 C CNN
F 3 "~" H 12200 4150 50  0001 C CNN
	1    12200 4150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0117
U 1 1 60775ABF
P 12200 4300
F 0 "#PWR0117" H 12200 4050 50  0001 C CNN
F 1 "GND" H 12205 4127 50  0000 C CNN
F 2 "" H 12200 4300 50  0001 C CNN
F 3 "" H 12200 4300 50  0001 C CNN
	1    12200 4300
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0116
U 1 1 60775AC5
P 12200 4000
F 0 "#PWR0116" H 12200 3850 50  0001 C CNN
F 1 "VCC" H 12215 4173 50  0000 C CNN
F 2 "" H 12200 4000 50  0001 C CNN
F 3 "" H 12200 4000 50  0001 C CNN
	1    12200 4000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C20
U 1 1 60792814
P 14000 4100
F 0 "C20" H 14115 4146 50  0000 L CNN
F 1 "0.1" H 14115 4055 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 14038 3950 50  0001 C CNN
F 3 "~" H 14000 4100 50  0001 C CNN
	1    14000 4100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0125
U 1 1 6079281A
P 14000 4250
F 0 "#PWR0125" H 14000 4000 50  0001 C CNN
F 1 "GND" H 14005 4077 50  0000 C CNN
F 2 "" H 14000 4250 50  0001 C CNN
F 3 "" H 14000 4250 50  0001 C CNN
	1    14000 4250
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0124
U 1 1 60792820
P 14000 3950
F 0 "#PWR0124" H 14000 3800 50  0001 C CNN
F 1 "VCC" H 14015 4123 50  0000 C CNN
F 2 "" H 14000 3950 50  0001 C CNN
F 3 "" H 14000 3950 50  0001 C CNN
	1    14000 3950
	1    0    0    -1  
$EndComp
$Comp
L Device:C C24
U 1 1 607AF5A8
P 16200 4050
F 0 "C24" H 16315 4096 50  0000 L CNN
F 1 "0.1" H 16315 4005 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 16238 3900 50  0001 C CNN
F 3 "~" H 16200 4050 50  0001 C CNN
	1    16200 4050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0139
U 1 1 607AF5AE
P 16200 4200
F 0 "#PWR0139" H 16200 3950 50  0001 C CNN
F 1 "GND" H 16205 4027 50  0000 C CNN
F 2 "" H 16200 4200 50  0001 C CNN
F 3 "" H 16200 4200 50  0001 C CNN
	1    16200 4200
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0138
U 1 1 607AF5B4
P 16200 3900
F 0 "#PWR0138" H 16200 3750 50  0001 C CNN
F 1 "VCC" H 16215 4073 50  0000 C CNN
F 2 "" H 16200 3900 50  0001 C CNN
F 3 "" H 16200 3900 50  0001 C CNN
	1    16200 3900
	1    0    0    -1  
$EndComp
$Comp
L Device:C C27
U 1 1 607CCA23
P 18250 4150
F 0 "C27" H 18365 4196 50  0000 L CNN
F 1 "0.1" H 18365 4105 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 18288 4000 50  0001 C CNN
F 3 "~" H 18250 4150 50  0001 C CNN
	1    18250 4150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0152
U 1 1 607CCA29
P 18250 4300
F 0 "#PWR0152" H 18250 4050 50  0001 C CNN
F 1 "GND" H 18255 4127 50  0000 C CNN
F 2 "" H 18250 4300 50  0001 C CNN
F 3 "" H 18250 4300 50  0001 C CNN
	1    18250 4300
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0151
U 1 1 607CCA2F
P 18250 4000
F 0 "#PWR0151" H 18250 3850 50  0001 C CNN
F 1 "VCC" H 18265 4173 50  0000 C CNN
F 2 "" H 18250 4000 50  0001 C CNN
F 3 "" H 18250 4000 50  0001 C CNN
	1    18250 4000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C21
U 1 1 607EA111
P 14100 6650
F 0 "C21" H 14215 6696 50  0000 L CNN
F 1 "0.1" H 14215 6605 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 14138 6500 50  0001 C CNN
F 3 "~" H 14100 6650 50  0001 C CNN
	1    14100 6650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0127
U 1 1 607EA117
P 14100 6800
F 0 "#PWR0127" H 14100 6550 50  0001 C CNN
F 1 "GND" H 14105 6627 50  0000 C CNN
F 2 "" H 14100 6800 50  0001 C CNN
F 3 "" H 14100 6800 50  0001 C CNN
	1    14100 6800
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0126
U 1 1 607EA11D
P 14100 6500
F 0 "#PWR0126" H 14100 6350 50  0001 C CNN
F 1 "VCC" H 14115 6673 50  0000 C CNN
F 2 "" H 14100 6500 50  0001 C CNN
F 3 "" H 14100 6500 50  0001 C CNN
	1    14100 6500
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 608101BA
P 16700 5250
F 0 "R3" V 16907 5250 50  0000 C CNN
F 1 "50" V 16816 5250 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 16630 5250 50  0001 C CNN
F 3 "~" H 16700 5250 50  0001 C CNN
	1    16700 5250
	-1   0    0    1   
$EndComp
Wire Wire Line
	16700 5850 16700 5400
Wire Wire Line
	16700 5100 16700 4650
$Comp
L Connector:DB15_Female_HighDensity_MountingHoles J2
U 1 1 608A11F3
P 21800 4400
F 0 "J2" H 21800 5267 50  0000 C CNN
F 1 "L77HDE15SD1CH4RHNVGA" H 21800 5176 50  0000 C CNN
F 2 "Connector_Dsub:DSUB-15-HD_Female_Horizontal_P2.29x1.98mm_EdgePinOffset8.35mm_Housed_MountingHolesOffset10.89mm" H 20850 4800 50  0001 C CNN
F 3 " ~" H 20850 4800 50  0001 C CNN
	1    21800 4400
	1    0    0    -1  
$EndComp
NoConn ~ 21500 4600
$Comp
L power:GND #PWR0169
U 1 1 5FE2CDBD
P 21500 4800
F 0 "#PWR0169" H 21500 4550 50  0001 C CNN
F 1 "GND" H 21505 4627 50  0000 C CNN
F 2 "" H 21500 4800 50  0001 C CNN
F 3 "" H 21500 4800 50  0001 C CNN
	1    21500 4800
	1    0    0    -1  
$EndComp
Wire Wire Line
	21500 4700 21500 4800
Connection ~ 21500 4800
NoConn ~ 22100 4000
NoConn ~ 22100 4200
NoConn ~ 22100 4800
$Comp
L power:GND #PWR0170
U 1 1 5FEA5884
P 21800 5100
F 0 "#PWR0170" H 21800 4850 50  0001 C CNN
F 1 "GND" H 21805 4927 50  0000 C CNN
F 2 "" H 21800 5100 50  0001 C CNN
F 3 "" H 21800 5100 50  0001 C CNN
	1    21800 5100
	1    0    0    -1  
$EndComp
Text Label 22100 4400 0    50   ~ 0
hsync_out
Text Label 22100 4600 0    50   ~ 0
vsync_out
Wire Wire Line
	20150 4450 20150 4300
$Comp
L power:GNDA #PWR0166
U 1 1 5FED7D9B
P 21400 3900
F 0 "#PWR0166" H 21400 3650 50  0001 C CNN
F 1 "GNDA" V 21405 3773 50  0000 R CNN
F 2 "" H 21400 3900 50  0001 C CNN
F 3 "" H 21400 3900 50  0001 C CNN
	1    21400 3900
	0    1    1    0   
$EndComp
Wire Wire Line
	21500 3900 21400 3900
$Comp
L power:GNDA #PWR0167
U 1 1 5FEF8336
P 21400 4100
F 0 "#PWR0167" H 21400 3850 50  0001 C CNN
F 1 "GNDA" V 21405 3973 50  0000 R CNN
F 2 "" H 21400 4100 50  0001 C CNN
F 3 "" H 21400 4100 50  0001 C CNN
	1    21400 4100
	0    1    1    0   
$EndComp
$Comp
L power:GNDA #PWR0168
U 1 1 5FEF86C1
P 21400 4300
F 0 "#PWR0168" H 21400 4050 50  0001 C CNN
F 1 "GNDA" V 21405 4173 50  0000 R CNN
F 2 "" H 21400 4300 50  0001 C CNN
F 3 "" H 21400 4300 50  0001 C CNN
	1    21400 4300
	0    1    1    0   
$EndComp
Wire Wire Line
	21400 4300 21500 4300
Wire Wire Line
	21400 4100 21500 4100
Wire Wire Line
	20150 5550 20150 5400
Wire Wire Line
	20150 6650 20150 6500
Wire Wire Line
	19550 6650 19550 5550
Connection ~ 19550 5550
Wire Wire Line
	19550 5550 19550 4450
Wire Wire Line
	19550 5550 18450 5550
Wire Wire Line
	19850 6250 19100 6250
Wire Wire Line
	19100 6250 19100 5250
Wire Wire Line
	19100 5250 18450 5250
Wire Wire Line
	19850 5150 19100 5150
Wire Wire Line
	19100 5150 19100 4950
Wire Wire Line
	19100 4950 18450 4950
Wire Wire Line
	19850 4050 19100 4050
Wire Wire Line
	19100 4050 19100 4650
Wire Wire Line
	19100 4650 18450 4650
Wire Wire Line
	21500 4400 20500 4400
Wire Wire Line
	20500 4400 20500 4450
Wire Wire Line
	20500 4450 20150 4450
Wire Wire Line
	21500 4200 20850 4200
Wire Wire Line
	20850 4200 20850 5550
Wire Wire Line
	20850 5550 20150 5550
Wire Wire Line
	20150 6650 20750 6650
Wire Wire Line
	20750 6650 20750 4000
Wire Wire Line
	20750 4000 21500 4000
Text Label 20350 4450 0    50   ~ 0
ab
Text Label 20400 5550 0    50   ~ 0
ag
Text Label 20400 6650 0    50   ~ 0
ar
NoConn ~ 21500 4500
$Comp
L Device:R_POT_TRIM RV1
U 1 1 5FD795FD
P 20000 4050
F 0 "RV1" V 20100 4300 50  0000 C CNN
F 1 "TC33X-2-102" V 19950 4450 50  0000 C CNN
F 2 "Potentiometer_SMD:Potentiometer_Bourns_TC33X_Vertical" H 20000 4050 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/54/tc33-778219.pdf" H 20000 4050 50  0001 C CNN
	1    20000 4050
	0    -1   -1   0   
$EndComp
$Comp
L Device:R_POT_TRIM RV2
U 1 1 5FD7B4C1
P 20000 4450
F 0 "RV2" V 20150 4600 50  0000 C CNN
F 1 "TC33X-2-102" V 19900 4400 50  0000 C CNN
F 2 "Potentiometer_SMD:Potentiometer_Bourns_TC33X_Vertical" H 20000 4450 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/54/tc33-778219.pdf" H 20000 4450 50  0001 C CNN
	1    20000 4450
	0    -1   -1   0   
$EndComp
Connection ~ 20150 4450
$Comp
L Device:R_POT_TRIM RV3
U 1 1 5FD7D4C9
P 20000 5150
F 0 "RV3" V 20100 5400 50  0000 C CNN
F 1 "TC33X-2-102" V 19950 5550 50  0000 C CNN
F 2 "Potentiometer_SMD:Potentiometer_Bourns_TC33X_Vertical" H 20000 5150 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/54/tc33-778219.pdf" H 20000 5150 50  0001 C CNN
	1    20000 5150
	0    -1   -1   0   
$EndComp
$Comp
L Device:R_POT_TRIM RV4
U 1 1 5FD7DC16
P 20000 5550
F 0 "RV4" V 20150 5700 50  0000 C CNN
F 1 "TC33X-2-102" V 19900 5500 50  0000 C CNN
F 2 "Potentiometer_SMD:Potentiometer_Bourns_TC33X_Vertical" H 20000 5550 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/54/tc33-778219.pdf" H 20000 5550 50  0001 C CNN
	1    20000 5550
	0    -1   -1   0   
$EndComp
Connection ~ 20150 5550
$Comp
L Device:R_POT_TRIM RV6
U 1 1 5FD7E9C9
P 20000 6650
F 0 "RV6" V 20150 6800 50  0000 C CNN
F 1 "TC33X-2-102" V 19900 6600 50  0000 C CNN
F 2 "Potentiometer_SMD:Potentiometer_Bourns_TC33X_Vertical" H 20000 6650 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/54/tc33-778219.pdf" H 20000 6650 50  0001 C CNN
	1    20000 6650
	0    -1   -1   0   
$EndComp
Connection ~ 20150 6650
$Comp
L Device:R_POT_TRIM RV5
U 1 1 5FD7F2A0
P 20000 6250
F 0 "RV5" V 20100 6500 50  0000 C CNN
F 1 "TC33X-2-102" V 19950 6650 50  0000 C CNN
F 2 "Potentiometer_SMD:Potentiometer_Bourns_TC33X_Vertical" H 20000 6250 50  0001 C CNN
F 3 "https://www.mouser.de/datasheet/2/54/tc33-778219.pdf" H 20000 6250 50  0001 C CNN
	1    20000 6250
	0    -1   -1   0   
$EndComp
Wire Wire Line
	20000 6100 20150 6100
Wire Wire Line
	20150 6100 20150 6250
Connection ~ 20150 6250
Wire Wire Line
	20000 6500 20150 6500
Connection ~ 20150 6500
Wire Wire Line
	20150 6500 20150 6250
Wire Wire Line
	20000 5400 20150 5400
Connection ~ 20150 5400
Wire Wire Line
	20150 5400 20150 5150
Wire Wire Line
	20000 5000 20150 5000
Wire Wire Line
	20150 5000 20150 5150
Connection ~ 20150 5150
Wire Wire Line
	20000 4300 20150 4300
Connection ~ 20150 4300
Wire Wire Line
	20150 4300 20150 4050
Wire Wire Line
	20000 3900 20150 3900
Wire Wire Line
	20150 3900 20150 4050
Connection ~ 20150 4050
$Comp
L Diode:BAS16TW D1
U 1 1 5FE760D6
P 19700 4450
F 0 "D1" H 19850 4350 50  0000 C CNN
F 1 "BAS16TW" V 19900 4600 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-363_SC-70-6" H 19700 4275 50  0001 C CNN
F 3 "http://www.diodes.com/datasheets/ds30154.pdf" H 19700 4550 50  0001 C CNN
	1    19700 4450
	-1   0    0    1   
$EndComp
$Comp
L Diode:BAS16TW D1
U 2 1 5FE78E2D
P 19700 5550
F 0 "D1" H 19950 5450 50  0000 C CNN
F 1 "BAS16TW" V 19900 5750 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-363_SC-70-6" H 19700 5375 50  0001 C CNN
F 3 "http://www.diodes.com/datasheets/ds30154.pdf" H 19700 5650 50  0001 C CNN
	2    19700 5550
	-1   0    0    1   
$EndComp
$Comp
L Diode:BAS16TW D1
U 3 1 5FE7C453
P 19700 6650
F 0 "D1" H 19950 6650 50  0000 C CNN
F 1 "BAS16TW" H 19850 6750 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-363_SC-70-6" H 19700 6475 50  0001 C CNN
F 3 "http://www.diodes.com/datasheets/ds30154.pdf" H 19700 6750 50  0001 C CNN
	3    19700 6650
	-1   0    0    1   
$EndComp
$Comp
L Device:CP C31
U 1 1 5FE890D9
P 1800 4200
F 0 "C31" H 1918 4246 50  0000 L CNN
F 1 "TAJD476M016UNJV" H 1918 4155 50  0000 L CNN
F 2 "Capacitor_Tantalum_SMD:CP_EIA-7343-40_Kemet-Y" H 1838 4050 50  0001 C CNN
F 3 "~" H 1800 4200 50  0001 C CNN
	1    1800 4200
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0171
U 1 1 5FE8AE40
P 1800 4050
F 0 "#PWR0171" H 1800 3900 50  0001 C CNN
F 1 "VCC" V 1815 4177 50  0000 L CNN
F 2 "" H 1800 4050 50  0001 C CNN
F 3 "" H 1800 4050 50  0001 C CNN
	1    1800 4050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0172
U 1 1 5FE8B51C
P 1800 4350
F 0 "#PWR0172" H 1800 4100 50  0001 C CNN
F 1 "GND" V 1805 4222 50  0000 R CNN
F 2 "" H 1800 4350 50  0001 C CNN
F 3 "" H 1800 4350 50  0001 C CNN
	1    1800 4350
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D2
U 1 1 5FEA3864
P 16850 12300
F 0 "D2" H 16843 12045 50  0000 C CNN
F 1 "LED" H 16843 12136 50  0000 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 16850 12300 50  0001 C CNN
F 3 "~" H 16850 12300 50  0001 C CNN
	1    16850 12300
	-1   0    0    1   
$EndComp
$Comp
L Device:R R4
U 1 1 5FEA8E23
P 17150 12300
F 0 "R4" V 16943 12300 50  0000 C CNN
F 1 "R" V 17034 12300 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 17080 12300 50  0001 C CNN
F 3 "~" H 17150 12300 50  0001 C CNN
	1    17150 12300
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0173
U 1 1 5FEABACE
P 17300 12300
F 0 "#PWR0173" H 17300 12050 50  0001 C CNN
F 1 "GND" V 17305 12172 50  0000 R CNN
F 2 "" H 17300 12300 50  0001 C CNN
F 3 "" H 17300 12300 50  0001 C CNN
	1    17300 12300
	0    -1   -1   0   
$EndComp
Wire Wire Line
	16700 12300 16700 12850
Connection ~ 16700 12850
Wire Wire Line
	16700 12850 16350 12850
Text Notes 16900 12450 0    50   ~ 0
5 mA
$Comp
L Device:C C32
U 1 1 6011F6BA
P 14700 13200
F 0 "C32" H 14815 13246 50  0000 L CNN
F 1 "0.1" H 14815 13155 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 14738 13050 50  0001 C CNN
F 3 "~" H 14700 13200 50  0001 C CNN
	1    14700 13200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0175
U 1 1 6011F6C0
P 14700 13350
F 0 "#PWR0175" H 14700 13100 50  0001 C CNN
F 1 "GND" H 14705 13177 50  0000 C CNN
F 2 "" H 14700 13350 50  0001 C CNN
F 3 "" H 14700 13350 50  0001 C CNN
	1    14700 13350
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0174
U 1 1 6011F6C6
P 14700 13050
F 0 "#PWR0174" H 14700 12900 50  0001 C CNN
F 1 "VCC" H 14715 13223 50  0000 C CNN
F 2 "" H 14700 13050 50  0001 C CNN
F 3 "" H 14700 13050 50  0001 C CNN
	1    14700 13050
	1    0    0    -1  
$EndComp
$Comp
L power:GNDA #PWR?
U 1 1 602CF667
P 21250 6300
F 0 "#PWR?" H 21250 6050 50  0001 C CNN
F 1 "GNDA" V 21255 6173 50  0000 R CNN
F 2 "" H 21250 6300 50  0001 C CNN
F 3 "" H 21250 6300 50  0001 C CNN
	1    21250 6300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 602CFE72
P 21500 6300
F 0 "#PWR?" H 21500 6050 50  0001 C CNN
F 1 "GND" H 21505 6127 50  0000 C CNN
F 2 "" H 21500 6300 50  0001 C CNN
F 3 "" H 21500 6300 50  0001 C CNN
	1    21500 6300
	1    0    0    -1  
$EndComp
Wire Wire Line
	21500 6300 21250 6300
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
