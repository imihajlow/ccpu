`timescale 1us/1ns
module test_74151();
    task assert;
        input v;
        if (v !== 1'b1)
            $fatal;
    endtask

    reg n_g;
    reg [7:0] d;
    reg a, b, c;
    wire y, w;
    mux_74151 inst(
          .n_g(n_g),
          .d(d),
          .a(a), .b(b), .c(c),
          .y(y), .w(w));

    initial begin
        $dumpfile("test_74151.vcd");
        $dumpvars;

        n_g = 1'b1;
        d = 8'b10100101;
        a = 1'b0;
        b = 1'b0;
        c = 1'b0;

        #1
        assert(y === 1'b0);
        assert(w === 1'b1);

        n_g = 1'b0;
        #1
        assert(y === 1'b1);
        assert(w === 1'b0);

        a = 1'b1;
        #1
        assert(y === 1'b0);
        assert(w === 1'b1);

        b = 1'b1;
        #1
        assert(y === 1'b0);
        assert(w === 1'b1);

        c = 1'b1;
        #1
        assert(y === 1'b1);
        assert(w === 1'b0);

        a = 1'b0;
        #1
        assert(y === 1'b0);
        assert(w === 1'b1);
    end
endmodule
