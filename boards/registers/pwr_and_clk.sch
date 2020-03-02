EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 10 10
Title "Clock, reset, and power input"
Date "2020-01-07"
Rev "1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 5850 1750 2    50   Output ~ 0
clk
Text HLabel 5100 3000 2    50   Output ~ 0
~rst
Text HLabel 5850 2050 2    50   Output ~ 0
~clk
$Comp
L 74xx:74HC14 U34
U 1 1 5EF0663E
P 3550 1750
F 0 "U34" H 3550 2067 50  0000 C CNN
F 1 "74ACT14MTCX" H 3550 1976 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 3550 1750 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 3550 1750 50  0001 C CNN
	1    3550 1750
	1    0    0    -1  
$EndComp
$Comp
L Device:R R171
U 1 1 5EF09E34
P 3550 1200
F 0 "R171" V 3343 1200 50  0000 C CNN
F 1 "100k" V 3434 1200 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 3480 1200 50  0001 C CNN
F 3 "~" H 3550 1200 50  0001 C CNN
	1    3550 1200
	0    1    1    0   
$EndComp
$Comp
L Device:C C34
U 1 1 5EF0A8C4
P 2800 1900
F 0 "C34" H 2915 1946 50  0000 L CNN
F 1 "C" H 2915 1855 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 2838 1750 50  0001 C CNN
F 3 "~" H 2800 1900 50  0001 C CNN
	1    2800 1900
	1    0    0    -1  
$EndComp
Wire Wire Line
	2800 1750 2800 1200
Wire Wire Line
	3700 1200 3850 1200
Wire Wire Line
	3850 1200 3850 1650
$Comp
L power:GND #PWR0221
U 1 1 5EF0B4A1
P 2800 2050
F 0 "#PWR0221" H 2800 1800 50  0001 C CNN
F 1 "GND" H 2805 1877 50  0000 C CNN
F 2 "" H 2800 2050 50  0001 C CNN
F 3 "" H 2800 2050 50  0001 C CNN
	1    2800 2050
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC14 U34
U 2 1 5EF0B79E
P 4950 1750
F 0 "U34" H 4950 2067 50  0000 C CNN
F 1 "74ACT14MTCX" H 4950 1976 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 4950 1750 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 4950 1750 50  0001 C CNN
	2    4950 1750
	1    0    0    -1  
$EndComp
$Comp
L Device:R R168
U 1 1 5EF0F1E2
P 3100 1750
F 0 "R168" V 2893 1750 50  0000 C CNN
F 1 "10k" V 2984 1750 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 3030 1750 50  0001 C CNN
F 3 "~" H 3100 1750 50  0001 C CNN
	1    3100 1750
	0    1    1    0   
$EndComp
Wire Wire Line
	2950 1750 2800 1750
Connection ~ 2800 1750
Wire Wire Line
	2800 1200 3400 1200
$Comp
L Device:R R166
U 1 1 5EF0FCD1
P 2650 2850
F 0 "R166" H 2900 2800 50  0000 R CNN
F 1 "100k" H 2900 2900 50  0000 R CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 2580 2850 50  0001 C CNN
F 3 "~" H 2650 2850 50  0001 C CNN
	1    2650 2850
	-1   0    0    1   
$EndComp
$Comp
L 74xx:74HC14 U34
U 3 1 5EF10AA7
P 5550 1750
F 0 "U34" H 5550 2067 50  0000 C CNN
F 1 "74ACT14MTCX" H 5550 1976 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 5550 1750 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 5550 1750 50  0001 C CNN
	3    5550 1750
	1    0    0    -1  
$EndComp
$Comp
L Device:R R169
U 1 1 5EF12F5C
P 3100 3000
F 0 "R169" V 3200 3000 50  0000 C CNN
F 1 "10k" V 3300 3000 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 3030 3000 50  0001 C CNN
F 3 "~" H 3100 3000 50  0001 C CNN
	1    3100 3000
	0    1    1    0   
