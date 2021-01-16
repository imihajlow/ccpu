NATRIX_DIR=../tools/natrix
NATRIX=$(NATRIX_DIR)/natrix.py
ALU_REVISION=2
FREQUENCY=1350kHz

BCDF_OBJECTS=lib/bcdf.o lib/bcdf_addsub.o lib/bcdf_mul.o lib/bcdf_div.o lib/bcdf_print.o

all: io_test.rom natest.bin main.rom alutest.rom memcheck.rom locheck.rom vgatest.rom

clean:
	rm -f *.bin *.rom *.map *.s *.o */*.o */*.s $(NATRIX_DIR)/runtime/natrix_runtime.o

.SECONDARY: calc.bin io_test.bin test.bin alutest.bin

.PHONY: test ctest clean


DELAY_OBJ=lib/delay_$(FREQUENCY).o

# test: test.bin
# 	../tools/sim.py --alu-revision=$(ALU_REVISION) test.bin test.map -c 'u finish'

natest: natest.bin
	../tools/sim.py --alu-revision=$(ALU_REVISION) natest.bin natest.map -c 'break trap' -c 'run' -c 'p w test_result'

natest.bin: test/natest.o $(NATRIX_DIR)/runtime/natrix_runtime.o test/trap.o lib/display.o $(DELAY_OBJ) lib/bcdf.o lib/string.o
	../tools/link.py -o $@ -m $(@:.bin=.map) $^

# test.bin: test/test.o lib/display.o $(DELAY_OBJ) lib/keyboard.o $(BCDF_OBJECTS)
# 	../tools/link.py -o $@ -m $(@:.bin=.map) $^

io_test.bin: test/io_test.o lib/display.o $(DELAY_OBJ) lib/keyboard.o lib/bcdf.o
	../tools/link.py -o $@ -m $(@:.bin=.map) $^

main.bin: main.o life/quasipixel.o life/life.o calc/calc.o maze/maze.o maze/game.o maze/main.o $(NATRIX_DIR)/runtime/natrix_runtime.o test/trap.o lib/string.o lib/keyboard.o lib/vga.o lib/vga_console.o $(BCDF_OBJECTS) lib/random.o lib/entropy.o
	../tools/link.py -o $@ -m $(@:.bin=.map) $^

alutest.bin: test/alutest.o
	../tools/link.py -o $@ -m $(@:.bin=.map) $^

memcheck.bin: memcheck/memcheck.o
	../tools/link.py -o $@ -m $(@:.bin=.map) $^

locheck.bin: memcheck/locheck.o lib/string.o $(NATRIX_DIR)/runtime/natrix_runtime.o
	../tools/link.py -o $@ -m $(@:.bin=.map) $^

vgatest.bin: test/vgatest.o $(NATRIX_DIR)/runtime/natrix_runtime.o lib/keyboard.o lib/vga.o
	../tools/link.py -o $@ -m $(@:.bin=.map) $^

%.o: %.asm
	../tools/asm.py --alu-revision=$(ALU_REVISION) -o $@ $^

%.o: %.na
	$(NATRIX) --cpp-arg=-Ilib -o $(@:.o=.s) $^
	../tools/asm.py --alu-revision=$(ALU_REVISION) -o $@ $(@:.o=.s)

%.bin: %.o
	../tools/link.py -o $@ -m $(@:.bin=.map) $^

%.rom: %.bin
	cp $^ $@
