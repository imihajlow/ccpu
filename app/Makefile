SMALLC_DIR=../tools/smallc/smallC
SMALLC=$(SMALLC_DIR)/scc-ccpu

all: calc.rom io_test.rom test.bin ctest.bin

.SECONDARY: calc.bin io_test.bin test.bin

.PHONY: test ctest
test: test.bin
	../tools/sim.py test.bin test.map -c 'u finish'

ctest: ctest.bin
	../tools/sim.py ctest.bin ctest.map -c 'break trap' -c 'run' -c 'p w pri'

ctest.bin: ctest.o $(SMALLC_DIR)/crunccpulib.o trap.o
	../tools/link.py -o $@ -m $(@:.bin=.map) $^

calc.bin: calc.o lib/display.o lib/keyboard.o lib/bcdf.o lib/bcdf_addsub.o lib/bcdf_mul.o lib/bcdf_div.o
	../tools/link.py -o $@ -m $(@:.bin=.map) $^

test.bin: test.o lib/display.o lib/keyboard.o lib/bcdf.o lib/bcdf_addsub.o lib/bcdf_mul.o lib/bcdf_div.o
	../tools/link.py -o $@ -m $(@:.bin=.map) $^

io_test.bin: io_test.o lib/display.o lib/keyboard.o lib/bcdf.o
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
