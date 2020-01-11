EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 5 10
Title "General-purpose register"
Date "2019-12-29"
Rev "1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 1200 2050 0    50   Input ~ 0
w_clk
Text HLabel 1200 2150 0    50   Input ~ 0
~rst
Text HLabel 1200 2750 0    50   Input ~ 0
~oea
Text HLabel 1200 4200 0    50   Input ~ 0
~oeb
Text HLabel 1200 950  0    50   Input ~ 0
di[0..7]
Text HLabel 9250 950  2    50   3State ~ 0
doa[0..7]
Text HLabel 9250 3100 2    50   3State ~ 0
dob[0..7]
$Comp
L 74xx:74HC244 U?
U 1 1 5E73BC4E
P 6800 1650
AR Path="/5E73B7F6/5E73BC4E" Ref="U?"  Part="1" 
AR Path="/5E7CA397/5E73BC4E" Ref="U26"  Part="1" 
F 0 "U26" H 7200 1100 50  0000 C CNN
F 1 "74ACT244" H 7100 1000 50  0000 C CNN
F 2 "Package_SO:SO-20_12.8x7.5mm_P1.27mm" H 6800 1650 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT244.pdf" H 6800 1650 50  0001 C CNN
	1    6800 1650
	1    0    0    -1  
$EndComp
Entry Wire Line
	5950 1250 6050 1150
Entry Wire Line
	5950 1350 6050 1250
Entry Wire Line
	5950 1450 6050 1350
Entry Wire Line
	5950 1550 6050 1450
Entry Wire Line
	5950 1650 6050 1550
Entry Wire Line
	5950 1750 6050 1650
Entry Wire Line
	5950 1850 6050 1750
Entry Wire Line
	5950 1950 6050 1850
Wire Wire Line
	6050 1850 6300 1850
Wire Wire Line
	6300 1750 6050 1750
Wire Wire Line
	6050 1650 6300 1650
Wire Wire Line
	6300 1550 6050 1550
Wire Wire Line
	6050 1450 6300 1450
Wire Wire Line
	6300 1350 6050 1350
Wire Wire Line
	6050 1250 6300 1250
Wire Wire Line
	6300 1150 6050 1150
Entry Wire Line
	7900 1150 8000 1050
Entry Wire Line
	7900 1250 8000 1150
Entry Wire Line
	7900 1350 8000 1250
Entry Wire Line
	7900 1450 8000 1350
Entry Wire Line
	7900 1550 8000 1450
Entry Wire Line
	7900 1650 8000 1550
Entry Wire Line
	7900 1750 8000 1650
Entry Wire Line
	7900 1850 8000 1750
Wire Wire Line
	7900 1150 7600 1150
Wire Wire Line
	7600 1250 7900 1250
Wire Wire Line
	7900 1350 7600 1350
Wire Wire Line
	7600 1450 7900 1450
Wire Wire Line
	7900 1550 7600 1550
Wire Wire Line
	7600 1650 7900 1650
Wire Wire Line
	7900 1750 7600 1750
Wire Wire Line
	7600 1850 7900 1850
Text Label 6050 1150 0    50   ~ 0
d0
Text Label 6050 1250 0    50   ~ 0
d1
Text Label 6050 1350 0    50   ~ 0
d2
Text Label 6050 1450 0    50   ~ 0
d3
Text Label 6050 1550 0    50   ~ 0
d4
Text Label 6050 1650 0    50   ~ 0
d5
Text Label 6050 1750 0    50   ~ 0
d6
Text Label 6050 1850 0    50   ~ 0
d7
$Comp
L power:GND #PWR?
U 1 1 5E7469F1
P 6800 2450
AR Path="/5E73B7F6/5E7469F1" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5E7469F1" Ref="#PWR0163"  Part="1" 
F 0 "#PWR0163" H 6800 2200 50  0001 C CNN
F 1 "GND" H 6805 2277 50  0000 C CNN
F 2 "" H 6800 2450 50  0001 C CNN
F 3 "" H 6800 2450 50  0001 C CNN
	1    6800 2450
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5E746EE0
P 6800 850
AR Path="/5E73B7F6/5E746EE0" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5E746EE0" Ref="#PWR0162"  Part="1" 
F 0 "#PWR0162" H 6800 700 50  0001 C CNN
F 1 "VCC" H 6817 1023 50  0000 C CNN
F 2 "" H 6800 850 50  0001 C CNN
F 3 "" H 6800 850 50  0001 C CNN
	1    6800 850 
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC244 U?
U 1 1 5E74CA38
P 6800 3850
AR Path="/5E73B7F6/5E74CA38" Ref="U?"  Part="1" 
AR Path="/5E7CA397/5E74CA38" Ref="U27"  Part="1" 
F 0 "U27" H 7200 3300 50  0000 C CNN
F 1 "74ACT244" H 7100 3200 50  0000 C CNN
F 2 "Package_SO:SO-20_12.8x7.5mm_P1.27mm" H 6800 3850 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT244.pdf" H 6800 3850 50  0001 C CNN
	1    6800 3850
	1    0    0    -1  
