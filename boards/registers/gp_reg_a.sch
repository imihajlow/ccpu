EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 7 8
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 1650 2100 0    50   Input ~ 0
w_clk
Text HLabel 1650 2200 0    50   Input ~ 0
~rst
Text HLabel 1650 1000 0    50   Input ~ 0
di[0..7]
Text HLabel 9700 1000 2    50   3State ~ 0
doa[0..7]
Text HLabel 9700 3150 2    50   3State ~ 0
dob[0..7]
$Comp
L 74xx:74HC244 U?
U 1 1 5EA6BD49
P 7250 1700
AR Path="/5E73B7F6/5EA6BD49" Ref="U?"  Part="1" 
AR Path="/5E7CA397/5EA6BD49" Ref="U?"  Part="1" 
AR Path="/5E9FD18D/5EA6BD49" Ref="U?"  Part="1" 
F 0 "U?" H 7600 1150 50  0000 C CNN
F 1 "74ACT244" H 7550 1050 50  0000 C CNN
F 2 "" H 7250 1700 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT244.pdf" H 7250 1700 50  0001 C CNN
	1    7250 1700
	1    0    0    -1  
$EndComp
Entry Wire Line
	6400 1300 6500 1200
Entry Wire Line
	6400 1400 6500 1300
Entry Wire Line
	6400 1500 6500 1400
Entry Wire Line
	6400 1600 6500 1500
Entry Wire Line
	6400 1700 6500 1600
Entry Wire Line
	6400 1800 6500 1700
Entry Wire Line
	6400 1900 6500 1800
Entry Wire Line
	6400 2000 6500 1900
Wire Wire Line
	6500 1900 6750 1900
Wire Wire Line
	6750 1800 6500 1800
Wire Wire Line
	6500 1700 6750 1700
Wire Wire Line
	6750 1600 6500 1600
Wire Wire Line
	6500 1500 6750 1500
Wire Wire Line
	6750 1400 6500 1400
Wire Wire Line
	6500 1300 6750 1300
Wire Wire Line
	6750 1200 6500 1200
Entry Wire Line
	8350 1200 8450 1100
Entry Wire Line
	8350 1300 8450 1200
Entry Wire Line
	8350 1400 8450 1300
Entry Wire Line
	8350 1500 8450 1400
Entry Wire Line
	8350 1600 8450 1500
Entry Wire Line
	8350 1700 8450 1600
Entry Wire Line
	8350 1800 8450 1700
Entry Wire Line
	8350 1900 8450 1800
Wire Wire Line
	8350 1200 8050 1200
Wire Wire Line
	8050 1300 8350 1300
Wire Wire Line
	8350 1400 8050 1400
Wire Wire Line
	8050 1500 8350 1500
Wire Wire Line
	8350 1600 8050 1600
Wire Wire Line
	8050 1700 8350 1700
Wire Wire Line
	8350 1800 8050 1800
Wire Wire Line
	8050 1900 8350 1900
Text Label 6500 1200 0    50   ~ 0
d0
Text Label 6500 1300 0    50   ~ 0
d1
Text Label 6500 1400 0    50   ~ 0
d2
Text Label 6500 1500 0    50   ~ 0
d3
Text Label 6500 1600 0    50   ~ 0
d4
Text Label 6500 1700 0    50   ~ 0
d5
Text Label 6500 1800 0    50   ~ 0
d6
Text Label 6500 1900 0    50   ~ 0
d7
$Comp
L power:GND #PWR?
U 1 1 5EA6BD77
P 7250 2500
AR Path="/5E73B7F6/5EA6BD77" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5EA6BD77" Ref="#PWR?"  Part="1" 
AR Path="/5E9FD18D/5EA6BD77" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 7250 2250 50  0001 C CNN
F 1 "GND" H 7255 2327 50  0000 C CNN
F 2 "" H 7250 2500 50  0001 C CNN
F 3 "" H 7250 2500 50  0001 C CNN
	1    7250 2500
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5EA6BD7D
P 7250 900
AR Path="/5E73B7F6/5EA6BD7D" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5EA6BD7D" Ref="#PWR?"  Part="1" 
AR Path="/5E9FD18D/5EA6BD7D" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 7250 750 50  0001 C CNN
F 1 "VCC" H 7267 1073 50  0000 C CNN
F 2 "" H 7250 900 50  0001 C CNN
F 3 "" H 7250 900 50  0001 C CNN
	1    7250 900 
	1    0    0    -1  
