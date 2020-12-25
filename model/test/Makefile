.PHONY: all clean


all: test_pointer_reg test_pointer_pair test_control_unit test_cpu test_74153 test_gp_reg_a test_gp_reg_b test_7474 test_74151 test_vga_ctrl test_vga test_io test_spi test_ps2

clean:
	rm -f ./test_adder ./test_7474 ./test_74153 ./test_gp_reg_a ./test_gp_reg_b ./test_pointer_reg ./test_pointer_pair ./test_control_unit ./test_cpu ./test_vga ./test_vga_ctrl
	rm -f test_alu
	rm -f test_spi
	rm -f test_ps2

test_adder: test_adder.v ../adder.v
	iverilog -o $@ $^
	./verilog-verify.sh ./test_adder

test_pointer_reg: test_pointer_reg.v ../pointer_reg.v ../74xx/counter_74161.v ../74xx/buffer_74244.v
	iverilog -o $@ $^
	./verilog-verify.sh ./test_pointer_reg

test_pointer_pair: test_pointer_pair.v ../pointer_pair.v ../pointer_reg.v ../74xx/counter_74161.v ../74xx/selector_74153.v ../74xx/buffer_74244.v
	iverilog -o $@ $^
	./verilog-verify.sh ./test_pointer_pair

test_control_unit: test_control_unit.v ../control_unit.v ../74xx/d_ff_7474.v  ../74xx/decoder_74139.v
	iverilog -o $@ $(filter %.v,$^)
	./verilog-verify.sh ./test_control_unit

test_alu: test_alu.v ../alu.v ../adder.v ../74xx/buffer_74244.v ../74xx/buffer_74240.v ../74xx/mux_74157.v ../74xx/decoder_74138.v
	iverilog -o $@ $(filter %.v,$^)
	./verilog-verify.sh ./test_alu

test_cpu: test_cpu.v ../cpu.v ../alu.v ../adder.v ../control_unit.v ../pointer_pair.v ../pointer_reg.v ../74xx/counter_74161.v ../gp_reg_a.v ../gp_reg_b.v test_cpu.hex ../74xx/selector_74153.v ../74xx/register_74273.v ../74xx/buffer_74244.v  ../74xx/d_ff_7474.v ../rom_28c256.v ../74xx/decoder_74139.v ../74xx/buffer_74240.v ../74xx/mux_74157.v ../74xx/decoder_74138.v
	iverilog -o $@ $(filter %.v,$^)
	./verilog-verify.sh ./test_cpu

test_74153: test_74153.v ../74xx/selector_74153.v
	iverilog -o $@ $^
	./verilog-verify.sh ./test_74153

test_74151: test_74151.v ../74xx/mux_74151.v
	iverilog -o $@ $^
	./verilog-verify.sh ./test_74151

test_7474: test_7474.v ../74xx/d_ff_7474.v
	iverilog -o $@ $^
	./verilog-verify.sh ./test_7474

test_gp_reg_a: test_gp_reg_a.v ../gp_reg_a.v ../74xx/buffer_74244.v ../74xx/register_74273.v
	iverilog -o $@ $^
	./verilog-verify.sh ./test_gp_reg_a

test_gp_reg_b: test_gp_reg_b.v ../gp_reg_b.v ../74xx/buffer_74244.v ../74xx/register_74273.v
	iverilog -o $@ $^
	./verilog-verify.sh ./test_gp_reg_b

test_vga_ctrl: test_vga_ctrl.v ../vga_ctrl.v ../74xx/d_ff_7474.v
	iverilog -o $@ $^
	./verilog-verify.sh ./test_vga_ctrl

test_vga: test_vga.v ../vga.v ../vga_ctrl.v ../74xx/counter_74161.v ../74xx/mux_74157.v ../74xx/buffer_74244.v ../74xx/register_74273.v ../74xx/mux_74151.v ../async_ram.v ../rom_28c256.v  ../74xx/d_ff_7474.v cg.hex
	iverilog -o $@ $(filter %.v,$^)
	./verilog-verify.sh ./test_vga

test_io: test_io.v ../io.v ../74xx/mux_74151.v ../74xx/decoder_74139.v
	iverilog -o $@ $^
	./verilog-verify.sh ./test_io

test_spi: test_spi.v ../spi.v ../74xx/register_74273.v ../74xx/mux_74151.v ../74xx/counter_74161.v ../74xx/buffer_74244.v ../74xx/d_ff_7474.v
	iverilog -o $@ $^
	./verilog-verify.sh ./test_spi

test_ps2: test_ps2.v ../ps2.v ../74xx/register_74273.v ../74xx/mux_74151.v ../74xx/counter_74161.v ../74xx/buffer_74244.v ../74xx/d_ff_7474.v
	iverilog -o $@ $^
	./verilog-verify.sh ./test_ps2

cg.hex: ../../app/font/font.txt
	../../tools/fontgen.py --mode hex $^ $@

%.hex: %.asm ../../tools/asm.py
	../../tools/asm.py -o $(@:.hex=.o) $<
	../../tools/link.py --type=hex --full -o $@ $(@:.hex=.o)