$EndComp
Entry Wire Line
	5950 3450 6050 3350
Entry Wire Line
	5950 3550 6050 3450
Entry Wire Line
	5950 3650 6050 3550
Entry Wire Line
	5950 3750 6050 3650
Entry Wire Line
	5950 3850 6050 3750
Entry Wire Line
	5950 3950 6050 3850
Entry Wire Line
	5950 4050 6050 3950
Entry Wire Line
	5950 4150 6050 4050
Wire Wire Line
	6050 4050 6300 4050
Wire Wire Line
	6300 3950 6050 3950
Wire Wire Line
	6050 3850 6300 3850
Wire Wire Line
	6300 3750 6050 3750
Wire Wire Line
	6050 3650 6300 3650
Wire Wire Line
	6300 3550 6050 3550
Wire Wire Line
	6050 3450 6300 3450
Wire Wire Line
	6300 3350 6050 3350
Entry Wire Line
	7900 3350 8000 3250
Entry Wire Line
	7900 3450 8000 3350
Entry Wire Line
	7900 3550 8000 3450
Entry Wire Line
	7900 3650 8000 3550
Entry Wire Line
	7900 3750 8000 3650
Entry Wire Line
	7900 3850 8000 3750
Entry Wire Line
	7900 3950 8000 3850
Entry Wire Line
	7900 4050 8000 3950
Wire Wire Line
	7900 3350 7600 3350
Wire Wire Line
	7600 3450 7900 3450
Wire Wire Line
	7900 3550 7600 3550
Wire Wire Line
	7600 3650 7900 3650
Wire Wire Line
	7900 3750 7600 3750
Wire Wire Line
	7600 3850 7900 3850
Wire Wire Line
	7900 3950 7600 3950
Wire Wire Line
	7600 4050 7900 4050
Text Label 6050 3350 0    50   ~ 0
d0
Text Label 6050 3450 0    50   ~ 0
d1
Text Label 6050 3550 0    50   ~ 0
d2
Text Label 6050 3650 0    50   ~ 0
d3
Text Label 6050 3750 0    50   ~ 0
d4
Text Label 6050 3850 0    50   ~ 0
d5
Text Label 6050 3950 0    50   ~ 0
d6
Text Label 6050 4050 0    50   ~ 0
d7
$Comp
L power:GND #PWR?
U 1 1 5E74CA66
P 6800 4650
AR Path="/5E73B7F6/5E74CA66" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5E74CA66" Ref="#PWR0165"  Part="1" 
F 0 "#PWR0165" H 6800 4400 50  0001 C CNN
F 1 "GND" H 6805 4477 50  0000 C CNN
F 2 "" H 6800 4650 50  0001 C CNN
F 3 "" H 6800 4650 50  0001 C CNN
	1    6800 4650
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5E74CA6C
P 6800 3050
AR Path="/5E73B7F6/5E74CA6C" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5E74CA6C" Ref="#PWR0164"  Part="1" 
F 0 "#PWR0164" H 6800 2900 50  0001 C CNN
F 1 "VCC" H 6817 3223 50  0000 C CNN
F 2 "" H 6800 3050 50  0001 C CNN
F 3 "" H 6800 3050 50  0001 C CNN
	1    6800 3050
	1    0    0    -1  
$EndComp
Text Label 5950 2600 0    50   ~ 0
d[0..7]
Text Label 7650 1150 0    50   ~ 0
doa0
Text Label 7650 1250 0    50   ~ 0
doa1
Text Label 7650 1350 0    50   ~ 0
doa2
Text Label 7650 1450 0    50   ~ 0
doa3
Text Label 7650 1550 0    50   ~ 0
doa4
Text Label 7650 1650 0    50   ~ 0
doa5
Text Label 7650 1750 0    50   ~ 0
doa6
Text Label 7650 1850 0    50   ~ 0
doa7
Text Label 7650 3350 0    50   ~ 0
dob0
Text Label 7650 3450 0    50   ~ 0
dob1
Text Label 7650 3550 0    50   ~ 0
dob2
Text Label 7650 3650 0    50   ~ 0
dob3
Text Label 7650 3750 0    50   ~ 0
dob4
Text Label 7650 3850 0    50   ~ 0
dob5
Text Label 7650 3950 0    50   ~ 0
dob6
Text Label 7650 4050 0    50   ~ 0
dob7
Wire Bus Line
	9250 3100 8000 3100
Wire Bus Line
	9250 950  8000 950 
$Comp
L 74xx:74HCT273 U?
U 1 1 5E755BB1
P 4300 1650
AR Path="/5E73B7F6/5E755BB1" Ref="U?"  Part="1" 
AR Path="/5E7CA397/5E755BB1" Ref="U25"  Part="1" 
F 0 "U25" H 4700 1100 50  0000 C CNN
F 1 "74AC273" H 4650 1000 50  0000 C CNN
F 2 "Package_SO:TSSOP-20_4.4x6.5mm_P0.65mm" H 4300 1650 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT273.pdf" H 4300 1650 50  0001 C CNN
	1    4300 1650
	1    0    0    -1  
