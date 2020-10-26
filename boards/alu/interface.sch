EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 2
Title ""
Date ""
Rev ""
Comp ""
Comment1 "Licensed under the TAPR Open Hardware License (www.tapr.org/OHL)"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 4300 2050 0    50   Output ~ 0
a[0..7]
Text HLabel 4300 4450 0    50   Output ~ 0
b[0..7]
Text HLabel 4300 3000 0    50   Output ~ 0
op[0..3]
Text HLabel 5550 3900 2    50   Output ~ 0
~oe
Text HLabel 5050 4000 0    50   Output ~ 0
carry_in
Text HLabel 5050 3900 0    50   Output ~ 0
invert
Text HLabel 6400 3500 2    50   3State ~ 0
result[0..7]
Text HLabel 6400 3150 2    50   Input ~ 0
flags[0..3]
$Comp
L Connector_Generic:Conn_02x20_Odd_Even J?
U 1 1 5FC3FB3E
P 5250 3300
AR Path="/5FC3D0C1/5FC3FB3E" Ref="J?"  Part="1" 
AR Path="/5FC3F1F0/5FC3FB3E" Ref="J1"  Part="1" 
F 0 "J1" H 5300 4417 50  0000 C CNN
F 1 "61304021021" H 5300 4326 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x20_P2.54mm_Horizontal" H 5250 3300 50  0001 C CNN
F 3 "~" H 5250 3300 50  0001 C CNN
	1    5250 3300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FC3FB44
P 5550 2400
AR Path="/5FC3D0C1/5FC3FB44" Ref="#PWR?"  Part="1" 
AR Path="/5FC3F1F0/5FC3FB44" Ref="#PWR025"  Part="1" 
F 0 "#PWR025" H 5550 2150 50  0001 C CNN
F 1 "GND" V 5555 2272 50  0000 R CNN
F 2 "" H 5550 2400 50  0001 C CNN
F 3 "" H 5550 2400 50  0001 C CNN
	1    5550 2400
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FC3FB4A
P 5050 4300
AR Path="/5FC3D0C1/5FC3FB4A" Ref="#PWR?"  Part="1" 
AR Path="/5FC3F1F0/5FC3FB4A" Ref="#PWR024"  Part="1" 
F 0 "#PWR024" H 5050 4050 50  0001 C CNN
F 1 "GND" V 5055 4172 50  0000 R CNN
F 2 "" H 5050 4300 50  0001 C CNN
F 3 "" H 5050 4300 50  0001 C CNN
	1    5050 4300
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5FC3FB50
P 5050 2400
AR Path="/5FC3D0C1/5FC3FB50" Ref="#PWR?"  Part="1" 
AR Path="/5FC3F1F0/5FC3FB50" Ref="#PWR023"  Part="1" 
F 0 "#PWR023" H 5050 2250 50  0001 C CNN
F 1 "VCC" V 5068 2527 50  0000 L CNN
F 2 "" H 5050 2400 50  0001 C CNN
F 3 "" H 5050 2400 50  0001 C CNN
	1    5050 2400
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5FC3FB56
P 5550 4300
AR Path="/5FC3D0C1/5FC3FB56" Ref="#PWR?"  Part="1" 
AR Path="/5FC3F1F0/5FC3FB56" Ref="#PWR026"  Part="1" 
F 0 "#PWR026" H 5550 4150 50  0001 C CNN
F 1 "VCC" V 5567 4428 50  0000 L CNN
F 2 "" H 5550 4300 50  0001 C CNN
F 3 "" H 5550 4300 50  0001 C CNN
	1    5550 4300
	0    1    1    0   
$EndComp
Wire Wire Line
	4800 3300 5050 3300
Wire Wire Line
	5050 3400 4800 3400
Wire Wire Line
	4800 3500 5050 3500
Wire Wire Line
	5050 3600 4800 3600
Text Label 4850 3300 0    50   ~ 0
a0
Text Label 4850 3400 0    50   ~ 0
a2
Text Label 4850 3500 0    50   ~ 0
a4
Text Label 4850 3600 0    50   ~ 0
a6
Text Label 5700 3300 0    50   ~ 0
a1
Text Label 5700 3400 0    50   ~ 0
a3
Text Label 5700 3500 0    50   ~ 0
a5
Text Label 5700 3600 0    50   ~ 0
a7
Wire Wire Line
	5550 2500 6000 2500
Wire Wire Line
	5550 2600 6000 2600
Wire Wire Line
	5550 2700 6000 2700
Wire Wire Line
	5550 2800 6000 2800
Wire Wire Line
	4750 2500 5050 2500
Wire Wire Line
	5050 2600 4750 2600
Wire Wire Line
	4750 2700 5050 2700
