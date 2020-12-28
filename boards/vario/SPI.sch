EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A3 16535 11693
encoding utf-8
Sheet 2 3
Title "SPI controller"
Date "2020-12-23"
Rev "1"
Comp "Licensed under the TAPR Open Hardware License (www.tapr.org/OHL)"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L 74xx:74HC273 U?
U 1 1 5FE61758
P 4650 3150
AR Path="/5FE61758" Ref="U?"  Part="1" 
AR Path="/5FE5ABE2/5FE61758" Ref="U1"  Part="1" 
F 0 "U1" H 5050 2600 50  0000 C CNN
F 1 "74HC273" H 5050 2450 50  0000 C CNN
F 2 "" H 4650 3150 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT273.pdf" H 4650 3150 50  0001 C CNN
	1    4650 3150
	1    0    0    -1  
$EndComp
Text Label 4150 2650 2    50   ~ 0
d0
Text Label 4150 2750 2    50   ~ 0
d1
Text Label 4150 2850 2    50   ~ 0
d2
Text Label 4150 2950 2    50   ~ 0
d3
Text Label 4150 3050 2    50   ~ 0
d4
Text Label 4150 3150 2    50   ~ 0
d5
Text Label 4150 3250 2    50   ~ 0
d6
Text Label 4150 3350 2    50   ~ 0
d7
Text Label 5150 2650 0    50   ~ 0
reg_send_q0
Text Label 5150 2750 0    50   ~ 0
reg_send_q1
Text Label 5150 2850 0    50   ~ 0
reg_send_q2
Text Label 5150 2950 0    50   ~ 0
reg_send_q3
Text Label 5150 3050 0    50   ~ 0
reg_send_q4
Text Label 5150 3150 0    50   ~ 0
reg_send_q5
Text Label 5150 3250 0    50   ~ 0
reg_send_q6
Text Label 5150 3350 0    50   ~ 0
reg_send_q7
$Comp
L power:GND #PWR?
U 1 1 5FE6176E
P 4650 3950
AR Path="/5FE6176E" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/5FE6176E" Ref="#PWR09"  Part="1" 
F 0 "#PWR09" H 4650 3700 50  0001 C CNN
F 1 "GND" V 4655 3822 50  0000 R CNN
F 2 "" H 4650 3950 50  0001 C CNN
F 3 "" H 4650 3950 50  0001 C CNN
	1    4650 3950
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5FE61774
P 4650 2350
AR Path="/5FE61774" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/5FE61774" Ref="#PWR08"  Part="1" 
F 0 "#PWR08" H 4650 2200 50  0001 C CNN
F 1 "VCC" V 4665 2478 50  0000 L CNN
F 2 "" H 4650 2350 50  0001 C CNN
F 3 "" H 4650 2350 50  0001 C CNN
	1    4650 2350
	1    0    0    -1  
$EndComp
Text Label 4150 3650 2    50   ~ 0
~rst
$Comp
L 74xx:74LS151 U?
U 1 1 5FE6177B
P 7350 3200
AR Path="/5FE6177B" Ref="U?"  Part="1" 
AR Path="/5FE5ABE2/5FE6177B" Ref="U5"  Part="1" 
F 0 "U5" H 7750 2450 50  0000 C CNN
F 1 "74LS151" H 7750 2300 50  0000 C CNN
F 2 "" H 7350 3200 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS151" H 7350 3200 50  0001 C CNN
	1    7350 3200
	1    0    0    -1  
$EndComp
Text Label 6850 3300 2    50   ~ 0
reg_send_q0
Text Label 6850 3200 2    50   ~ 0
reg_send_q1
Text Label 6850 3100 2    50   ~ 0
reg_send_q2
Text Label 6850 3000 2    50   ~ 0
reg_send_q3
Text Label 6850 2900 2    50   ~ 0
reg_send_q4
Text Label 6850 2800 2    50   ~ 0
reg_send_q5
Text Label 6850 2700 2    50   ~ 0
reg_send_q6
Text Label 6850 2600 2    50   ~ 0
reg_send_q7
$Comp
L power:VCC #PWR?
U 1 1 5FE61789
P 7350 2300
AR Path="/5FE61789" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/5FE61789" Ref="#PWR019"  Part="1" 
F 0 "#PWR019" H 7350 2150 50  0001 C CNN
F 1 "VCC" V 7365 2428 50  0000 L CNN
F 2 "" H 7350 2300 50  0001 C CNN
F 3 "" H 7350 2300 50  0001 C CNN
	1    7350 2300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FE6178F
