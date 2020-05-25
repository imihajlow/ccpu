NATRIX_DIR=../tools/natrix
NATRIX=$(NATRIX_DIR)/natrix.py

all: calc.rom io_test.rom test.bin natest.bin

clean:
	rm -f *.bin *.rom *.map *.s *.o */*.o */*.s

.SECONDARY: calc.bin io_test.bin test.bin

.PHONY: test ctest clean

test: test.bin
	../tools/sim.py test.bin test.map -c 'u finish'

natest: natest.bin
	../tools/sim.py natest.bin natest.map -c 'break trap' -c 'run' -c 'p w test_result'

natest.bin: test/natest.o $(NATRIX_DIR)/runtime/natrix_runtime.o test/trap.o lib/display.o lib/bcdf.o lib/string.o
	../tools/link.py -o $@ -m $(@:.bin=.map) $^

calc.bin: calc/calc.o lib/display.o lib/keyboard.o lib/bcdf.o lib/bcdf_addsub.o lib/bcdf_mul.o lib/bcdf_div.o
	../tools/link.py -o $@ -m $(@:.bin=.map) $^

test.bin: test/test.o lib/display.o lib/keyboard.o lib/bcdf.o lib/bcdf_addsub.o lib/bcdf_mul.o lib/bcdf_div.o
	../tools/link.py -o $@ -m $(@:.bin=.map) $^

io_test.bin: test/io_test.o lib/display.o lib/keyboard.o lib/bcdf.o
	../tools/link.py -o $@ -m $(@:.bin=.map) $^

maze.bin: maze/main.o maze/maze.o maze/game.o $(NATRIX_DIR)/runtime/natrix_runtime.o test/trap.o lib/display.o lib/bcdf.o lib/string.o lib/random.o lib/keyboard.o lib/entropy.o
	../tools/link.py -o $@ -m $(@:.bin=.map) $^

%.o: %.asm
	../tools/asm.py -o $@ $^

%.o: %.na
	$(NATRIX) --cpp-arg=-Ilib -o $(@:.o=.s) $^
	../tools/asm.py -o $@ $(@:.o=.s)

%.bin: %.o
	../tools/link.py -o $@ -m $(@:.bin=.map) $^

%.rom: %.bin
	cp $^ $@
	../tools/flip67.py $@