$EndComp
Entry Wire Line
	6400 3500 6500 3400
Entry Wire Line
	6400 3600 6500 3500
Entry Wire Line
	6400 3700 6500 3600
Entry Wire Line
	6400 3800 6500 3700
Entry Wire Line
	6400 3900 6500 3800
Entry Wire Line
	6400 4000 6500 3900
Entry Wire Line
	6400 4100 6500 4000
Entry Wire Line
	6400 4200 6500 4100
Entry Wire Line
	7050 3400 7150 3300
Entry Wire Line
	7050 3500 7150 3400
Entry Wire Line
	7050 3600 7150 3500
Entry Wire Line
	7050 3700 7150 3600
Entry Wire Line
	7050 3800 7150 3700
Entry Wire Line
	7050 3900 7150 3800
Entry Wire Line
	7050 4000 7150 3900
Entry Wire Line
	7050 4100 7150 4000
Text Label 6500 3400 0    50   ~ 0
d0
Text Label 6500 3500 0    50   ~ 0
d1
Text Label 6500 3600 0    50   ~ 0
d2
Text Label 6500 3700 0    50   ~ 0
d3
Text Label 6500 3800 0    50   ~ 0
d4
Text Label 6500 3900 0    50   ~ 0
d5
Text Label 6500 4000 0    50   ~ 0
d6
Text Label 6500 4100 0    50   ~ 0
d7
Text Label 6400 2650 0    50   ~ 0
d[0..7]
Text Label 8100 1200 0    50   ~ 0
doa0
Text Label 8100 1300 0    50   ~ 0
doa1
Text Label 8100 1400 0    50   ~ 0
doa2
Text Label 8100 1500 0    50   ~ 0
doa3
Text Label 8100 1600 0    50   ~ 0
doa4
Text Label 8100 1700 0    50   ~ 0
doa5
Text Label 8100 1800 0    50   ~ 0
doa6
Text Label 8100 1900 0    50   ~ 0
doa7
Text Label 6800 3400 0    50   ~ 0
dob0
Text Label 6800 3500 0    50   ~ 0
dob1
Text Label 6800 3600 0    50   ~ 0
dob2
Text Label 6800 3700 0    50   ~ 0
dob3
Text Label 6800 3800 0    50   ~ 0
dob4
Text Label 6800 3900 0    50   ~ 0
dob5
Text Label 6800 4000 0    50   ~ 0
dob6
Text Label 6800 4100 0    50   ~ 0
dob7
Wire Bus Line
	9700 1000 8450 1000
$Comp
L 74xx:74HCT273 U?
U 1 1 5EA6BDD0
P 4750 1700
AR Path="/5E73B7F6/5EA6BDD0" Ref="U?"  Part="1" 
AR Path="/5E7CA397/5EA6BDD0" Ref="U?"  Part="1" 
AR Path="/5E9FD18D/5EA6BDD0" Ref="U?"  Part="1" 
F 0 "U?" H 5100 1150 50  0000 C CNN
F 1 "74AC273" H 5100 1050 50  0000 C CNN
F 2 "" H 4750 1700 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT273.pdf" H 4750 1700 50  0001 C CNN
	1    4750 1700
	1    0    0    -1  
$EndComp
Entry Wire Line
	5450 1200 5550 1100
Entry Wire Line
	5450 1300 5550 1200
Entry Wire Line
	5450 1400 5550 1300
Entry Wire Line
	5450 1500 5550 1400
Entry Wire Line
	5450 1600 5550 1500
Entry Wire Line
	5450 1700 5550 1600
Entry Wire Line
	5450 1800 5550 1700
Entry Wire Line
	5450 1900 5550 1800
Wire Wire Line
	5450 1900 5250 1900
Wire Wire Line
	5250 1800 5450 1800
Wire Wire Line
	5450 1700 5250 1700
Wire Wire Line
	5250 1600 5450 1600
Wire Wire Line
	5450 1500 5250 1500
Wire Wire Line
	5250 1400 5450 1400
Wire Wire Line
	5450 1300 5250 1300
Wire Wire Line
	5250 1200 5450 1200
Text Label 5300 1200 0    50   ~ 0
d0
Text Label 5300 1300 0    50   ~ 0
d1
Text Label 5300 1400 0    50   ~ 0
d2
Text Label 5300 1500 0    50   ~ 0
d3
Text Label 5300 1600 0    50   ~ 0
d4
Text Label 5300 1700 0    50   ~ 0
d5
Text Label 5300 1800 0    50   ~ 0
d6
Text Label 5300 1900 0    50   ~ 0
d7
Wire Bus Line
	5550 900  6400 900 
