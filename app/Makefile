all: calc.rom io_test.rom

.SECONDARY: calc.bin io_test.bin

calc.bin: calc.o lib/display.o lib/keyboard.o lib/bcdf.o lib/bcdf_addsub.o
	../tools/link.py -o $@ -m $(@:.bin=.map) $^

io_test.bin: io_test.o lib/display.o lib/keyboard.o lib/bcdf.o
	../tools/link.py -o $@ -m $(@:.bin=.map) $^

%.o: %.asm
	../tools/asm.py -o $@ $^

%.bin: %.o
	../tools/link.py -o $@ -m $(@:.bin=.map) $^

%.rom: %.bin
	cp $^ $@
	../tools/flip67.py $@