$EndComp
$Comp
L Device:C C35
U 1 1 5EF136E4
P 2850 2850
F 0 "C35" H 2965 2896 50  0000 L CNN
F 1 "220n" H 2965 2805 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 2888 2700 50  0001 C CNN
F 3 "~" H 2850 2850 50  0001 C CNN
	1    2850 2850
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 3000 2850 3000
$Comp
L Device:D D62
U 1 1 5EF19BA6
P 3550 2400
F 0 "D62" H 3550 2616 50  0000 C CNN
F 1 "D" H 3550 2525 50  0000 C CNN
F 2 "Diode_SMD:D_MiniMELF" H 3550 2400 50  0001 C CNN
F 3 "~" H 3550 2400 50  0001 C CNN
	1    3550 2400
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 1750 2800 1750
$Comp
L 74xx:74HC14 U34
U 4 1 5EF1CCB5
P 3550 3000
F 0 "U34" H 3550 3317 50  0000 C CNN
F 1 "74ACT14MTCX" H 3550 3226 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 3550 3000 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 3550 3000 50  0001 C CNN
	4    3550 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	5850 2050 5250 2050
Wire Wire Line
	5250 2050 5250 1750
Connection ~ 5250 1750
$Comp
L 74xx:74HC14 U34
U 5 1 5EF2B385
P 3550 4400
F 0 "U34" H 3550 4717 50  0000 C CNN
F 1 "74ACT14MTCX" H 3550 4626 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 3550 4400 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 3550 4400 50  0001 C CNN
	5    3550 4400
	1    0    0    -1  
$EndComp
$Comp
L Device:R R167
U 1 1 5EF33330
P 2650 4250
F 0 "R167" H 2900 3900 50  0000 R CNN
F 1 "100k" H 2900 4000 50  0000 R CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 2580 4250 50  0001 C CNN
F 3 "~" H 2650 4250 50  0001 C CNN
	1    2650 4250
	-1   0    0    1   
$EndComp
$Comp
L Device:R R170
U 1 1 5EF3333C
P 3100 4400
F 0 "R170" V 3200 4350 50  0000 C CNN
F 1 "10k" V 3300 4350 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 3030 4400 50  0001 C CNN
F 3 "~" H 3100 4400 50  0001 C CNN
	1    3100 4400
	0    1    1    0   
$EndComp
$Comp
L Device:C C36
U 1 1 5EF33342
P 2950 4250
F 0 "C36" H 3065 4296 50  0000 L CNN
F 1 "220n" H 3065 4205 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 2988 4100 50  0001 C CNN
F 3 "~" H 2950 4250 50  0001 C CNN
	1    2950 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 4400 2950 4400
Connection ~ 2950 4400
Wire Wire Line
	2650 4400 2450 4400
Connection ~ 2650 4400
$Comp
L Switch:SW_SPDT SW3
U 1 1 5EF35857
P 4450 1750
F 0 "SW3" H 4500 2000 50  0000 C CNN
F 1 "OS102011MS2QN1" H 4250 2100 50  0000 C CNN
F 2 "Button_Switch_THT:SW_Slide_1P2T_CK_OS102011MS2Q" H 4450 1750 50  0001 C CNN
F 3 "~" H 4450 1750 50  0001 C CNN
	1    4450 1750
	-1   0    0    1   
$EndComp
Wire Wire Line
	4250 1650 3850 1650
Connection ~ 3850 1650
Wire Wire Line
	3850 1650 3850 1750
Wire Wire Line
	4250 4400 3850 4400
$Comp
L power:VCC #PWR0220
U 1 1 5EF38BAF
P 2650 4100
F 0 "#PWR0220" H 2650 3950 50  0001 C CNN
F 1 "VCC" H 2667 4273 50  0000 C CNN
F 2 "" H 2650 4100 50  0001 C CNN
F 3 "" H 2650 4100 50  0001 C CNN
	1    2650 4100
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0223
U 1 1 5EF39516
P 2950 4100
F 0 "#PWR0223" H 2950 3950 50  0001 C CNN
F 1 "VCC" H 2967 4273 50  0000 C CNN
F 2 "" H 2950 4100 50  0001 C CNN
F 3 "" H 2950 4100 50  0001 C CNN
	1    2950 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	4250 1850 4250 4400
$Comp
L 74xx:74HC14 U34
U 6 1 5EF430CB
P 4800 3000
F 0 "U34" H 4800 3317 50  0000 C CNN
F 1 "74ACT14MTCX" H 4800 3226 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 4800 3000 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 4800 3000 50  0001 C CNN
	6    4800 3000
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC14 U34
U 7 1 5EF46B20
P 6800 4450
F 0 "U34" H 7030 4496 50  0000 L CNN
F 1 "74ACT14MTCX" H 7030 4405 50  0000 L CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 6800 4450 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 6800 4450 50  0001 C CNN
	7    6800 4450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0226
