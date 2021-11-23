all: alu0.png alu1.png jc.png lcd_write.png ld.png ld-slow.png ld-fast.png ldi.png spi.png st.png st-slow.png st-fast.png vga.png ps2/recv.png ps2/send.png ps2/send_begin.png

%.png: %.json
	npx wavedrom-cli -i $^ -p $@
