.PHONY: all clean


all: test_receiver test_filter test_rs_recv_frame

clean:
	rm -f test_receiver
	rm -f test_filter
	rm -f test_rs_recv_frame
	rm -f *.vcd

test_receiver: test_receiver.v ../receiver.v ../../74xx/counter_74161.v ../../74xx/shift_74164.v ../../74xx/d_ff_7474.v ../../74xx/counter_744040.v
	iverilog -o $@ $^
	./verilog-verify.sh ./$@

test_filter: test_filter.v ../filter.v ../receiver.v ../../74xx/counter_74161.v ../../74xx/shift_74164.v ../../74xx/d_ff_7474.v ../../74xx/counter_744040.v
	iverilog -o $@ $^
	./verilog-verify.sh ./$@

test_rs_recv_frame: test_rs_recv_frame.v ../receiver_system.v ../filter.v ../receiver.v ../../async_ram.v ../../74xx/counter_74161.v ../../74xx/shift_74164.v ../../74xx/d_ff_7474.v ../../74xx/counter_744040.v ../../74xx/buffer_74244.v ../../74xx/mux_74157.v
	iverilog -o $@ $^
	./verilog-verify.sh ./$@
