%.bin: %.asm
	../tools/asm.py -o $@ $^
	../tools/flip67.py $@