U 1 1 5EF48330
P 6800 4950
F 0 "#PWR0226" H 6800 4700 50  0001 C CNN
F 1 "GND" H 6805 4777 50  0000 C CNN
F 2 "" H 6800 4950 50  0001 C CNN
F 3 "" H 6800 4950 50  0001 C CNN
	1    6800 4950
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0225
U 1 1 5EF489A9
P 6800 3950
F 0 "#PWR0225" H 6800 3800 50  0001 C CNN
F 1 "VCC" H 6817 4123 50  0000 C CNN
F 2 "" H 6800 3950 50  0001 C CNN
F 3 "" H 6800 3950 50  0001 C CNN
	1    6800 3950
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J4
U 1 1 5EF4AAE6
P 8250 1400
F 0 "J4" H 8600 1250 50  0000 C CNN
F 1 "5V" H 8600 1400 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 8250 1400 50  0001 C CNN
F 3 "~" H 8250 1400 50  0001 C CNN
	1    8250 1400
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR0230
U 1 1 5EF4B86D
P 8450 1400
F 0 "#PWR0230" H 8450 1150 50  0001 C CNN
F 1 "GND" H 8455 1227 50  0000 C CNN
F 2 "" H 8450 1400 50  0001 C CNN
F 3 "" H 8450 1400 50  0001 C CNN
	1    8450 1400
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0229
U 1 1 5EF4BF47
P 8450 1300
F 0 "#PWR0229" H 8450 1150 50  0001 C CNN
F 1 "VCC" H 8467 1473 50  0000 C CNN
F 2 "" H 8450 1300 50  0001 C CNN
F 3 "" H 8450 1300 50  0001 C CNN
	1    8450 1300
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C38
U 1 1 5EF4DEE4
P 9000 1350
F 0 "C38" H 9118 1396 50  0000 L CNN
F 1 "100u" H 9118 1305 50  0000 L CNN
F 2 "Capacitor_SMD:CP_Elec_4x4.5" H 9038 1200 50  0001 C CNN
F 3 "~" H 9000 1350 50  0001 C CNN
	1    9000 1350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0232
U 1 1 5EF4E88F
P 9000 1500
F 0 "#PWR0232" H 9000 1250 50  0001 C CNN
F 1 "GND" H 9005 1327 50  0000 C CNN
F 2 "" H 9000 1500 50  0001 C CNN
F 3 "" H 9000 1500 50  0001 C CNN
	1    9000 1500
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0231
U 1 1 5EF4ED4D
P 9000 1200
F 0 "#PWR0231" H 9000 1050 50  0001 C CNN
F 1 "VCC" H 9017 1373 50  0000 C CNN
F 2 "" H 9000 1200 50  0001 C CNN
F 3 "" H 9000 1200 50  0001 C CNN
	1    9000 1200
	1    0    0    -1  
$EndComp
$Comp
L Device:C C37
U 1 1 5EF50873
P 7700 4450
F 0 "C37" H 7815 4496 50  0000 L CNN
F 1 "0.1u" H 7815 4405 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 7738 4300 50  0001 C CNN
F 3 "~" H 7700 4450 50  0001 C CNN
	1    7700 4450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0228
U 1 1 5EF50EFD
P 7700 4600
F 0 "#PWR0228" H 7700 4350 50  0001 C CNN
F 1 "GND" H 7705 4427 50  0000 C CNN
F 2 "" H 7700 4600 50  0001 C CNN
F 3 "" H 7700 4600 50  0001 C CNN
	1    7700 4600
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0227
U 1 1 5EF5151C
P 7700 4300
F 0 "#PWR0227" H 7700 4150 50  0001 C CNN
F 1 "VCC" H 7717 4473 50  0000 C CNN
F 2 "" H 7700 4300 50  0001 C CNN
F 3 "" H 7700 4300 50  0001 C CNN
	1    7700 4300
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG01
U 1 1 5EF82079
P 9650 1200
F 0 "#FLG01" H 9650 1275 50  0001 C CNN
F 1 "PWR_FLAG" H 9650 1373 50  0000 C CNN
F 2 "" H 9650 1200 50  0001 C CNN
F 3 "~" H 9650 1200 50  0001 C CNN
	1    9650 1200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0233