$EndComp
Entry Wire Line
	5000 1150 5100 1050
Entry Wire Line
	5000 1250 5100 1150
Entry Wire Line
	5000 1350 5100 1250
Entry Wire Line
	5000 1450 5100 1350
Entry Wire Line
	5000 1550 5100 1450
Entry Wire Line
	5000 1650 5100 1550
Entry Wire Line
	5000 1750 5100 1650
Entry Wire Line
	5000 1850 5100 1750
Wire Wire Line
	5000 1850 4800 1850
Wire Wire Line
	4800 1750 5000 1750
Wire Wire Line
	5000 1650 4800 1650
Wire Wire Line
	4800 1550 5000 1550
Wire Wire Line
	5000 1450 4800 1450
Wire Wire Line
	4800 1350 5000 1350
Wire Wire Line
	5000 1250 4800 1250
Wire Wire Line
	4800 1150 5000 1150
Text Label 4850 1150 0    50   ~ 0
d0
Text Label 4850 1250 0    50   ~ 0
d1
Text Label 4850 1350 0    50   ~ 0
d2
Text Label 4850 1450 0    50   ~ 0
d3
Text Label 4850 1550 0    50   ~ 0
d4
Text Label 4850 1650 0    50   ~ 0
d5
Text Label 4850 1750 0    50   ~ 0
d6
Text Label 4850 1850 0    50   ~ 0
d7
Wire Bus Line
	5100 850  5950 850 
$Comp
L power:GND #PWR?
U 1 1 5E762F6C
P 4300 2450
AR Path="/5E73B7F6/5E762F6C" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5E762F6C" Ref="#PWR0161"  Part="1" 
F 0 "#PWR0161" H 4300 2200 50  0001 C CNN
F 1 "GND" H 4305 2277 50  0000 C CNN
F 2 "" H 4300 2450 50  0001 C CNN
F 3 "" H 4300 2450 50  0001 C CNN
	1    4300 2450
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5E7634FA
P 4300 850
AR Path="/5E73B7F6/5E7634FA" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5E7634FA" Ref="#PWR0160"  Part="1" 
F 0 "#PWR0160" H 4300 700 50  0001 C CNN
F 1 "VCC" H 4317 1023 50  0000 C CNN
F 2 "" H 4300 850 50  0001 C CNN
F 3 "" H 4300 850 50  0001 C CNN
	1    4300 850 
	1    0    0    -1  
$EndComp
Entry Wire Line
	5000 3250 5100 3150
Entry Wire Line
	5000 3350 5100 3250
Entry Wire Line
	5000 3450 5100 3350
Entry Wire Line
	5000 3550 5100 3450
Entry Wire Line
	5000 3650 5100 3550
Entry Wire Line
	5000 3750 5100 3650
Entry Wire Line
	5000 3850 5100 3750
Entry Wire Line
	5000 3950 5100 3850
Wire Wire Line
	5000 3950 4800 3950
Wire Wire Line
	4800 3850 5000 3850
Wire Wire Line
	5000 3750 4800 3750
Wire Wire Line
	4800 3650 5000 3650
Wire Wire Line
	5000 3550 4800 3550
Wire Wire Line
	4800 3450 5000 3450
Wire Wire Line
	5000 3350 4800 3350
Wire Wire Line
	4800 3250 5000 3250
Text Label 4850 3250 0    50   ~ 0
d0
Text Label 4850 3350 0    50   ~ 0
d1
Text Label 4850 3450 0    50   ~ 0
d2
Text Label 4850 3550 0    50   ~ 0
d3
Text Label 4850 3650 0    50   ~ 0
d4
Text Label 4850 3750 0    50   ~ 0
d5
Text Label 4850 3850 0    50   ~ 0
d6
Text Label 4850 3950 0    50   ~ 0
d7
$Comp
L Device:LED D?
U 1 1 5E7690D3
P 4650 3250
AR Path="/5E73B7F6/5E7690D3" Ref="D?"  Part="1" 
AR Path="/5E7CA397/5E7690D3" Ref="D46"  Part="1" 
F 0 "D46" H 3700 3250 50  0000 C CNN
F 1 "LED" H 4643 3375 50  0001 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 4650 3250 50  0001 C CNN
F 3 "~" H 4650 3250 50  0001 C CNN
	1    4650 3250
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5E769EED
P 4350 3250
AR Path="/5E73B7F6/5E769EED" Ref="R?"  Part="1" 
AR Path="/5E7CA397/5E769EED" Ref="R126"  Part="1" 
F 0 "R126" V 4350 2050 50  0000 C CNN
F 1 "LED" V 4350 2400 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 4280 3250 50  0001 C CNN
F 3 "~" H 4350 3250 50  0001 C CNN
	1    4350 3250
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5E76A5E7
P 4200 3250
AR Path="/5E73B7F6/5E76A5E7" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5E76A5E7" Ref="#PWR0152"  Part="1" 
F 0 "#PWR0152" H 4200 3000 50  0001 C CNN
F 1 "GND" V 4205 3122 50  0000 R CNN
F 2 "" H 4200 3250 50  0001 C CNN
F 3 "" H 4200 3250 50  0001 C CNN
	1    4200 3250
	0    1    1    0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5E76BFE9
