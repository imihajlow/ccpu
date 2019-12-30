.PHONY: all alu

all: test_pointer_reg test_pointer_pair test_control_unit test_cpu test_74153 test_gp_reg
	./test_74153
	./test_gp_reg
	./test_pointer_reg
	./test_pointer_pair
	./test_control_unit
	./test_cpu

alu: test_alu
	./test_alu

test_pointer_reg: test_pointer_reg.v ../pointer_reg.v ../74xx/counter_74161.v ../74xx/buffer_74244.v
	iverilog -o $@ $^

test_pointer_pair: test_pointer_pair.v ../pointer_pair.v ../pointer_reg.v ../74xx/counter_74161.v ../74xx/selector_74153.v ../74xx/buffer_74244.v
	iverilog -o $@ $^

test_control_unit: test_control_unit.v ../control_unit.v
	iverilog -o $@ $^

test_alu: test_alu.v ../alu.v ../alu_hi.v ../alu_lo.v alu_lo.mem alu_hi.mem
	iverilog -o $@ $(filter %.v,$^)

test_cpu: test_cpu.v ../cpu.v ../alu.v ../alu_hi.v ../alu_lo.v alu_lo.mem alu_hi.mem ../control_unit.v ../pointer_pair.v ../pointer_reg.v ../74xx/counter_74161.v ../gp_reg_b.v test_cpu.hex ../74xx/selector_74153.v ../74xx/register_74273.v ../74xx/buffer_74244.v
	iverilog -o $@ $(filter %.v,$^)

test_74153: test_74153.v ../74xx/selector_74153.v
	iverilog -o $@ $^

test_gp_reg: test_gp_reg.v ../gp_reg_b.v ../74xx/buffer_74244.v ../74xx/register_74273.v
	iverilog -o $@ $^

alu_lo.mem: ../../tools/gen-alu.py
	../../tools/gen-alu.py

alu_hi.mem: alu_lo.mem

%.hex: %.asm ../../tools/asm.py
	../../tools/asm.py -o $@ $<
