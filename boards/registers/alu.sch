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
	3650 2000 3750 1900
Entry Wire Line
	3650 2100 3750 2000
Entry Wire Line
	3650 2200 3750 2100
Entry Wire Line
	3650 2300 3750 2200
Entry Wire Line
	3600 3400 3700 3300
Entry Wire Line
	3600 3500 3700 3400
Entry Wire Line
	3600 3600 3700 3500
Entry Wire Line
	3600 3700 3700 3600
Wire Wire Line
	3750 1900 4000 1900
Wire Wire Line
	4000 2000 3750 2000
Wire Wire Line
	3750 2100 4000 2100
Wire Wire Line
	4000 2200 3750 2200
Entry Wire Line
	4850 1900 4950 1800
Entry Wire Line
	4850 2000 4950 1900
Entry Wire Line
	4850 2100 4950 2000
Entry Wire Line
	4850 2200 4950 2100
Entry Wire Line
	4950 3300 5050 3200
Entry Wire Line
	4950 3400 5050 3300
Entry Wire Line
	4950 3500 5050 3400
Entry Wire Line
	4950 3600 5050 3500
Wire Wire Line
	4500 1900 4850 1900
Wire Wire Line
	4850 2000 4500 2000
Wire Wire Line
	4500 2100 4850 2100
Wire Wire Line
	4850 2200 4500 2200
Text Label 3800 1900 0    50   ~ 0
a0
Text Label 3800 2000 0    50   ~ 0
a2
Text Label 3800 2100 0    50   ~ 0
a4
Text Label 3800 2200 0    50   ~ 0
a6
Text Label 4650 1900 0    50   ~ 0
a1
Text Label 4650 2000 0    50   ~ 0
a3
Text Label 4650 2100 0    50   ~ 0
a5
Text Label 4650 2200 0    50   ~ 0
a7
Wire Wire Line
	4500 3300 4950 3300
Wire Wire Line
	4500 3400 4950 3400
Wire Wire Line
	4500 3500 4950 3500
Wire Wire Line
	4500 3600 4950 3600
Wire Wire Line
	3700 3300 4000 3300
Wire Wire Line
	4000 3400 3700 3400
Wire Wire Line
	3700 3500 4000 3500
Wire Wire Line
	4000 3600 3700 3600
Text Label 3800 3300 0    50   ~ 0
b0
Text Label 3800 3400 0    50   ~ 0
b2
Text Label 3800 3500 0    50   ~ 0
b4
Text Label 3800 3600 0    50   ~ 0
b6
Text Label 4650 3300 0    50   ~ 0
b1
Text Label 4650 3400 0    50   ~ 0
b3
Text Label 4650 3500 0    50   ~ 0
b5
Text Label 4650 3600 0    50   ~ 0
b7
Entry Wire Line
	3650 2400 3750 2300
Entry Wire Line
	3650 2500 3750 2400
Entry Wire Line
	4950 2300 5050 2200
Entry Wire Line
	4950 2400 5050 2300
Wire Wire Line
	4950 2300 4500 2300
Wire Wire Line
	4500 2400 4950 2400
Text Label 4600 2300 0    50   ~ 0
op1
Text Label 4600 2400 0    50   ~ 0
op3
Wire Wire Line
	3750 2300 4000 2300
Wire Wire Line
	4000 2400 3750 2400
Text Label 3800 2300 0    50   ~ 0
op0
Text Label 3800 2400 0    50   ~ 0
op2
Entry Wire Line
	3600 2600 3700 2500
Entry Wire Line
	3600 2700 3700 2600
Entry Wire Line
	4950 2500 5050 2400
Entry Wire Line
	4950 2600 5050 2500
Wire Wire Line
	4950 2500 4500 2500
Wire Wire Line
	4500 2600 4950 2600