U 1 1 5EF830E9
P 9650 1200
F 0 "#PWR0233" H 9650 950 50  0001 C CNN
F 1 "GND" H 9655 1027 50  0000 C CNN
F 2 "" H 9650 1200 50  0001 C CNN
F 3 "" H 9650 1200 50  0001 C CNN
	1    9650 1200
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0234
U 1 1 5EF8368B
P 10050 1200
F 0 "#PWR0234" H 10050 1050 50  0001 C CNN
F 1 "VCC" H 10067 1373 50  0000 C CNN
F 2 "" H 10050 1200 50  0001 C CNN
F 3 "" H 10050 1200 50  0001 C CNN
	1    10050 1200
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG02
U 1 1 5EF840F1
P 10050 1200
F 0 "#FLG02" H 10050 1275 50  0001 C CNN
F 1 "PWR_FLAG" H 10050 1373 50  0000 C CNN
F 2 "" H 10050 1200 50  0001 C CNN
F 3 "~" H 10050 1200 50  0001 C CNN
	1    10050 1200
	-1   0    0    1   
$EndComp
$Comp
L Switch:SW_Push SW2
U 1 1 5FB8F28D
P 2250 4400
F 0 "SW2" H 2250 4685 50  0000 C CNN
F 1 "STEP" H 2250 4594 50  0000 C CNN
F 2 "Button_Switch_THT:SW_PUSH_6mm" H 2250 4600 50  0001 C CNN
F 3 "~" H 2250 4600 50  0001 C CNN
	1    2250 4400
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW1
U 1 1 5FB8F94E
P 2200 3000
F 0 "SW1" H 2200 3285 50  0000 C CNN
F 1 "RESET" H 2200 3194 50  0000 C CNN
F 2 "Button_Switch_THT:SW_PUSH_6mm" H 2200 3200 50  0001 C CNN
F 3 "~" H 2200 3200 50  0001 C CNN
	1    2200 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4500 3000 4000 3000
Wire Wire Line
	4000 3000 4000 2400
Wire Wire Line
	4000 2400 3700 2400
Connection ~ 4000 3000
Wire Wire Line
	4000 3000 3850 3000
Wire Wire Line
	3400 2400 2650 2400
Wire Wire Line
	2650 2400 2650 1750
$Comp
L power:GND #PWR0101
U 1 1 5FBA3876
P 2000 3000
F 0 "#PWR0101" H 2000 2750 50  0001 C CNN
F 1 "GND" V 2005 2872 50  0000 R CNN
F 2 "" H 2000 3000 50  0001 C CNN
F 3 "" H 2000 3000 50  0001 C CNN
	1    2000 3000
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0106
U 1 1 5FBA3DBF
P 2050 4400
F 0 "#PWR0106" H 2050 4150 50  0001 C CNN
F 1 "GND" V 2055 4272 50  0000 R CNN
F 2 "" H 2050 4400 50  0001 C CNN
F 3 "" H 2050 4400 50  0001 C CNN
	1    2050 4400
	0    1    1    0   
$EndComp
Wire Wire Line
	2950 3000 2850 3000
Connection ~ 2850 3000
$Comp
L power:VCC #PWR0107
U 1 1 5FBA8516
P 2650 2700
F 0 "#PWR0107" H 2650 2550 50  0001 C CNN
F 1 "VCC" H 2667 2873 50  0000 C CNN
F 2 "" H 2650 2700 50  0001 C CNN
F 3 "" H 2650 2700 50  0001 C CNN
	1    2650 2700
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0124
U 1 1 5FBA8A47
P 2850 2700
F 0 "#PWR0124" H 2850 2550 50  0001 C CNN
F 1 "VCC" H 2867 2873 50  0000 C CNN
F 2 "" H 2850 2700 50  0001 C CNN
F 3 "" H 2850 2700 50  0001 C CNN
	1    2850 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	2400 3000 2650 3000
Connection ~ 2650 3000
Text Notes 4550 1600 2    50   ~ 0
STEP/RUN
Text Notes 2300 3150 2    50   ~ 0
RESET
Text Notes 2350 4550 2    50   ~ 0
STEP
$EndSCHEMATC