P 4650 3350
AR Path="/5E73B7F6/5E76BFE9" Ref="D?"  Part="1" 
AR Path="/5E7CA397/5E76BFE9" Ref="D47"  Part="1" 
F 0 "D47" H 3700 3350 50  0000 C CNN
F 1 "LED" H 4643 3475 50  0001 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 4650 3350 50  0001 C CNN
F 3 "~" H 4650 3350 50  0001 C CNN
	1    4650 3350
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5E76BFEF
P 4350 3350
AR Path="/5E73B7F6/5E76BFEF" Ref="R?"  Part="1" 
AR Path="/5E7CA397/5E76BFEF" Ref="R127"  Part="1" 
F 0 "R127" V 4350 2150 50  0000 C CNN
F 1 "LED" V 4350 2500 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 4280 3350 50  0001 C CNN
F 3 "~" H 4350 3350 50  0001 C CNN
	1    4350 3350
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5E76BFF5
P 4200 3350
AR Path="/5E73B7F6/5E76BFF5" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5E76BFF5" Ref="#PWR0153"  Part="1" 
F 0 "#PWR0153" H 4200 3100 50  0001 C CNN
F 1 "GND" V 4205 3222 50  0000 R CNN
F 2 "" H 4200 3350 50  0001 C CNN
F 3 "" H 4200 3350 50  0001 C CNN
	1    4200 3350
	0    1    1    0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5E76E132
P 4650 3450
AR Path="/5E73B7F6/5E76E132" Ref="D?"  Part="1" 
AR Path="/5E7CA397/5E76E132" Ref="D48"  Part="1" 
F 0 "D48" H 3700 3450 50  0000 C CNN
F 1 "LED" H 4643 3575 50  0001 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 4650 3450 50  0001 C CNN
F 3 "~" H 4650 3450 50  0001 C CNN
	1    4650 3450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5E76E138
P 4350 3450
AR Path="/5E73B7F6/5E76E138" Ref="R?"  Part="1" 
AR Path="/5E7CA397/5E76E138" Ref="R128"  Part="1" 
F 0 "R128" V 4350 2250 50  0000 C CNN
F 1 "LED" V 4350 2600 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 4280 3450 50  0001 C CNN
F 3 "~" H 4350 3450 50  0001 C CNN
	1    4350 3450
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5E76E13E
P 4200 3450
AR Path="/5E73B7F6/5E76E13E" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5E76E13E" Ref="#PWR0154"  Part="1" 
F 0 "#PWR0154" H 4200 3200 50  0001 C CNN
F 1 "GND" V 4205 3322 50  0000 R CNN
F 2 "" H 4200 3450 50  0001 C CNN
F 3 "" H 4200 3450 50  0001 C CNN
	1    4200 3450
	0    1    1    0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5E76FA9B
P 4650 3550
AR Path="/5E73B7F6/5E76FA9B" Ref="D?"  Part="1" 
AR Path="/5E7CA397/5E76FA9B" Ref="D49"  Part="1" 
F 0 "D49" H 3700 3550 50  0000 C CNN
F 1 "LED" H 4643 3675 50  0001 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 4650 3550 50  0001 C CNN
F 3 "~" H 4650 3550 50  0001 C CNN
	1    4650 3550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5E76FAA1
P 4350 3550
AR Path="/5E73B7F6/5E76FAA1" Ref="R?"  Part="1" 
AR Path="/5E7CA397/5E76FAA1" Ref="R129"  Part="1" 
F 0 "R129" V 4350 2350 50  0000 C CNN
F 1 "LED" V 4350 2700 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 4280 3550 50  0001 C CNN
F 3 "~" H 4350 3550 50  0001 C CNN
	1    4350 3550
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5E76FAA7
P 4200 3550
AR Path="/5E73B7F6/5E76FAA7" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5E76FAA7" Ref="#PWR0155"  Part="1" 
F 0 "#PWR0155" H 4200 3300 50  0001 C CNN
F 1 "GND" V 4205 3422 50  0000 R CNN
F 2 "" H 4200 3550 50  0001 C CNN
F 3 "" H 4200 3550 50  0001 C CNN
	1    4200 3550
	0    1    1    0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5E771404
