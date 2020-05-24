.PHONY: test

test: test.bin
	../../sim.py test.bin test.map -c 'b fail' -c 'b success' -c 'r' -c 'p w fail_arg0'
	rm -f test.o
	coverage html

test.bin: test.o ../runtime/natrix_runtime.o
	../../link.py -o $@ -m test.map $^

%.o: %.asm
	../../asm.py -o $@ $^

test.o: test.na
	coverage run ../natrix.py -o $(@:.o=.s) $^
	../../asm.py -o $@ $(@:.o=.s)
