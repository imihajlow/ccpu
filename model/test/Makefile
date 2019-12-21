.PHONY: all

all: test_uni_reg
	./test_uni_reg

test_uni_reg: test_uni_reg.v ../uni_reg.v ../74xx/counter_74163.v
	iverilog -o $@ $^
