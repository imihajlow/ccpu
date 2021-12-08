.PHONY: test test-stack test.o test-stack.o sandbox.na

all: test test-stack

test: test.bin
	../../rsim/target/release/rsim -c 'b fail' -c 'b success' -c 'r' -c 'p w fail_arg0' -c 'quit' test.bin test.map
	rm -f test.o
	coverage html --rcfile=coverage.rc 

test-stack: test-stack.bin
	../../rsim/target/release/rsim --config stack.yaml -c 'b fail' -c 'b success' -c 'r' -c 'p w fail_arg0' -c 'quit' test-stack.bin test-stack.map
	rm -f test.o
	coverage html --rcfile=coverage-stack.rc 

sandbox.bin: sandbox.o ../runtime/natrix_runtime.o
	../../link.py -o $@ -m sandbox.map $^

test.bin: test.o ../runtime/natrix_runtime.o ../runtime/rom_startup.o ../../../app/lib/display.o delay_stub.o align.o
	../../link.py --full --layout=sim -o $@ -m test.map $^

test-stack.bin: test-stack.o ../runtime/natrix_runtime.o ../runtime/stack_rom_startup.o ../../../app/lib/display.o delay_stub.o align.o
	../../link.py --layout=default-stack -o $@ -m test-stack.map $^

%.o: %.asm
	../../asm.py -o $@ $^

test.o: test.na
	coverage run --rcfile=coverage.rc ../natrix.py -o $(@:.o=.s) $^
	../../asm.py -o $@ $(@:.o=.s)

test-stack.o: test.na
	coverage run --rcfile=coverage-stack.rc ../natrix.py --stack --cpp-arg=-DSLIM -o test-stack.s $^
	../../asm.py -o $@ $(@:.o=.s)

%.o: %.na
	../natrix.py --tree -o $(@:.o=.s) $^
	../../asm.py -o $@ $(@:.o=.s)