$Comp
L power:GND #PWR?
U 1 1 5EA6BDEF
P 4750 2500
AR Path="/5E73B7F6/5EA6BDEF" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5EA6BDEF" Ref="#PWR?"  Part="1" 
AR Path="/5E9FD18D/5EA6BDEF" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 4750 2250 50  0001 C CNN
F 1 "GND" H 4755 2327 50  0000 C CNN
F 2 "" H 4750 2500 50  0001 C CNN
F 3 "" H 4750 2500 50  0001 C CNN
	1    4750 2500
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5EA6BDF5
P 4750 900
AR Path="/5E73B7F6/5EA6BDF5" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5EA6BDF5" Ref="#PWR?"  Part="1" 
AR Path="/5E9FD18D/5EA6BDF5" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 4750 750 50  0001 C CNN
F 1 "VCC" H 4767 1073 50  0000 C CNN
F 2 "" H 4750 900 50  0001 C CNN
F 3 "" H 4750 900 50  0001 C CNN
	1    4750 900 
	1    0    0    -1  
$EndComp
Entry Wire Line
	5450 3300 5550 3200
Entry Wire Line
	5450 3400 5550 3300
Entry Wire Line
	5450 3500 5550 3400
Entry Wire Line
	5450 3600 5550 3500
Entry Wire Line
	5450 3700 5550 3600
Entry Wire Line
	5450 3800 5550 3700
Entry Wire Line
	5450 3900 5550 3800
Entry Wire Line
	5450 4000 5550 3900
Wire Wire Line
	5450 4000 5250 4000
Wire Wire Line
	5250 3900 5450 3900
Wire Wire Line
	5450 3800 5250 3800
Wire Wire Line
	5250 3700 5450 3700
Wire Wire Line
	5450 3600 5250 3600
Wire Wire Line
	5250 3500 5450 3500
Wire Wire Line
	5450 3400 5250 3400
Wire Wire Line
	5250 3300 5450 3300
Text Label 5300 3300 0    50   ~ 0
d0
Text Label 5300 3400 0    50   ~ 0
d1
Text Label 5300 3500 0    50   ~ 0
d2
Text Label 5300 3600 0    50   ~ 0
d3
Text Label 5300 3700 0    50   ~ 0
d4
Text Label 5300 3800 0    50   ~ 0
d5
Text Label 5300 3900 0    50   ~ 0
d6
Text Label 5300 4000 0    50   ~ 0
d7
$Comp
L Device:LED D?
U 1 1 5EA6BE13
P 5100 3300
AR Path="/5E73B7F6/5EA6BE13" Ref="D?"  Part="1" 
AR Path="/5E7CA397/5EA6BE13" Ref="D?"  Part="1" 
AR Path="/5E9FD18D/5EA6BE13" Ref="D?"  Part="1" 
F 0 "D?" H 4150 3300 50  0000 C CNN
F 1 "LED" H 5093 3425 50  0001 C CNN
F 2 "" H 5100 3300 50  0001 C CNN
F 3 "~" H 5100 3300 50  0001 C CNN
	1    5100 3300
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5EA6BE19
P 4800 3300
AR Path="/5E73B7F6/5EA6BE19" Ref="R?"  Part="1" 
AR Path="/5E7CA397/5EA6BE19" Ref="R?"  Part="1" 
AR Path="/5E9FD18D/5EA6BE19" Ref="R?"  Part="1" 
F 0 "R?" V 4800 2100 50  0000 C CNN
F 1 "LED" V 4800 2450 50  0000 C CNN
F 2 "" V 4730 3300 50  0001 C CNN
F 3 "~" H 4800 3300 50  0001 C CNN
	1    4800 3300
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EA6BE1F
P 4650 3300
AR Path="/5E73B7F6/5EA6BE1F" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5EA6BE1F" Ref="#PWR?"  Part="1" 
AR Path="/5E9FD18D/5EA6BE1F" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 4650 3050 50  0001 C CNN
F 1 "GND" V 4655 3172 50  0000 R CNN
F 2 "" H 4650 3300 50  0001 C CNN
F 3 "" H 4650 3300 50  0001 C CNN
	1    4650 3300
	0    1    1    0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5EA6BE25