P 4650 3650
AR Path="/5E73B7F6/5E771404" Ref="D?"  Part="1" 
AR Path="/5E7CA397/5E771404" Ref="D50"  Part="1" 
F 0 "D50" H 3700 3650 50  0000 C CNN
F 1 "LED" H 4643 3775 50  0001 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 4650 3650 50  0001 C CNN
F 3 "~" H 4650 3650 50  0001 C CNN
	1    4650 3650
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5E77140A
P 4350 3650
AR Path="/5E73B7F6/5E77140A" Ref="R?"  Part="1" 
AR Path="/5E7CA397/5E77140A" Ref="R130"  Part="1" 
F 0 "R130" V 4350 2450 50  0000 C CNN
F 1 "LED" V 4350 2800 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 4280 3650 50  0001 C CNN
F 3 "~" H 4350 3650 50  0001 C CNN
	1    4350 3650
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5E771410
P 4200 3650
AR Path="/5E73B7F6/5E771410" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5E771410" Ref="#PWR0156"  Part="1" 
F 0 "#PWR0156" H 4200 3400 50  0001 C CNN
F 1 "GND" V 4205 3522 50  0000 R CNN
F 2 "" H 4200 3650 50  0001 C CNN
F 3 "" H 4200 3650 50  0001 C CNN
	1    4200 3650
	0    1    1    0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5E772D6D
P 4650 3750
AR Path="/5E73B7F6/5E772D6D" Ref="D?"  Part="1" 
AR Path="/5E7CA397/5E772D6D" Ref="D51"  Part="1" 
F 0 "D51" H 3700 3750 50  0000 C CNN
F 1 "LED" H 4643 3875 50  0001 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 4650 3750 50  0001 C CNN
F 3 "~" H 4650 3750 50  0001 C CNN
	1    4650 3750
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5E772D73
P 4350 3750
AR Path="/5E73B7F6/5E772D73" Ref="R?"  Part="1" 
AR Path="/5E7CA397/5E772D73" Ref="R131"  Part="1" 
F 0 "R131" V 4350 2550 50  0000 C CNN
F 1 "LED" V 4350 2900 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 4280 3750 50  0001 C CNN
F 3 "~" H 4350 3750 50  0001 C CNN
	1    4350 3750
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5E772D79
P 4200 3750
AR Path="/5E73B7F6/5E772D79" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5E772D79" Ref="#PWR0157"  Part="1" 
F 0 "#PWR0157" H 4200 3500 50  0001 C CNN
F 1 "GND" V 4205 3622 50  0000 R CNN
F 2 "" H 4200 3750 50  0001 C CNN
F 3 "" H 4200 3750 50  0001 C CNN
	1    4200 3750
	0    1    1    0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5E7746D6
P 4650 3850
AR Path="/5E73B7F6/5E7746D6" Ref="D?"  Part="1" 
AR Path="/5E7CA397/5E7746D6" Ref="D52"  Part="1" 
F 0 "D52" H 3700 3850 50  0000 C CNN
F 1 "LED" H 4643 3975 50  0001 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 4650 3850 50  0001 C CNN
F 3 "~" H 4650 3850 50  0001 C CNN
	1    4650 3850
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5E7746DC
P 4350 3850
AR Path="/5E73B7F6/5E7746DC" Ref="R?"  Part="1" 
AR Path="/5E7CA397/5E7746DC" Ref="R132"  Part="1" 
F 0 "R132" V 4350 2650 50  0000 C CNN
F 1 "LED" V 4350 3000 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 4280 3850 50  0001 C CNN
F 3 "~" H 4350 3850 50  0001 C CNN
	1    4350 3850
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5E7746E2
P 4200 3850
AR Path="/5E73B7F6/5E7746E2" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5E7746E2" Ref="#PWR0158"  Part="1" 
F 0 "#PWR0158" H 4200 3600 50  0001 C CNN
F 1 "GND" V 4205 3722 50  0000 R CNN
F 2 "" H 4200 3850 50  0001 C CNN
F 3 "" H 4200 3850 50  0001 C CNN
	1    4200 3850
	0    1    1    0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5E7762B5
P 4650 3950
AR Path="/5E73B7F6/5E7762B5" Ref="D?"  Part="1" 
AR Path="/5E7CA397/5E7762B5" Ref="D53"  Part="1" 
F 0 "D53" H 3700 3950 50  0000 C CNN
F 1 "LED" H 4643 4075 50  0001 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 4650 3950 50  0001 C CNN
F 3 "~" H 4650 3950 50  0001 C CNN
	1    4650 3950
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5E7762BB
P 4350 3950
AR Path="/5E73B7F6/5E7762BB" Ref="R?"  Part="1" 
AR Path="/5E7CA397/5E7762BB" Ref="R133"  Part="1" 
F 0 "R133" V 4350 2750 50  0000 C CNN
F 1 "LED" V 4350 3100 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 4280 3950 50  0001 C CNN
F 3 "~" H 4350 3950 50  0001 C CNN
	1    4350 3950
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5E7762C1
P 4200 3950
AR Path="/5E73B7F6/5E7762C1" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5E7762C1" Ref="#PWR0159"  Part="1" 
F 0 "#PWR0159" H 4200 3700 50  0001 C CNN
F 1 "GND" V 4205 3822 50  0000 R CNN
F 2 "" H 4200 3950 50  0001 C CNN
F 3 "" H 4200 3950 50  0001 C CNN
	1    4200 3950
	0    1    1    0   
$EndComp
Text Notes 4450 4150 0    50   ~ 0
5 mA each
Entry Wire Line
	3450 1250 3550 1150
