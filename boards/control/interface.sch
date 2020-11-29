EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 2
Title "Interface connector"
Date "2020-11-29"
Rev "3"
Comp ""
Comment1 "Licensed under the TAPR Open Hardware License (www.tapr.org/OHL)"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 5550 4100 0    50   Output ~ 0
clk
Text HLabel 6250 4100 2    50   Output ~ 0
~rst
Text HLabel 4700 3850 0    50   Output ~ 0
ir[0..7]
Text HLabel 4700 3550 0    50   Output ~ 0
flags[0..3]
Text HLabel 6250 4600 2    50   Input ~ 0
~we_mem
Text HLabel 5550 3000 0    50   Input ~ 0
~oe_d_di
Text HLabel 6250 3000 2    50   Input ~ 0
we_ir
Text HLabel 5550 3100 0    50   Input ~ 0
inc_ip
Text HLabel 6250 3100 2    50   Input ~ 0
addr_dp
Text HLabel 5550 3200 0    50   Input ~ 0
p_selector
Text HLabel 6250 3200 2    50   Input ~ 0
~we_pl
Text HLabel 5550 3300 0    50   Input ~ 0
~we_ph
Text HLabel 6250 3300 2    50   Input ~ 0
we_a
Text HLabel 5550 4200 0    50   Input ~ 0
we_b
Text HLabel 6250 4200 2    50   Input ~ 0
~oe_ph_alu
Text HLabel 5550 4300 0    50   Input ~ 0
~oe_pl_alu
Text HLabel 5550 4400 0    50   Input ~ 0
~oe_a_d
Text HLabel 6250 4400 2    50   Input ~ 0
~oe_b_d
Text HLabel 5550 4500 0    50   Input ~ 0
~we_flags
Text HLabel 6250 4500 2    50   Input ~ 0
~oe_alu
Text HLabel 6250 4300 2    50   Input ~ 0
~oe_b_alu
$Comp
L Connector_Generic:Conn_02x20_Odd_Even J1
U 1 1 5EDA71CD
P 5850 3700
F 0 "J1" H 5900 4817 50  0000 C CNN
F 1 "61304021021" H 5900 4726 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x20_P2.54mm_Horizontal" H 5850 3700 50  0001 C CNN
F 3 "~" H 5850 3700 50  0001 C CNN
	1    5850 3700
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR060
U 1 1 5EDAB67E
P 5650 2800
F 0 "#PWR060" H 5650 2650 50  0001 C CNN
F 1 "VCC" V 5668 2927 50  0000 L CNN
F 2 "" H 5650 2800 50  0001 C CNN
F 3 "" H 5650 2800 50  0001 C CNN
	1    5650 2800
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR063
U 1 1 5EDABE71
P 6150 4700
F 0 "#PWR063" H 6150 4550 50  0001 C CNN
F 1 "VCC" V 6167 4828 50  0000 L CNN
F 2 "" H 6150 4700 50  0001 C CNN
F 3 "" H 6150 4700 50  0001 C CNN
	1    6150 4700
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR061
U 1 1 5EDAC68A
P 5650 4700
F 0 "#PWR061" H 5650 4450 50  0001 C CNN
F 1 "GND" V 5655 4572 50  0000 R CNN
F 2 "" H 5650 4700 50  0001 C CNN
F 3 "" H 5650 4700 50  0001 C CNN
	1    5650 4700
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR062
U 1 1 5EDACBD5
P 6150 2800
F 0 "#PWR062" H 6150 2550 50  0001 C CNN
F 1 "GND" V 6155 2672 50  0000 R CNN
F 2 "" H 6150 2800 50  0001 C CNN
F 3 "" H 6150 2800 50  0001 C CNN
	1    6150 2800
	0    -1   -1   0   
$EndComp
Entry Wire Line
	4800 3800 4900 3700
Entry Wire Line
	4800 3900 4900 3800
Entry Wire Line
	4800 4000 4900 3900
Entry Wire Line
	4800 3700 4900 3600
Entry Wire Line
	6850 3900 6950 3800
Entry Wire Line
	6850 3800 6950 3700
Entry Wire Line
	6850 3700 6950 3600
Entry Wire Line
	6850 3600 6950 3500
Text Label 5500 3600 0    50   ~ 0
ir0
Text Label 5500 3700 0    50   ~ 0
ir2
Text Label 5500 3800 0    50   ~ 0
ir4
Text Label 5500 3900 0    50   ~ 0
ir6
Text Label 6250 3600 0    50   ~ 0
ir1
Text Label 6250 3700 0    50   ~ 0
ir3
Text Label 6250 3800 0    50   ~ 0
ir5
Text Label 6250 3900 0    50   ~ 0
ir7
Entry Wire Line
	6850 3500 6950 3400
Entry Wire Line
	6850 3400 6950 3300
Entry Wire Line
	4800 3600 4900 3500
Entry Wire Line
	4800 3500 4900 3400
Text Label 5350 3400 0    50   ~ 0
flags0
Text Label 5350 3500 0    50   ~ 0
flags2
Text Label 6250 3400 0    50   ~ 0
flags1
Text Label 6250 3500 0    50   ~ 0
flags3
Wire Wire Line
	5650 4100 5550 4100
