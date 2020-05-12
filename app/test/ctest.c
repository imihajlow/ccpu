
main() {
    display_init();
    c_display_print("Hello from C");
    c_display_set_address(0x40);
    c_display_print_byte(0xa5);
    trap();
}