Entry Wire Line
	3450 1350 3550 1250
Entry Wire Line
	3450 1450 3550 1350
Entry Wire Line
	3450 1550 3550 1450
Entry Wire Line
	3450 1650 3550 1550
Entry Wire Line
	3450 1750 3550 1650
Entry Wire Line
	3450 1850 3550 1750
Entry Wire Line
	3450 1950 3550 1850
Wire Wire Line
	3800 1850 3550 1850
Wire Wire Line
	3550 1750 3800 1750
Wire Wire Line
	3800 1650 3550 1650
Wire Wire Line
	3550 1550 3800 1550
Wire Wire Line
	3800 1450 3550 1450
Wire Wire Line
	3550 1350 3800 1350
Wire Wire Line
	3800 1250 3550 1250
Wire Wire Line
	3550 1150 3800 1150
Text Label 3600 1150 0    50   ~ 0
di0
Text Label 3600 1250 0    50   ~ 0
di1
Text Label 3600 1350 0    50   ~ 0
di2
Text Label 3600 1450 0    50   ~ 0
di3
Text Label 3600 1550 0    50   ~ 0
di4
Text Label 3600 1650 0    50   ~ 0
di5
Text Label 3600 1750 0    50   ~ 0
di6
Text Label 3600 1850 0    50   ~ 0
di7
Wire Wire Line
	1200 4200 6300 4200
Wire Wire Line
	6300 4200 6300 4250
Connection ~ 6300 4250
Wire Wire Line
	6300 4250 6300 4350
Wire Wire Line
	1200 2750 6300 2750
Wire Wire Line
	6300 2750 6300 2150
Connection ~ 6300 2150
Wire Wire Line
	6300 2150 6300 2050
Wire Wire Line
	1200 2050 3800 2050
Wire Wire Line
	3800 2150 1200 2150
Wire Bus Line
	1200 950  3450 950 
$Comp
L Device:C C?
U 1 1 5E7B597F
P 7900 4450
AR Path="/5E73B7F6/5E7B597F" Ref="C?"  Part="1" 
AR Path="/5E7CA397/5E7B597F" Ref="C26"  Part="1" 
F 0 "C26" H 8015 4496 50  0000 L CNN
F 1 "0.1u" H 8015 4405 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 7938 4300 50  0001 C CNN
F 3 "~" H 7900 4450 50  0001 C CNN
	1    7900 4450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5E7B6ADB
P 7900 4600
AR Path="/5E73B7F6/5E7B6ADB" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5E7B6ADB" Ref="#PWR0167"  Part="1" 
F 0 "#PWR0167" H 7900 4350 50  0001 C CNN
F 1 "GND" H 7905 4427 50  0000 C CNN
F 2 "" H 7900 4600 50  0001 C CNN
F 3 "" H 7900 4600 50  0001 C CNN
	1    7900 4600
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5E7B7012
P 7900 4300
AR Path="/5E73B7F6/5E7B7012" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5E7B7012" Ref="#PWR0166"  Part="1" 
F 0 "#PWR0166" H 7900 4150 50  0001 C CNN
F 1 "VCC" H 7917 4473 50  0000 C CNN
F 2 "" H 7900 4300 50  0001 C CNN
F 3 "" H 7900 4300 50  0001 C CNN
	1    7900 4300
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 5E7B8018
P 7950 2250
AR Path="/5E73B7F6/5E7B8018" Ref="C?"  Part="1" 
AR Path="/5E7CA397/5E7B8018" Ref="C27"  Part="1" 
F 0 "C27" H 8065 2296 50  0000 L CNN
F 1 "0.1u" H 8065 2205 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 7988 2100 50  0001 C CNN
F 3 "~" H 7950 2250 50  0001 C CNN
	1    7950 2250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5E7B801E
P 7950 2400
AR Path="/5E73B7F6/5E7B801E" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5E7B801E" Ref="#PWR0169"  Part="1" 
F 0 "#PWR0169" H 7950 2150 50  0001 C CNN
F 1 "GND" H 7955 2227 50  0000 C CNN
F 2 "" H 7950 2400 50  0001 C CNN
F 3 "" H 7950 2400 50  0001 C CNN
	1    7950 2400
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5E7B8024
P 7950 2100
AR Path="/5E73B7F6/5E7B8024" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5E7B8024" Ref="#PWR0168"  Part="1" 
F 0 "#PWR0168" H 7950 1950 50  0001 C CNN
F 1 "VCC" H 7967 2273 50  0000 C CNN
F 2 "" H 7950 2100 50  0001 C CNN
F 3 "" H 7950 2100 50  0001 C CNN
	1    7950 2100
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 5E7BE329
P 3600 2350
AR Path="/5E73B7F6/5E7BE329" Ref="C?"  Part="1" 
AR Path="/5E7CA397/5E7BE329" Ref="C25"  Part="1" 
F 0 "C25" H 3715 2396 50  0000 L CNN
F 1 "0.1u" H 3715 2305 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 3638 2200 50  0001 C CNN
F 3 "~" H 3600 2350 50  0001 C CNN
	1    3600 2350
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5E7BE32F
P 3450 2350
AR Path="/5E73B7F6/5E7BE32F" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5E7BE32F" Ref="#PWR0150"  Part="1" 
F 0 "#PWR0150" H 3450 2100 50  0001 C CNN
F 1 "GND" H 3455 2177 50  0000 C CNN
F 2 "" H 3450 2350 50  0001 C CNN
F 3 "" H 3450 2350 50  0001 C CNN
	1    3450 2350
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5E7BE335
P 3750 2350
AR Path="/5E73B7F6/5E7BE335" Ref="#PWR?"  Part="1" 
AR Path="/5E7CA397/5E7BE335" Ref="#PWR0151"  Part="1" 
F 0 "#PWR0151" H 3750 2200 50  0001 C CNN
F 1 "VCC" H 3767 2523 50  0000 C CNN
F 2 "" H 3750 2350 50  0001 C CNN
F 3 "" H 3750 2350 50  0001 C CNN
	1    3750 2350
	0    1    1    0   