P 7350 4200
AR Path="/5FE6178F" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/5FE6178F" Ref="#PWR020"  Part="1" 
F 0 "#PWR020" H 7350 3950 50  0001 C CNN
F 1 "GND" V 7355 4072 50  0000 R CNN
F 2 "" H 7350 4200 50  0001 C CNN
F 3 "" H 7350 4200 50  0001 C CNN
	1    7350 4200
	1    0    0    -1  
$EndComp
NoConn ~ 7850 2700
Text Label 7850 2600 0    50   ~ 0
mosi
Text Label 6850 3500 2    50   ~ 0
count0
Text Label 6850 3600 2    50   ~ 0
count1
Text Label 6850 3700 2    50   ~ 0
count2
$Comp
L power:GND #PWR?
U 1 1 5FE6179A
P 6850 3900
AR Path="/5FE6179A" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/5FE6179A" Ref="#PWR016"  Part="1" 
F 0 "#PWR016" H 6850 3650 50  0001 C CNN
F 1 "GND" V 6855 3772 50  0000 R CNN
F 2 "" H 6850 3900 50  0001 C CNN
F 3 "" H 6850 3900 50  0001 C CNN
	1    6850 3900
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS161 U?
U 1 1 5FE617A0
P 4650 5600
AR Path="/5FE617A0" Ref="U?"  Part="1" 
AR Path="/5FE5ABE2/5FE617A0" Ref="U2"  Part="1" 
F 0 "U2" H 5100 5050 50  0000 C CNN
F 1 "74LS161" H 5000 4950 50  0000 C CNN
F 2 "" H 4650 5600 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS161" H 4650 5600 50  0001 C CNN
	1    4650 5600
	1    0    0    -1  
$EndComp
Text Label 5150 5100 0    50   ~ 0
count0
Text Label 5150 5200 0    50   ~ 0
count1
Text Label 5150 5300 0    50   ~ 0
count2
Text Label 5150 5400 0    50   ~ 0
count3
$Comp
L power:GND #PWR?
U 1 1 5FE617AA
P 4650 6400
AR Path="/5FE617AA" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/5FE617AA" Ref="#PWR011"  Part="1" 
F 0 "#PWR011" H 4650 6150 50  0001 C CNN
F 1 "GND" V 4655 6272 50  0000 R CNN
F 2 "" H 4650 6400 50  0001 C CNN
F 3 "" H 4650 6400 50  0001 C CNN
	1    4650 6400
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5FE617B0
P 4650 4800
AR Path="/5FE617B0" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/5FE617B0" Ref="#PWR010"  Part="1" 
F 0 "#PWR010" H 4650 4650 50  0001 C CNN
F 1 "VCC" V 4665 4928 50  0000 L CNN
F 2 "" H 4650 4800 50  0001 C CNN
F 3 "" H 4650 4800 50  0001 C CNN
	1    4650 4800
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5FE617B6
P 4150 5000
AR Path="/5FE617B6" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/5FE617B6" Ref="#PWR06"  Part="1" 
F 0 "#PWR06" H 4150 4850 50  0001 C CNN
F 1 "VCC" V 4165 5128 50  0000 L CNN
F 2 "" H 4150 5000 50  0001 C CNN
F 3 "" H 4150 5000 50  0001 C CNN
	1    4150 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4150 5400 4150 5300
Connection ~ 4150 5100
Wire Wire Line
	4150 5100 4150 5000
Connection ~ 4150 5200
Wire Wire Line
	4150 5200 4150 5100
Connection ~ 4150 5300
Wire Wire Line
	4150 5300 4150 5200
$Comp
L power:VCC #PWR?
U 1 1 5FE617C3
P 4100 5700
AR Path="/5FE617C3" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/5FE617C3" Ref="#PWR05"  Part="1" 
F 0 "#PWR05" H 4100 5550 50  0001 C CNN
F 1 "VCC" V 4115 5828 50  0000 L CNN
F 2 "" H 4100 5700 50  0001 C CNN
F 3 "" H 4100 5700 50  0001 C CNN
	1    4100 5700
	0    -1   -1   0   
