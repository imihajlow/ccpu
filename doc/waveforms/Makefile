all: alu0.png alu1.png jc.png lcd_write.png ld-fast.png ld-slow.png ldi.png spi.png st-fast.png st-slow.png vga.png ps2/recv.png ps2/send.png ps2/send_begin.png

%.png: %.json
	npx wavedrom-cli -i $^ -p $@
