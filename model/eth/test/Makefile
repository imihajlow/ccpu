.PHONY: all clean

DEPS=../../async_ram.v ../../74xx/counter_74161.v ../../74xx/shift_74164.v ../../74xx/d_ff_7474.v ../../74xx/counter_744040.v ../../74xx/buffer_74244.v ../../74xx/mux_74157.v ../../74xx/decoder_74139.v
TX_DEPS=../../async_ram.v ../../74xx/register_74273.v ../../74xx/counter_74161.v ../../74xx/shift_74165.v ../../74xx/d_ff_7474.v ../../74xx/counter_744040.v ../../74xx/buffer_74244.v ../../74xx/mux_74157.v ../../74xx/decoder_74139.v

all: test_receiver test_filter test_rs_1 test_rs_2 test_rs_3 test_rs_4 test_rs_5 test_rs_6 test_transmitter test_transmitter_2

clean:
	rm -f test_transmitter
	rm -f test_receiver
	rm -f test_filter
	rm -f test_rs_1
	rm -f test_rs_2
	rm -f test_rs_3
	rm -f test_rs_4
	rm -f test_rs_5
	rm -f test_rs_6
	rm -f *.vcd

test_transmitter: test_transmitter.v ../transmitter.v ${TX_DEPS}
	iverilog -o $@ $^
	./verilog-verify.sh ./$@


test_transmitter_2: test_transmitter_2.v ../transmitter.v ${TX_DEPS}
	iverilog -o $@ $^
	./verilog-verify.sh ./$@

test_receiver: test_receiver.v ../receiver.v ../../74xx/counter_74161.v ../../74xx/shift_74164.v ../../74xx/d_ff_7474.v ../../74xx/counter_744040.v
	iverilog -o $@ $^
	./verilog-verify.sh ./$@

test_filter: test_filter.v ../filter.v ../receiver.v ../../74xx/counter_74161.v ../../74xx/shift_74164.v ../../74xx/d_ff_7474.v ../../74xx/counter_744040.v
	iverilog -o $@ $^
	./verilog-verify.sh ./$@

test_rs_1: test_rs_1.v ../receiver_system.v ../filter.v ../receiver.v ${DEPS}
	iverilog -o $@ $^
	./verilog-verify.sh ./$@

test_rs_2: test_rs_2.v ../receiver_system.v ../filter.v ../receiver.v ${DEPS}
	iverilog -o $@ $^
	./verilog-verify.sh ./$@

test_rs_3: test_rs_3.v ../receiver_system.v ../filter.v ../receiver.v ${DEPS}
	iverilog -o $@ $^
	./verilog-verify.sh ./$@

test_rs_4: test_rs_4.v ../receiver_system.v ../filter.v ../receiver.v ${DEPS}
	iverilog -o $@ $^
	./verilog-verify.sh ./$@

test_rs_5: test_rs_5.v ../receiver_system.v ../filter.v ../receiver.v ${DEPS}
	iverilog -o $@ $^
	./verilog-verify.sh ./$@

test_rs_6: test_rs_6.v ../receiver_system.v ../filter.v ../receiver.v ${DEPS}
	iverilog -o $@ $^
	./verilog-verify.sh ./$@