$EndComp
$Comp
L Device:R R134
U 1 1 5E990C07
P 7450 1150
AR Path="/5E7CA397/5E990C07" Ref="R134"  Part="1" 
AR Path="/5E73B7F6/5E990C07" Ref="R?"  Part="1" 
F 0 "R134" V 7450 1950 50  0000 C CNN
F 1 "1k" V 7450 1800 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 7380 1150 50  0001 C CNN
F 3 "~" H 7450 1150 50  0001 C CNN
	1    7450 1150
	0    1    1    0   
$EndComp
$Comp
L Device:R R135
U 1 1 5E9940A6
P 7450 1250
AR Path="/5E7CA397/5E9940A6" Ref="R135"  Part="1" 
AR Path="/5E73B7F6/5E9940A6" Ref="R?"  Part="1" 
F 0 "R135" V 7450 2050 50  0000 C CNN
F 1 "1k" V 7450 1900 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 7380 1250 50  0001 C CNN
F 3 "~" H 7450 1250 50  0001 C CNN
	1    7450 1250
	0    1    1    0   
$EndComp
$Comp
L Device:R R136
U 1 1 5E9942B2
P 7450 1350
AR Path="/5E7CA397/5E9942B2" Ref="R136"  Part="1" 
AR Path="/5E73B7F6/5E9942B2" Ref="R?"  Part="1" 
F 0 "R136" V 7450 2150 50  0000 C CNN
F 1 "1k" V 7450 2000 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 7380 1350 50  0001 C CNN
F 3 "~" H 7450 1350 50  0001 C CNN
	1    7450 1350
	0    1    1    0   
$EndComp
$Comp
L Device:R R137
U 1 1 5E9945CF
P 7450 1450
AR Path="/5E7CA397/5E9945CF" Ref="R137"  Part="1" 
AR Path="/5E73B7F6/5E9945CF" Ref="R?"  Part="1" 
F 0 "R137" V 7450 2250 50  0000 C CNN
F 1 "1k" V 7450 2100 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 7380 1450 50  0001 C CNN
F 3 "~" H 7450 1450 50  0001 C CNN
	1    7450 1450
	0    1    1    0   
$EndComp
$Comp
L Device:R R138
U 1 1 5E994748
P 7450 1550
AR Path="/5E7CA397/5E994748" Ref="R138"  Part="1" 
AR Path="/5E73B7F6/5E994748" Ref="R?"  Part="1" 
F 0 "R138" V 7450 2350 50  0000 C CNN
F 1 "1k" V 7450 2200 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 7380 1550 50  0001 C CNN
F 3 "~" H 7450 1550 50  0001 C CNN
	1    7450 1550
	0    1    1    0   
$EndComp
$Comp
L Device:R R139
U 1 1 5E994A8F
P 7450 1650
AR Path="/5E7CA397/5E994A8F" Ref="R139"  Part="1" 
AR Path="/5E73B7F6/5E994A8F" Ref="R?"  Part="1" 
F 0 "R139" V 7450 2450 50  0000 C CNN
F 1 "1k" V 7450 2300 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 7380 1650 50  0001 C CNN
F 3 "~" H 7450 1650 50  0001 C CNN
	1    7450 1650
	0    1    1    0   
$EndComp
$Comp
L Device:R R140
U 1 1 5E994BF3
P 7450 1750
AR Path="/5E7CA397/5E994BF3" Ref="R140"  Part="1" 
AR Path="/5E73B7F6/5E994BF3" Ref="R?"  Part="1" 
F 0 "R140" V 7450 2550 50  0000 C CNN
F 1 "1k" V 7450 2400 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 7380 1750 50  0001 C CNN
F 3 "~" H 7450 1750 50  0001 C CNN
	1    7450 1750
	0    1    1    0   
