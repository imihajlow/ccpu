.PHONY: all

all: test_uni_reg test_pointer_reg test_pointer_pair
	./test_uni_reg
	./test_pointer_reg
	./test_pointer_pair

test_uni_reg: test_uni_reg.v ../uni_reg.v ../74xx/counter_74163.v
	iverilog -o $@ $^

test_pointer_reg: test_pointer_reg.v ../pointer_reg.v ../uni_reg.v ../74xx/counter_74163.v
	iverilog -o $@ $^

test_pointer_pair: test_pointer_pair.v ../pointer_pair.v ../pointer_reg.v ../uni_reg.v ../74xx/counter_74163.v
	iverilog -o $@ $^