P 5100 3400
AR Path="/5E73B7F6/5EA6BE25" Ref="D?"  Part="1" 
AR Path="/5E7CA397/5EA6BE25" Ref="D?"  Part="1" 
AR Path="/5E9FD18D/5EA6BE25" Ref="D?"  Part="1" 
F 0 "D?" H 4150 3400 50  0000 C CNN
F 1 "LED" H 5093 3525 50  0001 C CNN
F 2 "" H 5100 3400 50  0001 C CNN
F 3 "~" H 5100 3400 50  0001 C CNN
	1    5100 3400
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5EA6BE2B
P 4800 3400
AR Path="/5E73B7F6/5EA6BE2B" Ref="R?"  Part="1" 
AR Path="/5E7CA397/5EA6BE2B" Ref="R?"  Part="1" 
AR Path="/5E9FD18D/5EA6BE2B" Ref="R?"  Part="1" 
F 0 "R?" V 4800 2200 50  0000 C CNN
F 1 "LED" V 4800 2550 50  0000 C CNN
F 2 "" V 4730 3400 50  0001 C CNN
F 3 "~" H 4800 3400 50  0001 C CNN
	1    4800 3400
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EA6BE31
P 4650 3400
AR Path="/5E73B7F6/5EA6BE31" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5EA6BE31" Ref="#PWR?"  Part="1" 
AR Path="/5E9FD18D/5EA6BE31" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 4650 3150 50  0001 C CNN
F 1 "GND" V 4655 3272 50  0000 R CNN
F 2 "" H 4650 3400 50  0001 C CNN
F 3 "" H 4650 3400 50  0001 C CNN
	1    4650 3400
	0    1    1    0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5EA6BE37
P 5100 3500
AR Path="/5E73B7F6/5EA6BE37" Ref="D?"  Part="1" 
AR Path="/5E7CA397/5EA6BE37" Ref="D?"  Part="1" 
AR Path="/5E9FD18D/5EA6BE37" Ref="D?"  Part="1" 
F 0 "D?" H 4150 3500 50  0000 C CNN
F 1 "LED" H 5093 3625 50  0001 C CNN
F 2 "" H 5100 3500 50  0001 C CNN
F 3 "~" H 5100 3500 50  0001 C CNN
	1    5100 3500
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5EA6BE3D
P 4800 3500
AR Path="/5E73B7F6/5EA6BE3D" Ref="R?"  Part="1" 
AR Path="/5E7CA397/5EA6BE3D" Ref="R?"  Part="1" 
AR Path="/5E9FD18D/5EA6BE3D" Ref="R?"  Part="1" 
F 0 "R?" V 4800 2300 50  0000 C CNN
F 1 "LED" V 4800 2650 50  0000 C CNN
F 2 "" V 4730 3500 50  0001 C CNN
F 3 "~" H 4800 3500 50  0001 C CNN
	1    4800 3500
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EA6BE43
P 4650 3500
AR Path="/5E73B7F6/5EA6BE43" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5EA6BE43" Ref="#PWR?"  Part="1" 
AR Path="/5E9FD18D/5EA6BE43" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 4650 3250 50  0001 C CNN
F 1 "GND" V 4655 3372 50  0000 R CNN
F 2 "" H 4650 3500 50  0001 C CNN
F 3 "" H 4650 3500 50  0001 C CNN
	1    4650 3500
	0    1    1    0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5EA6BE49
P 5100 3600
AR Path="/5E73B7F6/5EA6BE49" Ref="D?"  Part="1" 
AR Path="/5E7CA397/5EA6BE49" Ref="D?"  Part="1" 
AR Path="/5E9FD18D/5EA6BE49" Ref="D?"  Part="1" 
F 0 "D?" H 4150 3600 50  0000 C CNN
F 1 "LED" H 5093 3725 50  0001 C CNN
F 2 "" H 5100 3600 50  0001 C CNN
F 3 "~" H 5100 3600 50  0001 C CNN
	1    5100 3600
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5EA6BE4F
P 4800 3600
AR Path="/5E73B7F6/5EA6BE4F" Ref="R?"  Part="1" 
AR Path="/5E7CA397/5EA6BE4F" Ref="R?"  Part="1" 
AR Path="/5E9FD18D/5EA6BE4F" Ref="R?"  Part="1" 
F 0 "R?" V 4800 2400 50  0000 C CNN
F 1 "LED" V 4800 2750 50  0000 C CNN
F 2 "" V 4730 3600 50  0001 C CNN
F 3 "~" H 4800 3600 50  0001 C CNN
	1    4800 3600
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EA6BE55
P 4650 3600
AR Path="/5E73B7F6/5EA6BE55" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5EA6BE55" Ref="#PWR?"  Part="1" 
AR Path="/5E9FD18D/5EA6BE55" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 4650 3350 50  0001 C CNN
F 1 "GND" V 4655 3472 50  0000 R CNN
F 2 "" H 4650 3600 50  0001 C CNN
F 3 "" H 4650 3600 50  0001 C CNN
	1    4650 3600
	0    1    1    0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5EA6BE5B
