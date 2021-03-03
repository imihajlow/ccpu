.PHONY: test test.o sandbox.na

test: test.bin
	../../sim.py test.bin test.map -c 'protect_rom 0' -c 'b fail' -c 'b success' -c 'r' -c 'p w fail_arg0'
	rm -f test.o
	coverage html

sandbox.bin: sandbox.o ../runtime/natrix_runtime.o
	../../link.py -o $@ -m sandbox.map $^

test.bin: test.o ../runtime/natrix_runtime.o ../../../app/lib/display.o delay_stub.o align.o
	../../link.py --full --layout=sim -o $@ -m test.map $^

%.o: %.asm
	../../asm.py -o $@ $^

test.o: test.na
	coverage run ../natrix.py -o $(@:.o=.s) $^
	../../asm.py -o $@ $(@:.o=.s)

%.o: %.na
	../natrix.py --tree -o $(@:.o=.s) $^
	../../asm.py -o $@ $(@:.o=.s)

