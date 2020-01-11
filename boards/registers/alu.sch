EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 6 10
Title "ALU connector"
Date "2020-01-02"
Rev "1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 3250 1450 0    50   Input ~ 0
a[0..7]
Text HLabel 3250 3850 0    50   Input ~ 0
b[0..7]
Text HLabel 3250 2400 0    50   Input ~ 0
op[0..3]
Text HLabel 3150 3150 0    50   Input ~ 0
~oe
Text HLabel 3150 3250 0    50   Input ~ 0
carry_in
Text HLabel 5350 3100 2    50   Input ~ 0
invert
Text HLabel 5350 2900 2    50   3State ~ 0
result[0..7]
Text HLabel 5350 2550 2    50   Output ~ 0
flags[0..3]
$Comp
L Connector_Generic:Conn_02x20_Odd_Even J1
U 1 1 5ED10580
P 4200 2700
F 0 "J1" H 4250 3817 50  0000 C CNN
F 1 "ALU" H 4250 3726 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_2x20_P2.54mm_Horizontal" H 4200 2700 50  0001 C CNN
F 3 "~" H 4200 2700 50  0001 C CNN
	1    4200 2700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0172
U 1 1 5ED17F1D
P 4500 1800
F 0 "#PWR0172" H 4500 1550 50  0001 C CNN
F 1 "GND" V 4505 1672 50  0000 R CNN
F 2 "" H 4500 1800 50  0001 C CNN
F 3 "" H 4500 1800 50  0001 C CNN
	1    4500 1800
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0171
U 1 1 5ED187D7
P 4000 3700
F 0 "#PWR0171" H 4000 3450 50  0001 C CNN
F 1 "GND" V 4005 3572 50  0000 R CNN
F 2 "" H 4000 3700 50  0001 C CNN
F 3 "" H 4000 3700 50  0001 C CNN
	1    4000 3700
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR0170
U 1 1 5ED1982C
P 4000 1800
F 0 "#PWR0170" H 4000 1650 50  0001 C CNN
F 1 "VCC" V 4018 1927 50  0000 L CNN
F 2 "" H 4000 1800 50  0001 C CNN
F 3 "" H 4000 1800 50  0001 C CNN
	1    4000 1800
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR0173
U 1 1 5ED1A175
P 4500 3700
F 0 "#PWR0173" H 4500 3550 50  0001 C CNN
F 1 "VCC" V 4517 3828 50  0000 L CNN
F 2 "" H 4500 3700 50  0001 C CNN
F 3 "" H 4500 3700 50  0001 C CNN
	1    4500 3700
	0    1    1    0   
$EndComp
Entry Wire Line
	3650 3400 3750 3300
Entry Wire Line
	3650 3500 3750 3400
Entry Wire Line
	3650 3600 3750 3500
Entry Wire Line
	3650 3700 3750 3600
Entry Wire Line
	3600 3000 3700 2900
Entry Wire Line
	3600 3100 3700 3000
Entry Wire Line
	3600 3200 3700 3100
Entry Wire Line
	3600 3300 3700 3200
Wire Wire Line
	3750 3300 4000 3300
Wire Wire Line
	4000 3400 3750 3400
Wire Wire Line
	3750 3500 4000 3500
Wire Wire Line
	4000 3600 3750 3600
Entry Wire Line
	4950 3300 5050 3200
Entry Wire Line
	4950 3400 5050 3300
Entry Wire Line
	4950 3500 5050 3400
Entry Wire Line
	4950 3600 5050 3500
Entry Wire Line
	4950 2900 5050 2800
Entry Wire Line
	4950 3000 5050 2900
Entry Wire Line
	4950 3100 5050 3000
Entry Wire Line
	4950 3200 5050 3100
Text Label 3800 3300 0    50   ~ 0
a0
Text Label 3800 3400 0    50   ~ 0
a2
Text Label 3800 3500 0    50   ~ 0
a4
Text Label 3800 3600 0    50   ~ 0
a6
Text Label 4650 3300 0    50   ~ 0
a1
Text Label 4650 3400 0    50   ~ 0
a3
Text Label 4650 3500 0    50   ~ 0
a5
Text Label 4650 3600 0    50   ~ 0
a7
Wire Wire Line
	4500 2900 4950 2900
