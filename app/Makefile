SMALLC_DIR=../tools/smallc/smallC
SMALLC=$(SMALLC_DIR)/scc-ccpu

all: calc.rom io_test.rom test.bin ctest.bin

clean:
	rm -f *.bin *.rom *.map *.s

.SECONDARY: calc.bin io_test.bin test.bin

.PHONY: test ctest clean

test: test.bin
	../tools/sim.py test.bin test.map -c 'u finish'

ctest: ctest.bin
	../tools/sim.py ctest.bin ctest.map -c 'break trap' -c 'run' -c 'p w pri'

ctest.bin: test/ctest.o $(SMALLC_DIR)/crunccpulib.o test/trap.o lib/c_display.o lib/display.o lib/bcdf.o
	../tools/link.py -o $@ -m $(@:.bin=.map) $^

calc.bin: calc/calc.o lib/display.o lib/keyboard.o lib/bcdf.o lib/bcdf_addsub.o lib/bcdf_mul.o lib/bcdf_div.o
	../tools/link.py -o $@ -m $(@:.bin=.map) $^

test.bin: test/test.o lib/display.o lib/keyboard.o lib/bcdf.o lib/bcdf_addsub.o lib/bcdf_mul.o lib/bcdf_div.o
	../tools/link.py -o $@ -m $(@:.bin=.map) $^

io_test.bin: test/io_test.o lib/display.o lib/keyboard.o lib/bcdf.o
	../tools/link.py -o $@ -m $(@:.bin=.map) $^

%.o: %.asm
	../tools/asm.py -o $@ $^

%.o: %.c
	$(SMALLC) $^
	../tools/asm.py -o $@ $(@:.o=.s)

%.bin: %.o
	../tools/link.py -o $@ -m $(@:.bin=.map) $^

%.rom: %.bin
	cp $^ $@
	../tools/flip67.py $@