$EndComp
$Comp
L Device:R R141
U 1 1 5E994EE6
P 7450 1850
AR Path="/5E7CA397/5E994EE6" Ref="R141"  Part="1" 
AR Path="/5E73B7F6/5E994EE6" Ref="R?"  Part="1" 
F 0 "R141" V 7450 2650 50  0000 C CNN
F 1 "1k" V 7450 2500 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 7380 1850 50  0001 C CNN
F 3 "~" H 7450 1850 50  0001 C CNN
	1    7450 1850
	0    1    1    0   
$EndComp
$Comp
L Device:R R142
U 1 1 5E99BC46
P 7450 3350
AR Path="/5E7CA397/5E99BC46" Ref="R142"  Part="1" 
AR Path="/5E73B7F6/5E99BC46" Ref="R?"  Part="1" 
F 0 "R142" V 7450 4150 50  0000 C CNN
F 1 "1k" V 7450 4000 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 7380 3350 50  0001 C CNN
F 3 "~" H 7450 3350 50  0001 C CNN
	1    7450 3350
	0    1    1    0   
$EndComp
$Comp
L Device:R R143
U 1 1 5E99BC4C
P 7450 3450
AR Path="/5E7CA397/5E99BC4C" Ref="R143"  Part="1" 
AR Path="/5E73B7F6/5E99BC4C" Ref="R?"  Part="1" 
F 0 "R143" V 7450 4250 50  0000 C CNN
F 1 "1k" V 7450 4100 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 7380 3450 50  0001 C CNN
F 3 "~" H 7450 3450 50  0001 C CNN
	1    7450 3450
	0    1    1    0   
$EndComp
$Comp
L Device:R R144
U 1 1 5E99BC52
P 7450 3550
AR Path="/5E7CA397/5E99BC52" Ref="R144"  Part="1" 
AR Path="/5E73B7F6/5E99BC52" Ref="R?"  Part="1" 
F 0 "R144" V 7450 4350 50  0000 C CNN
F 1 "1k" V 7450 4200 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 7380 3550 50  0001 C CNN
F 3 "~" H 7450 3550 50  0001 C CNN
	1    7450 3550
	0    1    1    0   
$EndComp
$Comp
L Device:R R145
U 1 1 5E99BC58
P 7450 3650
AR Path="/5E7CA397/5E99BC58" Ref="R145"  Part="1" 
AR Path="/5E73B7F6/5E99BC58" Ref="R?"  Part="1" 
F 0 "R145" V 7450 4450 50  0000 C CNN
F 1 "1k" V 7450 4300 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 7380 3650 50  0001 C CNN
F 3 "~" H 7450 3650 50  0001 C CNN
	1    7450 3650
	0    1    1    0   
$EndComp
$Comp
L Device:R R146
U 1 1 5E99BC5E
P 7450 3750
AR Path="/5E7CA397/5E99BC5E" Ref="R146"  Part="1" 
AR Path="/5E73B7F6/5E99BC5E" Ref="R?"  Part="1" 
F 0 "R146" V 7450 4550 50  0000 C CNN
F 1 "1k" V 7450 4400 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 7380 3750 50  0001 C CNN
F 3 "~" H 7450 3750 50  0001 C CNN
	1    7450 3750
	0    1    1    0   
$EndComp
$Comp
L Device:R R147
U 1 1 5E99BC64
P 7450 3850
AR Path="/5E7CA397/5E99BC64" Ref="R147"  Part="1" 
AR Path="/5E73B7F6/5E99BC64" Ref="R?"  Part="1" 
F 0 "R147" V 7450 4650 50  0000 C CNN
F 1 "1k" V 7450 4500 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 7380 3850 50  0001 C CNN
F 3 "~" H 7450 3850 50  0001 C CNN
	1    7450 3850
	0    1    1    0   
$EndComp
$Comp
L Device:R R148
U 1 1 5E99BC6A
P 7450 3950
AR Path="/5E7CA397/5E99BC6A" Ref="R148"  Part="1" 
AR Path="/5E73B7F6/5E99BC6A" Ref="R?"  Part="1" 
F 0 "R148" V 7450 4750 50  0000 C CNN
F 1 "1k" V 7450 4600 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 7380 3950 50  0001 C CNN
F 3 "~" H 7450 3950 50  0001 C CNN
	1    7450 3950
	0    1    1    0   
$EndComp
$Comp
L Device:R R149
U 1 1 5E99BC70
P 7450 4050
AR Path="/5E7CA397/5E99BC70" Ref="R149"  Part="1" 
AR Path="/5E73B7F6/5E99BC70" Ref="R?"  Part="1" 
F 0 "R149" V 7450 4850 50  0000 C CNN
F 1 "1k" V 7450 4700 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 7380 4050 50  0001 C CNN
F 3 "~" H 7450 4050 50  0001 C CNN
	1    7450 4050
	0    1    1    0   
$EndComp
Wire Bus Line
	8000 3100 8000 3950
Wire Bus Line
	8000 950  8000 1750
Wire Bus Line
	3450 950  3450 1950
Wire Bus Line
	5100 850  5100 3850
Wire Bus Line
	5950 850  5950 4150
$EndSCHEMATC