Text Label 3750 2500 0    50   ~ 0
flags0
Text Label 3750 2600 0    50   ~ 0
flags2
Text Label 4600 2500 0    50   ~ 0
flags1
Text Label 4600 2600 0    50   ~ 0
flags3
Text Label 4600 3000 0    50   ~ 0
result7
Text Label 4600 2900 0    50   ~ 0
result5
Text Label 4600 2800 0    50   ~ 0
result3
Text Label 4600 2700 0    50   ~ 0
result1
Wire Wire Line
	4500 3000 4950 3000
Wire Wire Line
	4950 2900 4500 2900
Wire Wire Line
	4500 2800 4950 2800
Wire Wire Line
	4950 2700 4500 2700
Entry Wire Line
	4950 2700 5050 2600
Entry Wire Line
	4950 2800 5050 2700
Entry Wire Line
	4950 2900 5050 2800
Entry Wire Line
	4950 3000 5050 2900
Entry Wire Line
	3600 3100 3700 3000
Entry Wire Line
	3600 3000 3700 2900
Entry Wire Line
	3600 2900 3700 2800
Entry Wire Line
	3600 2800 3700 2700
Wire Wire Line
	4000 3000 3700 3000
Wire Wire Line
	3700 2900 4000 2900
Wire Wire Line
	4000 2800 3700 2800
Wire Wire Line
	3700 2700 4000 2700
Text Label 3750 2700 0    50   ~ 0
result0
Text Label 3750 2800 0    50   ~ 0
result2
Text Label 3750 2900 0    50   ~ 0
result4
Text Label 3750 3000 0    50   ~ 0
result6
Wire Wire Line
	3700 2500 4000 2500
Wire Wire Line
	3700 2600 4000 2600
Wire Bus Line
	4950 1450 3650 1450
Wire Bus Line
	3250 1450 3650 1450
Connection ~ 3650 1450
Wire Bus Line
	3250 3850 3600 3850
Wire Bus Line
	5050 3850 3600 3850
Connection ~ 3600 3850
Wire Bus Line
	5050 1350 3550 1350
Wire Bus Line
	3550 1350 3550 2400
Wire Bus Line
	3550 2400 3650 2400
Wire Bus Line
	3650 2400 3650 2500
Wire Bus Line
	3250 2400 3550 2400
Connection ~ 3550 2400
Wire Bus Line
	3600 3100 3500 3100
Wire Bus Line
	3500 3100 3500 3950
Wire Bus Line
	3500 3950 5150 3950
Wire Bus Line
	5150 3950 5150 2900
Wire Bus Line
	5150 2900 5050 2900
Wire Bus Line
	5350 2900 5150 2900
Connection ~ 5150 2900
Wire Bus Line
	3600 2600 3600 2700
Wire Bus Line
	3600 2700 3400 2700
Wire Bus Line
	3400 2700 3400 4050
Wire Bus Line
	3400 4050 5250 4050
Wire Bus Line
	5250 4050 5250 2550
Wire Bus Line
	5250 2550 5350 2550
Wire Bus Line
	5250 2550 5050 2550
Connection ~ 5250 2550
Wire Wire Line
	3150 3150 3800 3150
Wire Wire Line
	3800 3150 3800 3100
Wire Wire Line
	3800 3100 4000 3100
Wire Wire Line
	3150 3250 3700 3250
Wire Wire Line
	3700 3250 3700 3200
Wire Wire Line
	3700 3200 4000 3200
Wire Wire Line
	5350 3100 4500 3100
NoConn ~ 4500 3200
Wire Bus Line
	5050 1350 5050 2300
Wire Bus Line
	5050 2400 5050 2550
Wire Bus Line
	5050 2600 5050 2900
Wire Bus Line
	3600 2800 3600 3100
Wire Bus Line
	4950 1450 4950 2100
Wire Bus Line
	3650 1450 3650 2300
Wire Bus Line
	3600 3400 3600 3850
Wire Bus Line
	5050 3200 5050 3850
$EndSCHEMATC
