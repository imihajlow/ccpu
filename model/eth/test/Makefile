.PHONY: all clean


all: test_receiver test_filter

clean:
	rm -f test_receiver
	rm -f *.vcd

test_receiver: test_receiver.v ../receiver.v ../../74xx/counter_74161.v ../../74xx/shift_74164.v ../../74xx/d_ff_7474.v ../../74xx/counter_744040.v
	iverilog -o $@ $^
	./verilog-verify.sh ./$@

test_filter: test_filter.v ../filter.v ../receiver.v ../../74xx/counter_74161.v ../../74xx/shift_74164.v ../../74xx/d_ff_7474.v ../../74xx/counter_744040.v
	iverilog -o $@ $^
	./verilog-verify.sh ./$@