$EndComp
Text Label 4150 6100 2    50   ~ 0
~int_rst
Wire Wire Line
	4150 5600 4150 5700
Connection ~ 4150 5700
Wire Wire Line
	4150 5700 4150 5800
Wire Wire Line
	4100 5700 4150 5700
Text Label 4150 5900 2    50   ~ 0
~clk
NoConn ~ 5150 5600
$Comp
L 74xx:74HC273 U?
U 1 1 5FE62655
P 7300 5600
AR Path="/5FE62655" Ref="U?"  Part="1" 
AR Path="/5FE5ABE2/5FE62655" Ref="U4"  Part="1" 
F 0 "U4" H 7700 5050 50  0000 C CNN
F 1 "74HC273" H 7700 4900 50  0000 C CNN
F 2 "" H 7300 5600 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT273.pdf" H 7300 5600 50  0001 C CNN
	1    7300 5600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FE66867
P 7300 6400
AR Path="/5FE66867" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/5FE66867" Ref="#PWR018"  Part="1" 
F 0 "#PWR018" H 7300 6150 50  0001 C CNN
F 1 "GND" V 7305 6272 50  0000 R CNN
F 2 "" H 7300 6400 50  0001 C CNN
F 3 "" H 7300 6400 50  0001 C CNN
	1    7300 6400
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5FE66E39
P 7300 4800
AR Path="/5FE66E39" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/5FE66E39" Ref="#PWR017"  Part="1" 
F 0 "#PWR017" H 7300 4650 50  0001 C CNN
F 1 "VCC" V 7315 4928 50  0000 L CNN
F 2 "" H 7300 4800 50  0001 C CNN
F 3 "" H 7300 4800 50  0001 C CNN
	1    7300 4800
	1    0    0    -1  
$EndComp
Text Label 7800 5100 0    50   ~ 0
reg_recv_q0
Text Label 7800 5200 0    50   ~ 0
reg_recv_q1
Text Label 7800 5300 0    50   ~ 0
reg_recv_q2
Text Label 7800 5400 0    50   ~ 0
reg_recv_q3
Text Label 7800 5500 0    50   ~ 0
reg_recv_q4
Text Label 7800 5600 0    50   ~ 0
reg_recv_q5
Text Label 7800 5700 0    50   ~ 0
reg_recv_q6
Text Label 7800 5800 0    50   ~ 0
reg_recv_q7
Text Label 6800 5100 2    50   ~ 0
miso
Text Label 6800 5200 2    50   ~ 0
reg_recv_q0
Text Label 6800 5300 2    50   ~ 0
reg_recv_q1
Text Label 6800 5400 2    50   ~ 0
reg_recv_q2
Text Label 6800 5500 2    50   ~ 0
reg_recv_q3
Text Label 6800 5600 2    50   ~ 0
reg_recv_q4
Text Label 6800 5700 2    50   ~ 0
reg_recv_q5
Text Label 6800 5800 2    50   ~ 0
reg_recv_q6
Text Label 6800 6100 2    50   ~ 0
~rst
Text Label 6800 6000 2    50   ~ 0
clk
$Comp
L 74xx:74HC244 U6
U 1 1 5FE6C343
P 9150 5600
F 0 "U6" H 9600 4950 50  0000 C CNN
F 1 "74HC244" H 9600 4850 50  0000 C CNN
F 2 "" H 9150 5600 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT244.pdf" H 9150 5600 50  0001 C CNN
	1    9150 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	7800 5100 8650 5100
Wire Wire Line
	8650 5200 7800 5200
Wire Wire Line
	7800 5300 8650 5300
Wire Wire Line
	8650 5400 7800 5400
Wire Wire Line
	7800 5500 8650 5500
Wire Wire Line
	8650 5600 7800 5600
Wire Wire Line
	7800 5700 8650 5700
Wire Wire Line
	8650 5800 7800 5800
Text Label 9650 5100 0    50   ~ 0
d0
Text Label 9650 5200 0    50   ~ 0
d1
Text Label 9650 5300 0    50   ~ 0
d2
Text Label 9650 5400 0    50   ~ 0
d3
Text Label 9650 5500 0    50   ~ 0
d4
Text Label 9650 5600 0    50   ~ 0
d5
Text Label 9650 5700 0    50   ~ 0
d6
Text Label 9650 5800 0    50   ~ 0
d7
Text Label 8650 6000 2    50   ~ 0
~oe_to_d
Wire Wire Line
	8650 6000 8650 6100