Wire Wire Line
	4500 3000 4950 3000
Wire Wire Line
	4500 3100 4950 3100
Wire Wire Line
	4500 3200 4950 3200
Wire Wire Line
	3700 2900 4000 2900
Wire Wire Line
	4000 3000 3700 3000
Wire Wire Line
	3700 3100 4000 3100
Wire Wire Line
	4000 3200 3700 3200
Text Label 3800 2900 0    50   ~ 0
b0
Text Label 3800 3100 0    50   ~ 0
b2
Text Label 4650 2900 0    50   ~ 0
b4
Text Label 4650 3100 0    50   ~ 0
b6
Text Label 3800 3000 0    50   ~ 0
b1
Text Label 3800 3200 0    50   ~ 0
b3
Text Label 4650 3000 0    50   ~ 0
b5
Text Label 4650 3200 0    50   ~ 0
b7
Entry Wire Line
	1850 1900 1950 1800
Entry Wire Line
	1850 2000 1950 1900
Entry Wire Line
	2800 1900 2900 1800
Entry Wire Line
	2800 2000 2900 1900
Wire Wire Line
	2800 1900 2350 1900
Wire Wire Line
	2350 2000 2800 2000
Text Label 2450 1900 0    50   ~ 0
op1
Text Label 2450 2000 0    50   ~ 0
op3
Wire Wire Line
	1950 1800 2200 1800
Wire Wire Line
	2200 1900 1950 1900
Text Label 2000 1800 0    50   ~ 0
op0
Text Label 2000 1900 0    50   ~ 0
op2
Entry Wire Line
	1800 2100 1900 2000
Entry Wire Line
	1800 2200 1900 2100
Entry Wire Line
	2800 2100 2900 2000
Entry Wire Line
	2800 2200 2900 2100
Wire Wire Line
	2800 2100 2350 2100
Wire Wire Line
	2350 2200 2800 2200
Text Label 1950 2000 0    50   ~ 0
flags0
Text Label 1950 2100 0    50   ~ 0
flags2
Text Label 2450 2100 0    50   ~ 0
flags1
Text Label 2450 2200 0    50   ~ 0
flags3
Text Label 1600 3650 0    50   ~ 0
result7
Text Label 1600 3550 0    50   ~ 0
result5
Text Label 1600 3450 0    50   ~ 0
result3
Text Label 1600 3350 0    50   ~ 0
result1
Wire Wire Line
	1500 3650 1950 3650
Wire Wire Line
	1950 3550 1500 3550
Wire Wire Line
	1500 3450 1950 3450
Wire Wire Line
	1950 3350 1500 3350
Entry Wire Line
	1950 3350 2050 3250
Entry Wire Line
	1950 3450 2050 3350
Entry Wire Line
	1950 3550 2050 3450
Entry Wire Line
	1950 3650 2050 3550
Entry Wire Line
	1800 2800 1900 2700
Entry Wire Line
	1800 2700 1900 2600
Entry Wire Line
	1800 2400 1900 2300
Entry Wire Line
	1800 2300 1900 2200
Wire Wire Line
	2200 2700 1900 2700
Wire Wire Line
	1900 2600 2200 2600
Wire Wire Line
	2200 2300 1900 2300
Wire Wire Line
	1900 2200 2200 2200
Text Label 1950 2200 0    50   ~ 0
result0
Text Label 1950 2300 0    50   ~ 0
result2
Text Label 1950 2600 0    50   ~ 0
result4
Text Label 1950 2700 0    50   ~ 0
result6
Wire Wire Line
	1900 2000 2200 2000
Wire Wire Line
	1900 2100 2200 2100
Wire Wire Line
	2350 3750 1500 3750
Wire Wire Line
	4500 3300 4950 3300
Wire Wire Line
	4500 3400 4950 3400
Wire Wire Line
	4500 3500 4950 3500
Wire Wire Line
	4500 3600 4950 3600
$EndSCHEMATC