P 5100 3700
AR Path="/5E73B7F6/5EA6BE5B" Ref="D?"  Part="1" 
AR Path="/5E7CA397/5EA6BE5B" Ref="D?"  Part="1" 
AR Path="/5E9FD18D/5EA6BE5B" Ref="D?"  Part="1" 
F 0 "D?" H 4150 3700 50  0000 C CNN
F 1 "LED" H 5093 3825 50  0001 C CNN
F 2 "" H 5100 3700 50  0001 C CNN
F 3 "~" H 5100 3700 50  0001 C CNN
	1    5100 3700
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5EA6BE61
P 4800 3700
AR Path="/5E73B7F6/5EA6BE61" Ref="R?"  Part="1" 
AR Path="/5E7CA397/5EA6BE61" Ref="R?"  Part="1" 
AR Path="/5E9FD18D/5EA6BE61" Ref="R?"  Part="1" 
F 0 "R?" V 4800 2500 50  0000 C CNN
F 1 "LED" V 4800 2850 50  0000 C CNN
F 2 "" V 4730 3700 50  0001 C CNN
F 3 "~" H 4800 3700 50  0001 C CNN
	1    4800 3700
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EA6BE67
P 4650 3700
AR Path="/5E73B7F6/5EA6BE67" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5EA6BE67" Ref="#PWR?"  Part="1" 
AR Path="/5E9FD18D/5EA6BE67" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 4650 3450 50  0001 C CNN
F 1 "GND" V 4655 3572 50  0000 R CNN
F 2 "" H 4650 3700 50  0001 C CNN
F 3 "" H 4650 3700 50  0001 C CNN
	1    4650 3700
	0    1    1    0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5EA6BE6D
P 5100 3800
AR Path="/5E73B7F6/5EA6BE6D" Ref="D?"  Part="1" 
AR Path="/5E7CA397/5EA6BE6D" Ref="D?"  Part="1" 
AR Path="/5E9FD18D/5EA6BE6D" Ref="D?"  Part="1" 
F 0 "D?" H 4150 3800 50  0000 C CNN
F 1 "LED" H 5093 3925 50  0001 C CNN
F 2 "" H 5100 3800 50  0001 C CNN
F 3 "~" H 5100 3800 50  0001 C CNN
	1    5100 3800
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5EA6BE73
P 4800 3800
AR Path="/5E73B7F6/5EA6BE73" Ref="R?"  Part="1" 
AR Path="/5E7CA397/5EA6BE73" Ref="R?"  Part="1" 
AR Path="/5E9FD18D/5EA6BE73" Ref="R?"  Part="1" 
F 0 "R?" V 4800 2600 50  0000 C CNN
F 1 "LED" V 4800 2950 50  0000 C CNN
F 2 "" V 4730 3800 50  0001 C CNN
F 3 "~" H 4800 3800 50  0001 C CNN
	1    4800 3800
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EA6BE79
P 4650 3800
AR Path="/5E73B7F6/5EA6BE79" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5EA6BE79" Ref="#PWR?"  Part="1" 
AR Path="/5E9FD18D/5EA6BE79" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 4650 3550 50  0001 C CNN
F 1 "GND" V 4655 3672 50  0000 R CNN
F 2 "" H 4650 3800 50  0001 C CNN
F 3 "" H 4650 3800 50  0001 C CNN
	1    4650 3800
	0    1    1    0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5EA6BE7F
