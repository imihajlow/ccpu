`timescale 1us/1ns
module test_adder();
    task assert;
        input v;
        if (v !== 1'b1)
            $fatal;
    endtask

    reg [7:0] a;
    reg [7:0] b;
    reg c_in;
    reg sub;

    wire [7:0] r;
    wire [7:0] xor_ab;
    wire c_out;

    adder inst(
        .a(a[7:0]),
        .b(b[7:0]),
        .c_in(c_in),
        .sub(sub),
        .r(r),
        .c_out(c_out),
        .xor_ab(xor_ab));

    integer i, j;

    initial begin
        $dumpfile("test_adder.vcd");
        $dumpvars;

        a = 8'b0;
        b = 8'b0;

        c_in = 1'b0;
        sub = 1'b0;

        for (i = 0; i < 256; i = i + 1) begin
            for (j = 0; j < 256; j = j + 1) begin
                #1
                a = i;
                b = j;
                c_in = 1'b0;
                sub = 1'b0;

                #1
                assert(r === ((a + b) & 8'hff));
                assert(xor_ab === ((a ^ b) & 8'hff));
                assert(c_out === ((a + b) & 9'h100) >> 8);

                #1
                c_in = 1'b1;

                #1
                assert(r === ((a + b + 1) & 8'hff));
                assert(xor_ab === ((a ^ b) & 8'hff));
                assert(c_out === ((a + b + 1) & 9'h100) >> 8);

                #1
                c_in = 1'b0;
                sub = 1'b1;

                #1
                assert(r === ((a - b) & 8'hff));
                assert(xor_ab === ((a ^ b) & 8'hff));
                assert(c_out === ((a - b) & 9'h100) >> 8);

                #1
                c_in = 1'b1;

                #1
                assert(r === ((a - b - 1) & 8'hff));
                assert(xor_ab === ((a ^ b) & 8'hff));
                assert(c_out === ((a - b - 1) & 9'h100) >> 8);
            end
        end
    end
endmodule