Text HLabel 5550 4600 0    50   Input ~ 0
~oe_mem
Wire Wire Line
	6150 3400 6850 3400
Wire Wire Line
	6150 3500 6850 3500
Wire Wire Line
	6150 3600 6850 3600
Wire Wire Line
	6150 3700 6850 3700
Wire Wire Line
	6150 3800 6850 3800
Wire Wire Line
	6150 3900 6850 3900
Wire Wire Line
	4900 3600 5650 3600
Wire Wire Line
	4900 3700 5650 3700
Wire Wire Line
	4900 3800 5650 3800
Wire Wire Line
	4900 3900 5650 3900
Wire Wire Line
	4900 3500 5650 3500
Wire Wire Line
	4900 3400 5650 3400
Wire Bus Line
	6950 4800 4800 4800
Wire Bus Line
	4700 3850 4800 3850
Connection ~ 4800 3850
Wire Bus Line
	4800 2450 6950 2450
Wire Bus Line
	4700 3550 4800 3550
Connection ~ 4800 3550
Wire Bus Line
	4800 3550 4800 3600
Wire Wire Line
	6150 4100 6250 4100
NoConn ~ 5650 4000
NoConn ~ 5650 2900
NoConn ~ 6150 2900
Wire Wire Line
	5650 4500 5550 4500
Wire Wire Line
	5550 4400 5650 4400
Wire Wire Line
	5650 4300 5550 4300
Wire Wire Line
	5650 4200 5550 4200
Wire Wire Line
	6150 4200 6250 4200
Wire Wire Line
	6250 4300 6150 4300
Wire Wire Line
	6150 4400 6250 4400
Wire Wire Line
	6250 4500 6150 4500
Wire Wire Line
	6250 3300 6150 3300
Wire Wire Line
	6150 3200 6250 3200
Wire Wire Line
	6250 3100 6150 3100
Wire Wire Line
	6150 3000 6250 3000
Wire Wire Line
	6250 4600 6150 4600
Wire Wire Line
	5650 4600 5550 4600
Wire Wire Line
	5550 3000 5650 3000
Wire Wire Line
	5650 3100 5550 3100
Wire Wire Line
	5550 3200 5650 3200
Wire Wire Line
	5650 3300 5550 3300
$Comp
L power:PWR_FLAG #FLG01
U 1 1 5FFEED9A
P 8100 3100
F 0 "#FLG01" H 8100 3175 50  0001 C CNN
F 1 "PWR_FLAG" H 8100 3273 50  0000 C CNN
F 2 "" H 8100 3100 50  0001 C CNN
F 3 "~" H 8100 3100 50  0001 C CNN
	1    8100 3100
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG02
U 1 1 5FFEF093
P 8550 3100
F 0 "#FLG02" H 8550 3175 50  0001 C CNN
F 1 "PWR_FLAG" H 8550 3273 50  0000 C CNN
F 2 "" H 8550 3100 50  0001 C CNN
F 3 "~" H 8550 3100 50  0001 C CNN
	1    8550 3100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR067
U 1 1 5FFEF396
P 8550 3100
F 0 "#PWR067" H 8550 2850 50  0001 C CNN
F 1 "GND" V 8555 2972 50  0000 R CNN
F 2 "" H 8550 3100 50  0001 C CNN
F 3 "" H 8550 3100 50  0001 C CNN
	1    8550 3100
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR064
U 1 1 5FFEFB40
P 8100 3100
F 0 "#PWR064" H 8100 2950 50  0001 C CNN
F 1 "VCC" V 8118 3227 50  0000 L CNN
F 2 "" H 8100 3100 50  0001 C CNN
F 3 "" H 8100 3100 50  0001 C CNN
	1    8100 3100
	-1   0    0    1   
$EndComp
$Comp
L Device:CP C4
U 1 1 5FFF064D
P 8200 3950
F 0 "C4" H 8318 3996 50  0000 L CNN
F 1 "10u 6.3v" H 8318 3905 50  0000 L CNN
F 2 "Capacitor_SMD:CP_Elec_4x4.5" H 8238 3800 50  0001 C CNN
F 3 "~" H 8200 3950 50  0001 C CNN
	1    8200 3950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR066
U 1 1 5FFF0D8B
P 8200 4100
F 0 "#PWR066" H 8200 3850 50  0001 C CNN
F 1 "GND" V 8205 3972 50  0000 R CNN
F 2 "" H 8200 4100 50  0001 C CNN
F 3 "" H 8200 4100 50  0001 C CNN
	1    8200 4100
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR065
U 1 1 5FFF1304
P 8200 3800
F 0 "#PWR065" H 8200 3650 50  0001 C CNN
F 1 "VCC" V 8218 3927 50  0000 L CNN
F 2 "" H 8200 3800 50  0001 C CNN
F 3 "" H 8200 3800 50  0001 C CNN
	1    8200 3800
	1    0    0    -1  
$EndComp
Text HLabel 6250 4000 2    50   Output ~ 0
~mem_rdy
Wire Wire Line
	6150 4000 6250 4000
Wire Bus Line
	4800 3700 4800 3850
Wire Bus Line
	4800 2450 4800 3550
Wire Bus Line
	6950 2450 6950 3400
Wire Bus Line
	4800 3850 4800 4800
Wire Bus Line
	6950 3500 6950 4800
$EndSCHEMATC