$Comp
L power:GND #PWR?
U 1 1 5FE7030B
P 9150 6400
AR Path="/5FE7030B" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/5FE7030B" Ref="#PWR022"  Part="1" 
F 0 "#PWR022" H 9150 6150 50  0001 C CNN
F 1 "GND" V 9155 6272 50  0000 R CNN
F 2 "" H 9150 6400 50  0001 C CNN
F 3 "" H 9150 6400 50  0001 C CNN
	1    9150 6400
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5FE709A9
P 9150 4800
AR Path="/5FE709A9" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/5FE709A9" Ref="#PWR021"  Part="1" 
F 0 "#PWR021" H 9150 4650 50  0001 C CNN
F 1 "VCC" V 9165 4928 50  0000 L CNN
F 2 "" H 9150 4800 50  0001 C CNN
F 3 "" H 9150 4800 50  0001 C CNN
	1    9150 4800
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC74 U3
U 1 1 5FE7AD90
P 4650 7600
F 0 "U3" H 5000 7400 50  0000 C CNN
F 1 "74HC74" H 5050 7300 50  0000 C CNN
F 2 "" H 4650 7600 50  0001 C CNN
F 3 "74xx/74hc_hct74.pdf" H 4650 7600 50  0001 C CNN
	1    4650 7600
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC74 U3
U 2 1 5FE7C18A
P 6650 7600
F 0 "U3" H 6950 7350 50  0000 C CNN
F 1 "74HC74" H 6950 7250 50  0000 C CNN
F 2 "" H 6650 7600 50  0001 C CNN
F 3 "74xx/74hc_hct74.pdf" H 6650 7600 50  0001 C CNN
	2    6650 7600
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC74 U3
U 3 1 5FE7C9F6
P 5450 9400
F 0 "U3" H 5680 9446 50  0000 L CNN
F 1 "74HC74" H 5680 9355 50  0000 L CNN
F 2 "" H 5450 9400 50  0001 C CNN
F 3 "74xx/74hc_hct74.pdf" H 5450 9400 50  0001 C CNN
	3    5450 9400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FE7D6EE
P 5450 9800
AR Path="/5FE7D6EE" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/5FE7D6EE" Ref="#PWR014"  Part="1" 
F 0 "#PWR014" H 5450 9550 50  0001 C CNN
F 1 "GND" V 5455 9672 50  0000 R CNN
F 2 "" H 5450 9800 50  0001 C CNN
F 3 "" H 5450 9800 50  0001 C CNN
	1    5450 9800
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5FE7DD29
P 5450 9000
AR Path="/5FE7DD29" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/5FE7DD29" Ref="#PWR013"  Part="1" 
F 0 "#PWR013" H 5450 8850 50  0001 C CNN
F 1 "VCC" V 5465 9128 50  0000 L CNN
F 2 "" H 5450 9000 50  0001 C CNN
F 3 "" H 5450 9000 50  0001 C CNN
	1    5450 9000
	1    0    0    -1  
$EndComp
Text Label 4950 7500 0    50   ~ 0
~rdy_int
Text Label 4950 7700 0    50   ~ 0
rdy_int
$Comp
L power:VCC #PWR?
U 1 1 5FE7FC4F
P 4350 7500
AR Path="/5FE7FC4F" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/5FE7FC4F" Ref="#PWR07"  Part="1" 
F 0 "#PWR07" H 4350 7350 50  0001 C CNN
F 1 "VCC" V 4365 7628 50  0000 L CNN
F 2 "" H 4350 7500 50  0001 C CNN
F 3 "" H 4350 7500 50  0001 C CNN
	1    4350 7500
	0    -1   -1   0   
$EndComp
Text Label 4150 3550 2    50   ~ 0
reg_send_cp
Text Label 4350 7600 2    50   ~ 0
reg_send_cp
$Comp
L power:VCC #PWR?
U 1 1 5FE80BC0
P 4650 7300
AR Path="/5FE80BC0" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/5FE80BC0" Ref="#PWR012"  Part="1" 
F 0 "#PWR012" H 4650 7150 50  0001 C CNN
F 1 "VCC" V 4665 7428 50  0000 L CNN
F 2 "" H 4650 7300 50  0001 C CNN
F 3 "" H 4650 7300 50  0001 C CNN
	1    4650 7300
	1    0    0    -1  