P 5100 3900
AR Path="/5E73B7F6/5EA6BE7F" Ref="D?"  Part="1" 
AR Path="/5E7CA397/5EA6BE7F" Ref="D?"  Part="1" 
AR Path="/5E9FD18D/5EA6BE7F" Ref="D?"  Part="1" 
F 0 "D?" H 4150 3900 50  0000 C CNN
F 1 "LED" H 5093 4025 50  0001 C CNN
F 2 "" H 5100 3900 50  0001 C CNN
F 3 "~" H 5100 3900 50  0001 C CNN
	1    5100 3900
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5EA6BE85
P 4800 3900
AR Path="/5E73B7F6/5EA6BE85" Ref="R?"  Part="1" 
AR Path="/5E7CA397/5EA6BE85" Ref="R?"  Part="1" 
AR Path="/5E9FD18D/5EA6BE85" Ref="R?"  Part="1" 
F 0 "R?" V 4800 2700 50  0000 C CNN
F 1 "LED" V 4800 3050 50  0000 C CNN
F 2 "" V 4730 3900 50  0001 C CNN
F 3 "~" H 4800 3900 50  0001 C CNN
	1    4800 3900
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EA6BE8B
P 4650 3900
AR Path="/5E73B7F6/5EA6BE8B" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5EA6BE8B" Ref="#PWR?"  Part="1" 
AR Path="/5E9FD18D/5EA6BE8B" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 4650 3650 50  0001 C CNN
F 1 "GND" V 4655 3772 50  0000 R CNN
F 2 "" H 4650 3900 50  0001 C CNN
F 3 "" H 4650 3900 50  0001 C CNN
	1    4650 3900
	0    1    1    0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5EA6BE91
P 5100 4000
AR Path="/5E73B7F6/5EA6BE91" Ref="D?"  Part="1" 
AR Path="/5E7CA397/5EA6BE91" Ref="D?"  Part="1" 
AR Path="/5E9FD18D/5EA6BE91" Ref="D?"  Part="1" 
F 0 "D?" H 4150 4000 50  0000 C CNN
F 1 "LED" H 5093 4125 50  0001 C CNN
F 2 "" H 5100 4000 50  0001 C CNN
F 3 "~" H 5100 4000 50  0001 C CNN
	1    5100 4000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5EA6BE97
P 4800 4000
AR Path="/5E73B7F6/5EA6BE97" Ref="R?"  Part="1" 
AR Path="/5E7CA397/5EA6BE97" Ref="R?"  Part="1" 
AR Path="/5E9FD18D/5EA6BE97" Ref="R?"  Part="1" 
F 0 "R?" V 4800 2800 50  0000 C CNN
F 1 "LED" V 4800 3150 50  0000 C CNN
F 2 "" V 4730 4000 50  0001 C CNN
F 3 "~" H 4800 4000 50  0001 C CNN
	1    4800 4000
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EA6BE9D
P 4650 4000
AR Path="/5E73B7F6/5EA6BE9D" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5EA6BE9D" Ref="#PWR?"  Part="1" 
AR Path="/5E9FD18D/5EA6BE9D" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 4650 3750 50  0001 C CNN
F 1 "GND" V 4655 3872 50  0000 R CNN
F 2 "" H 4650 4000 50  0001 C CNN
F 3 "" H 4650 4000 50  0001 C CNN
	1    4650 4000
	0    1    1    0   
$EndComp
Text Notes 4900 4200 0    50   ~ 0
5 mA each
Entry Wire Line
	3900 1300 4000 1200
Entry Wire Line
	3900 1400 4000 1300
Entry Wire Line
	3900 1500 4000 1400
Entry Wire Line
	3900 1600 4000 1500
Entry Wire Line
	3900 1700 4000 1600
Entry Wire Line
	3900 1800 4000 1700
Entry Wire Line
	3900 1900 4000 1800
Entry Wire Line
	3900 2000 4000 1900
Wire Wire Line
	4250 1900 4000 1900
Wire Wire Line
	4000 1800 4250 1800
Wire Wire Line
	4250 1700 4000 1700
Wire Wire Line
	4000 1600 4250 1600
Wire Wire Line
	4250 1500 4000 1500
Wire Wire Line
	4000 1400 4250 1400
Wire Wire Line
	4250 1300 4000 1300
Wire Wire Line
	4000 1200 4250 1200
Text Label 4050 1200 0    50   ~ 0
di0
Text Label 4050 1300 0    50   ~ 0
di1
Text Label 4050 1400 0    50   ~ 0
di2
Text Label 4050 1500 0    50   ~ 0
di3
Text Label 4050 1600 0    50   ~ 0
di4
Text Label 4050 1700 0    50   ~ 0
di5
Text Label 4050 1800 0    50   ~ 0
di6
Text Label 4050 1900 0    50   ~ 0
di7
Wire Wire Line
	1650 2800 6750 2800
Wire Wire Line
	6750 2800 6750 2200
Connection ~ 6750 2200
Wire Wire Line
	6750 2200 6750 2100
Wire Wire Line
	1650 2100 4250 2100
Wire Wire Line
	4250 2200 1650 2200
