%.o: %.asm
	../tools/asm.py -o $@ $^

io_test.bin: io_test.o lib/display.o
	../tools/link.py -o $@ -m $(@:.bin=.map) $^

%.bin: %.o
	../tools/link.py -o $@ -m $(@:.bin=.map) $^

%.rom: %.bin
	cp $^ $@
	../tools/flip67.py $@