$EndComp
Text Label 4650 7900 3    50   ~ 0
~int_rst
Text Label 6950 7500 0    50   ~ 0
clk_ena
NoConn ~ 6950 7700
$Comp
L power:VCC #PWR?
U 1 1 5FE83B74
P 6650 7300
AR Path="/5FE83B74" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/5FE83B74" Ref="#PWR015"  Part="1" 
F 0 "#PWR015" H 6650 7150 50  0001 C CNN
F 1 "VCC" V 6665 7428 50  0000 L CNN
F 2 "" H 6650 7300 50  0001 C CNN
F 3 "" H 6650 7300 50  0001 C CNN
	1    6650 7300
	1    0    0    -1  
$EndComp
Text Label 6650 7900 3    50   ~ 0
~int_rst
Wire Wire Line
	4950 7500 6350 7500
Text Label 6350 7600 2    50   ~ 0
~int_clk
Text HLabel 11300 2500 2    50   Output ~ 0
clk
Text HLabel 11300 2600 2    50   Output ~ 0
mosi
Text HLabel 11300 2700 2    50   Input ~ 0
miso
Text Label 11300 2600 2    50   ~ 0
mosi
Text Label 11300 2500 2    50   ~ 0
clk
Text Label 11300 2700 2    50   ~ 0
miso
Text HLabel 1250 2050 0    50   BiDi ~ 0
d[0..7]
Text Label 1250 2050 0    50   ~ 0
d[0..7]
Text Label 1200 2350 0    50   ~ 0
~rst
Text Label 1200 2550 0    50   ~ 0
~oe
Text Label 1200 2700 0    50   ~ 0
~we
Text HLabel 1200 2550 0    50   Input ~ 0
~oe
Text HLabel 1200 2700 0    50   Input ~ 0
~we
Text HLabel 1200 2850 0    50   Input ~ 0
~sel
Text Label 1200 2850 0    50   ~ 0
~sel
Text GLabel 1200 2350 0    50   Input ~ 0
~rst
Wire Bus Line
	1250 2050 1700 2050
Entry Wire Line
	1800 2450 1700 2350
Entry Wire Line
	1800 2550 1700 2450
Entry Wire Line
	1800 2650 1700 2550
Entry Wire Line
	1800 2750 1700 2650
Entry Wire Line
	1800 2850 1700 2750
Entry Wire Line
	1800 2950 1700 2850
Entry Wire Line
	1800 3050 1700 2950
Entry Wire Line
	1800 3150 1700 3050
Text Label 2000 3150 0    50   ~ 0
d7
Text Label 2000 3050 0    50   ~ 0
d6
Text Label 2000 2950 0    50   ~ 0
d5
Text Label 2000 2850 0    50   ~ 0
d4
Text Label 2000 2750 0    50   ~ 0
d3
Text Label 2000 2650 0    50   ~ 0
d2
Text Label 2000 2550 0    50   ~ 0
d1
Text Label 2000 2450 0    50   ~ 0
d0
Wire Wire Line
	1800 2450 2000 2450
Wire Wire Line
	2000 2550 1800 2550
Wire Wire Line
	1800 2650 2000 2650
Wire Wire Line
	2000 2750 1800 2750
Wire Wire Line
	1800 2850 2000 2850
Wire Wire Line
	2000 2950 1800 2950
Wire Wire Line
	1800 3050 2000 3050
Wire Wire Line
	2000 3150 1800 3150
$Comp
L Device:C C?
U 1 1 604B88D3
P 5450 10550
AR Path="/5FE853A4/604B88D3" Ref="C?"  Part="1" 
AR Path="/5FE5ABE2/604B88D3" Ref="C29"  Part="1" 
F 0 "C29" H 5565 10596 50  0000 L CNN
F 1 "0.1" H 5565 10505 50  0000 L CNN
F 2 "" H 5488 10400 50  0001 C CNN
F 3 "~" H 5450 10550 50  0001 C CNN
	1    5450 10550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 604B88D9