Wire Bus Line
	1650 1000 3900 1000
$Comp
L Device:C C?
U 1 1 5EA6BED9
P 8400 2300
AR Path="/5E73B7F6/5EA6BED9" Ref="C?"  Part="1" 
AR Path="/5E7CA397/5EA6BED9" Ref="C?"  Part="1" 
AR Path="/5E9FD18D/5EA6BED9" Ref="C?"  Part="1" 
F 0 "C?" H 8515 2346 50  0000 L CNN
F 1 "0.1u" H 8515 2255 50  0000 L CNN
F 2 "" H 8438 2150 50  0001 C CNN
F 3 "~" H 8400 2300 50  0001 C CNN
	1    8400 2300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EA6BEDF
P 8400 2450
AR Path="/5E73B7F6/5EA6BEDF" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5EA6BEDF" Ref="#PWR?"  Part="1" 
AR Path="/5E9FD18D/5EA6BEDF" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 8400 2200 50  0001 C CNN
F 1 "GND" H 8405 2277 50  0000 C CNN
F 2 "" H 8400 2450 50  0001 C CNN
F 3 "" H 8400 2450 50  0001 C CNN
	1    8400 2450
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5EA6BEE5
P 8400 2150
AR Path="/5E73B7F6/5EA6BEE5" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5EA6BEE5" Ref="#PWR?"  Part="1" 
AR Path="/5E9FD18D/5EA6BEE5" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 8400 2000 50  0001 C CNN
F 1 "VCC" H 8417 2323 50  0000 C CNN
F 2 "" H 8400 2150 50  0001 C CNN
F 3 "" H 8400 2150 50  0001 C CNN
	1    8400 2150
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 5EA6BEEB
P 4050 2400
AR Path="/5E73B7F6/5EA6BEEB" Ref="C?"  Part="1" 
AR Path="/5E7CA397/5EA6BEEB" Ref="C?"  Part="1" 
AR Path="/5E9FD18D/5EA6BEEB" Ref="C?"  Part="1" 
F 0 "C?" H 4165 2446 50  0000 L CNN
F 1 "0.1u" H 4165 2355 50  0000 L CNN
F 2 "" H 4088 2250 50  0001 C CNN
F 3 "~" H 4050 2400 50  0001 C CNN
	1    4050 2400
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EA6BEF1
P 3900 2400
AR Path="/5E73B7F6/5EA6BEF1" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5EA6BEF1" Ref="#PWR?"  Part="1" 
AR Path="/5E9FD18D/5EA6BEF1" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 3900 2150 50  0001 C CNN
F 1 "GND" H 3905 2227 50  0000 C CNN
F 2 "" H 3900 2400 50  0001 C CNN
F 3 "" H 3900 2400 50  0001 C CNN
	1    3900 2400
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5EA6BEF7
P 4200 2400
AR Path="/5E73B7F6/5EA6BEF7" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5EA6BEF7" Ref="#PWR?"  Part="1" 
AR Path="/5E9FD18D/5EA6BEF7" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 4200 2250 50  0001 C CNN
F 1 "VCC" H 4217 2573 50  0000 C CNN
F 2 "" H 4200 2400 50  0001 C CNN
F 3 "" H 4200 2400 50  0001 C CNN
	1    4200 2400
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 5EA6BEFD
P 7900 1200
AR Path="/5E7CA397/5EA6BEFD" Ref="R?"  Part="1" 
AR Path="/5E73B7F6/5EA6BEFD" Ref="R?"  Part="1" 
AR Path="/5E9FD18D/5EA6BEFD" Ref="R?"  Part="1" 
F 0 "R?" V 7900 2000 50  0000 C CNN
F 1 "1k" V 7900 1850 50  0000 C CNN
F 2 "" V 7830 1200 50  0001 C CNN
F 3 "~" H 7900 1200 50  0001 C CNN
	1    7900 1200
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 5EA6BF03
P 7900 1300
AR Path="/5E7CA397/5EA6BF03" Ref="R?"  Part="1" 
AR Path="/5E73B7F6/5EA6BF03" Ref="R?"  Part="1" 
AR Path="/5E9FD18D/5EA6BF03" Ref="R?"  Part="1" 
F 0 "R?" V 7900 2100 50  0000 C CNN
F 1 "1k" V 7900 1950 50  0000 C CNN
F 2 "" V 7830 1300 50  0001 C CNN
F 3 "~" H 7900 1300 50  0001 C CNN
	1    7900 1300
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 5EA6BF09
P 7900 1400
AR Path="/5E7CA397/5EA6BF09" Ref="R?"  Part="1" 
AR Path="/5E73B7F6/5EA6BF09" Ref="R?"  Part="1" 
AR Path="/5E9FD18D/5EA6BF09" Ref="R?"  Part="1" 
F 0 "R?" V 7900 2200 50  0000 C CNN
F 1 "1k" V 7900 2050 50  0000 C CNN
F 2 "" V 7830 1400 50  0001 C CNN
F 3 "~" H 7900 1400 50  0001 C CNN
	1    7900 1400
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 5EA6BF0F
P 7900 1500
AR Path="/5E7CA397/5EA6BF0F" Ref="R?"  Part="1" 
AR Path="/5E73B7F6/5EA6BF0F" Ref="R?"  Part="1" 
AR Path="/5E9FD18D/5EA6BF0F" Ref="R?"  Part="1" 
F 0 "R?" V 7900 2300 50  0000 C CNN
F 1 "1k" V 7900 2150 50  0000 C CNN
F 2 "" V 7830 1500 50  0001 C CNN
F 3 "~" H 7900 1500 50  0001 C CNN
	1    7900 1500
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 5EA6BF15
P 7900 1600
AR Path="/5E7CA397/5EA6BF15" Ref="R?"  Part="1" 
AR Path="/5E73B7F6/5EA6BF15" Ref="R?"  Part="1" 
AR Path="/5E9FD18D/5EA6BF15" Ref="R?"  Part="1" 
F 0 "R?" V 7900 2400 50  0000 C CNN
F 1 "1k" V 7900 2250 50  0000 C CNN
F 2 "" V 7830 1600 50  0001 C CNN
F 3 "~" H 7900 1600 50  0001 C CNN
	1    7900 1600
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 5EA6BF1B
P 7900 1700
AR Path="/5E7CA397/5EA6BF1B" Ref="R?"  Part="1" 
AR Path="/5E73B7F6/5EA6BF1B" Ref="R?"  Part="1" 
AR Path="/5E9FD18D/5EA6BF1B" Ref="R?"  Part="1" 
F 0 "R?" V 7900 2500 50  0000 C CNN
F 1 "1k" V 7900 2350 50  0000 C CNN
F 2 "" V 7830 1700 50  0001 C CNN
F 3 "~" H 7900 1700 50  0001 C CNN
	1    7900 1700
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 5EA6BF21
P 7900 1800
AR Path="/5E7CA397/5EA6BF21" Ref="R?"  Part="1" 
AR Path="/5E73B7F6/5EA6BF21" Ref="R?"  Part="1" 
AR Path="/5E9FD18D/5EA6BF21" Ref="R?"  Part="1" 
F 0 "R?" V 7900 2600 50  0000 C CNN
F 1 "1k" V 7900 2450 50  0000 C CNN
F 2 "" V 7830 1800 50  0001 C CNN
F 3 "~" H 7900 1800 50  0001 C CNN
	1    7900 1800
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 5EA6BF27
P 7900 1900
AR Path="/5E7CA397/5EA6BF27" Ref="R?"  Part="1" 
AR Path="/5E73B7F6/5EA6BF27" Ref="R?"  Part="1" 
AR Path="/5E9FD18D/5EA6BF27" Ref="R?"  Part="1" 
F 0 "R?" V 7900 2700 50  0000 C CNN
F 1 "1k" V 7900 2550 50  0000 C CNN
F 2 "" V 7830 1900 50  0001 C CNN
F 3 "~" H 7900 1900 50  0001 C CNN
	1    7900 1900
	0    1    1    0   
$EndComp
Text HLabel 1650 2800 0    50   Input ~ 0
~oea
Wire Wire Line
	6500 4100 7050 4100
Wire Wire Line
	6500 4000 7050 4000
Wire Wire Line
	6500 3900 7050 3900
Wire Wire Line
	6500 3800 7050 3800
Wire Wire Line
	6500 3700 7050 3700
Wire Wire Line
	6500 3600 7050 3600
Wire Wire Line
	6500 3500 7050 3500
Wire Wire Line
	6500 3400 7050 3400
Wire Bus Line
	9700 3150 7150 3150
Wire Bus Line
	7150 3150 7150 4000
Wire Bus Line
	8450 1000 8450 1800
Wire Bus Line
	3900 1000 3900 2000
Wire Bus Line
	5550 900  5550 3900
Wire Bus Line
	6400 900  6400 4200
$EndSCHEMATC
