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
Text HLabel 4500 3300 2    50   Input ~ 0
~oe
Text HLabel 4000 3400 0    50   Input ~ 0
carry_in
Text HLabel 4000 3300 0    50   Input ~ 0
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
F 1 "SSW-120-02-G-D-RA" H 4250 3726 50  0000 C CNN
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
Wire Wire Line
	3750 2700 4000 2700
Wire Wire Line
	4000 2800 3750 2800
Wire Wire Line
	3750 2900 4000 2900
Wire Wire Line
	4000 3000 3750 3000
Text Label 3800 2700 0    50   ~ 0
a0
Text Label 3800 2800 0    50   ~ 0
a2
Text Label 3800 2900 0    50   ~ 0
a4
Text Label 3800 3000 0    50   ~ 0
a6
Text Label 4650 2700 0    50   ~ 0
a1
Text Label 4650 2800 0    50   ~ 0
a3
Text Label 4650 2900 0    50   ~ 0
a5
Text Label 4650 3000 0    50   ~ 0
a7
Wire Wire Line
	4500 1900 4950 1900
Wire Wire Line
	4500 2000 4950 2000
Wire Wire Line
	4500 2100 4950 2100
Wire Wire Line
	4500 2200 4950 2200
Wire Wire Line
	3700 1900 4000 1900
Wire Wire Line
	4000 2000 3700 2000
Wire Wire Line
	3700 2100 4000 2100
Wire Wire Line
	4000 2200 3700 2200
Text Label 3800 1900 0    50   ~ 0
b0
Text Label 3800 2100 0    50   ~ 0
b2
Text Label 4650 1900 0    50   ~ 0
b4
Text Label 4650 2100 0    50   ~ 0
b6
Text Label 3800 2000 0    50   ~ 0
b1
Text Label 3800 2200 0    50   ~ 0
b3
Text Label 4650 2000 0    50   ~ 0
b5
Text Label 4650 2200 0    50   ~ 0
b7
Wire Wire Line
	4950 3100 4500 3100
Wire Wire Line
	4500 3200 4950 3200
Text Label 4600 3100 0    50   ~ 0
op1
Text Label 4600 3200 0    50   ~ 0
op3
Wire Wire Line
	3750 3100 4000 3100
Wire Wire Line
	4000 3200 3750 3200
Text Label 3800 3100 0    50   ~ 0
op0
Text Label 3800 3200 0    50   ~ 0
op2
Wire Wire Line
	4950 3500 4500 3500
Wire Wire Line
	4500 3600 4950 3600
Text Label 3750 3500 0    50   ~ 0
flags0
Text Label 3750 3600 0    50   ~ 0
flags2
Text Label 4600 3500 0    50   ~ 0
flags1
Text Label 4600 3600 0    50   ~ 0
flags3
Wire Wire Line
	4000 2600 3700 2600
Wire Wire Line
	3700 2500 4000 2500
Wire Wire Line
	4000 2400 3700 2400
Wire Wire Line
	3700 2300 4000 2300
Text Label 3750 2300 0    50   ~ 0
result0
Text Label 3750 2400 0    50   ~ 0
result2
Text Label 3750 2500 0    50   ~ 0
result4
Text Label 3750 2600 0    50   ~ 0
result6
Wire Wire Line
	3700 3600 4000 3600
Wire Wire Line
	4500 2700 4950 2700
Wire Wire Line
	4500 2800 4950 2800
Wire Wire Line
	4500 2900 4950 2900
Wire Wire Line
	4500 3000 4950 3000
Wire Wire Line
	4950 2300 4500 2300
Wire Wire Line
	4500 2400 4950 2400
Wire Wire Line
	4950 2500 4500 2500
Wire Wire Line
	4500 2600 4950 2600
Text Label 4600 2300 0    50   ~ 0
result1
Text Label 4600 2400 0    50   ~ 0
result3
Text Label 4600 2500 0    50   ~ 0
result5
Text Label 4600 2600 0    50   ~ 0
result7
Wire Wire Line
	4000 3500 3700 3500
NoConn ~ 4500 3400
$EndSCHEMATC