P 5450 10700
AR Path="/5FE853A4/604B88D9" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/604B88D9" Ref="#PWR0158"  Part="1" 
F 0 "#PWR0158" H 5450 10450 50  0001 C CNN
F 1 "GND" H 5455 10527 50  0000 C CNN
F 2 "" H 5450 10700 50  0001 C CNN
F 3 "" H 5450 10700 50  0001 C CNN
	1    5450 10700
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 604B88DF
P 5450 10400
AR Path="/5FE853A4/604B88DF" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/604B88DF" Ref="#PWR0157"  Part="1" 
F 0 "#PWR0157" H 5450 10250 50  0001 C CNN
F 1 "VCC" H 5465 10573 50  0000 C CNN
F 2 "" H 5450 10400 50  0001 C CNN
F 3 "" H 5450 10400 50  0001 C CNN
	1    5450 10400
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 604B9CAB
P 4950 1950
AR Path="/5FE853A4/604B9CAB" Ref="C?"  Part="1" 
AR Path="/5FE5ABE2/604B9CAB" Ref="C27"  Part="1" 
F 0 "C27" H 5065 1996 50  0000 L CNN
F 1 "0.1" H 5065 1905 50  0000 L CNN
F 2 "" H 4988 1800 50  0001 C CNN
F 3 "~" H 4950 1950 50  0001 C CNN
	1    4950 1950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 604B9CB1
P 4950 2100
AR Path="/5FE853A4/604B9CB1" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/604B9CB1" Ref="#PWR0154"  Part="1" 
F 0 "#PWR0154" H 4950 1850 50  0001 C CNN
F 1 "GND" H 4955 1927 50  0000 C CNN
F 2 "" H 4950 2100 50  0001 C CNN
F 3 "" H 4950 2100 50  0001 C CNN
	1    4950 2100
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 604B9CB7
P 4950 1800
AR Path="/5FE853A4/604B9CB7" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/604B9CB7" Ref="#PWR0153"  Part="1" 
F 0 "#PWR0153" H 4950 1650 50  0001 C CNN
F 1 "VCC" H 4965 1973 50  0000 C CNN
F 2 "" H 4950 1800 50  0001 C CNN
F 3 "" H 4950 1800 50  0001 C CNN
	1    4950 1800
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 604BA846
P 7700 1900
AR Path="/5FE853A4/604BA846" Ref="C?"  Part="1" 
AR Path="/5FE5ABE2/604BA846" Ref="C31"  Part="1" 
F 0 "C31" H 7815 1946 50  0000 L CNN
F 1 "0.1" H 7815 1855 50  0000 L CNN
F 2 "" H 7738 1750 50  0001 C CNN
F 3 "~" H 7700 1900 50  0001 C CNN
	1    7700 1900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 604BA84C
P 7700 2050
AR Path="/5FE853A4/604BA84C" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/604BA84C" Ref="#PWR0162"  Part="1" 
F 0 "#PWR0162" H 7700 1800 50  0001 C CNN
F 1 "GND" H 7705 1877 50  0000 C CNN
F 2 "" H 7700 2050 50  0001 C CNN
F 3 "" H 7700 2050 50  0001 C CNN
	1    7700 2050
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 604BA852
P 7700 1750
AR Path="/5FE853A4/604BA852" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/604BA852" Ref="#PWR0161"  Part="1" 
F 0 "#PWR0161" H 7700 1600 50  0001 C CNN
F 1 "VCC" H 7715 1923 50  0000 C CNN
F 2 "" H 7700 1750 50  0001 C CNN
F 3 "" H 7700 1750 50  0001 C CNN
	1    7700 1750
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 604BB018
P 4950 4550
AR Path="/5FE853A4/604BB018" Ref="C?"  Part="1" 
AR Path="/5FE5ABE2/604BB018" Ref="C28"  Part="1" 
F 0 "C28" H 5065 4596 50  0000 L CNN
F 1 "0.1" H 5065 4505 50  0000 L CNN
F 2 "" H 4988 4400 50  0001 C CNN
F 3 "~" H 4950 4550 50  0001 C CNN
	1    4950 4550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 604BB01E