Wire Wire Line
	5050 2800 4750 2800
Text Label 4850 2500 0    50   ~ 0
b0
Text Label 4850 2700 0    50   ~ 0
b2
Text Label 5700 2500 0    50   ~ 0
b4
Text Label 5700 2700 0    50   ~ 0
b6
Text Label 4850 2600 0    50   ~ 0
b1
Text Label 4850 2800 0    50   ~ 0
b3
Text Label 5700 2600 0    50   ~ 0
b5
Text Label 5700 2800 0    50   ~ 0
b7
Wire Wire Line
	6000 3700 5550 3700
Wire Wire Line
	5550 3800 6000 3800
Text Label 5650 3700 0    50   ~ 0
op1
Text Label 5650 3800 0    50   ~ 0
op3
Wire Wire Line
	4800 3700 5050 3700
Wire Wire Line
	5050 3800 4800 3800
Text Label 4850 3700 0    50   ~ 0
op0
Text Label 4850 3800 0    50   ~ 0
op2
Wire Wire Line
	6000 4100 5550 4100
Wire Wire Line
	5550 4200 6000 4200
Text Label 4800 4100 0    50   ~ 0
flags0
Text Label 4800 4200 0    50   ~ 0
flags2
Text Label 5650 4100 0    50   ~ 0
flags1
Text Label 5650 4200 0    50   ~ 0
flags3
Wire Wire Line
	5050 3200 4750 3200
Wire Wire Line
	4750 3100 5050 3100
Wire Wire Line
	5050 3000 4750 3000
Wire Wire Line
	4750 2900 5050 2900
Text Label 4800 2900 0    50   ~ 0
result0
Text Label 4800 3000 0    50   ~ 0
result2
Text Label 4800 3100 0    50   ~ 0
result4
Text Label 4800 3200 0    50   ~ 0
result6
Wire Wire Line
	4750 4200 5050 4200
Wire Wire Line
	5550 3300 6000 3300
Wire Wire Line
	5550 3400 6000 3400
Wire Wire Line
	5550 3500 6000 3500
Wire Wire Line
	5550 3600 6000 3600
Wire Wire Line
	6000 2900 5550 2900
Wire Wire Line
	5550 3000 6000 3000
Wire Wire Line
	6000 3100 5550 3100
Wire Wire Line
	5550 3200 6000 3200
Text Label 5650 2900 0    50   ~ 0
result1
Text Label 5650 3000 0    50   ~ 0
result3
Text Label 5650 3100 0    50   ~ 0
result5
Text Label 5650 3200 0    50   ~ 0
result7
Wire Wire Line
	5050 4100 4750 4100
NoConn ~ 5550 4000
$Comp
L power:GND #PWR?
U 1 1 5FC8BB37
P 6950 2400
AR Path="/5FC3D0C1/5FC8BB37" Ref="#PWR?"  Part="1" 
AR Path="/5FC3F1F0/5FC8BB37" Ref="#PWR027"  Part="1" 
F 0 "#PWR027" H 6950 2150 50  0001 C CNN
F 1 "GND" V 6955 2272 50  0000 R CNN
F 2 "" H 6950 2400 50  0001 C CNN
F 3 "" H 6950 2400 50  0001 C CNN
	1    6950 2400
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5FC8BE39
P 7200 2400
AR Path="/5FC3D0C1/5FC8BE39" Ref="#PWR?"  Part="1" 
AR Path="/5FC3F1F0/5FC8BE39" Ref="#PWR028"  Part="1" 
F 0 "#PWR028" H 7200 2250 50  0001 C CNN
F 1 "VCC" V 7218 2527 50  0000 L CNN
F 2 "" H 7200 2400 50  0001 C CNN
F 3 "" H 7200 2400 50  0001 C CNN
	1    7200 2400
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG02
U 1 1 5FC8C967
P 7200 2400
F 0 "#FLG02" H 7200 2475 50  0001 C CNN
F 1 "PWR_FLAG" H 7200 2573 50  0000 C CNN
F 2 "" H 7200 2400 50  0001 C CNN
F 3 "~" H 7200 2400 50  0001 C CNN
	1    7200 2400
	-1   0    0    1   
$EndComp
$Comp
L power:PWR_FLAG #FLG01
U 1 1 5FC8CEFB
P 6950 2400
F 0 "#FLG01" H 6950 2475 50  0001 C CNN
F 1 "PWR_FLAG" H 6950 2573 50  0000 C CNN
F 2 "" H 6950 2400 50  0001 C CNN
F 3 "~" H 6950 2400 50  0001 C CNN
	1    6950 2400
	1    0    0    -1  
$EndComp
$EndSCHEMATC