P 4950 4700
AR Path="/5FE853A4/604BB01E" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/604BB01E" Ref="#PWR0156"  Part="1" 
F 0 "#PWR0156" H 4950 4450 50  0001 C CNN
F 1 "GND" H 4955 4527 50  0000 C CNN
F 2 "" H 4950 4700 50  0001 C CNN
F 3 "" H 4950 4700 50  0001 C CNN
	1    4950 4700
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 604BB024
P 4950 4400
AR Path="/5FE853A4/604BB024" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/604BB024" Ref="#PWR0155"  Part="1" 
F 0 "#PWR0155" H 4950 4250 50  0001 C CNN
F 1 "VCC" H 4965 4573 50  0000 C CNN
F 2 "" H 4950 4400 50  0001 C CNN
F 3 "" H 4950 4400 50  0001 C CNN
	1    4950 4400
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 604BBACF
P 7550 4550
AR Path="/5FE853A4/604BBACF" Ref="C?"  Part="1" 
AR Path="/5FE5ABE2/604BBACF" Ref="C30"  Part="1" 
F 0 "C30" H 7665 4596 50  0000 L CNN
F 1 "0.1" H 7665 4505 50  0000 L CNN
F 2 "" H 7588 4400 50  0001 C CNN
F 3 "~" H 7550 4550 50  0001 C CNN
	1    7550 4550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 604BBAD5
P 7550 4700
AR Path="/5FE853A4/604BBAD5" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/604BBAD5" Ref="#PWR0160"  Part="1" 
F 0 "#PWR0160" H 7550 4450 50  0001 C CNN
F 1 "GND" H 7555 4527 50  0000 C CNN
F 2 "" H 7550 4700 50  0001 C CNN
F 3 "" H 7550 4700 50  0001 C CNN
	1    7550 4700
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 604BBADB
P 7550 4400
AR Path="/5FE853A4/604BBADB" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/604BBADB" Ref="#PWR0159"  Part="1" 
F 0 "#PWR0159" H 7550 4250 50  0001 C CNN
F 1 "VCC" H 7565 4573 50  0000 C CNN
F 2 "" H 7550 4400 50  0001 C CNN
F 3 "" H 7550 4400 50  0001 C CNN
	1    7550 4400
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 604BC586
P 9500 4550
AR Path="/5FE853A4/604BC586" Ref="C?"  Part="1" 
AR Path="/5FE5ABE2/604BC586" Ref="C32"  Part="1" 
F 0 "C32" H 9615 4596 50  0000 L CNN
F 1 "0.1" H 9615 4505 50  0000 L CNN
F 2 "" H 9538 4400 50  0001 C CNN
F 3 "~" H 9500 4550 50  0001 C CNN
	1    9500 4550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 604BC58C
P 9500 4700
AR Path="/5FE853A4/604BC58C" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/604BC58C" Ref="#PWR0164"  Part="1" 
F 0 "#PWR0164" H 9500 4450 50  0001 C CNN
F 1 "GND" H 9505 4527 50  0000 C CNN
F 2 "" H 9500 4700 50  0001 C CNN
F 3 "" H 9500 4700 50  0001 C CNN
	1    9500 4700
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 604BC592
P 9500 4400
AR Path="/5FE853A4/604BC592" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/604BC592" Ref="#PWR0163"  Part="1" 
F 0 "#PWR0163" H 9500 4250 50  0001 C CNN
F 1 "VCC" H 9515 4573 50  0000 C CNN
F 2 "" H 9500 4400 50  0001 C CNN
F 3 "" H 9500 4400 50  0001 C CNN
	1    9500 4400
	1    0    0    -1  
$EndComp
Wire Bus Line
	1700 2050 1700 3050
Text GLabel 11000 4150 3    50   Input ~ 0
~rdy
$Comp
L Device:Q_PMOS_DGS Q4
U 1 1 604BE672
P 10900 3950
F 0 "Q4" H 11105 3904 50  0000 L CNN
F 1 "Q_PMOS_DGS" H 11105 3995 50  0000 L CNN
F 2 "" H 11100 4050 50  0001 C CNN
F 3 "~" H 10900 3950 50  0001 C CNN
	1    10900 3950
	1    0    0    1   
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 604C2364
P 11000 3750
AR Path="/5FE853A4/604C2364" Ref="#PWR?"  Part="1" 
AR Path="/5FE5ABE2/604C2364" Ref="#PWR0165"  Part="1" 
F 0 "#PWR0165" H 11000 3600 50  0001 C CNN
F 1 "VCC" H 11015 3923 50  0000 C CNN
F 2 "" H 11000 3750 50  0001 C CNN
F 3 "" H 11000 3750 50  0001 C CNN
	1    11000 3750
	1    0    0    -1  
$EndComp
Text Label 10700 3950 2    50   ~ 0
rdy
$EndSCHEMATC
