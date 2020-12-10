`timescale 1us/1ns
module test_7474();
    task assert;
        input v;
        if (v !== 1'b1)
            $fatal;
    endtask

    wire q;
    wire n_q;
    reg d;
    reg cp;
    reg n_cd;
    reg n_sd;
    d_ff_7474 inst(
           .q(q),
           .n_q(n_q),
           .d(d),
           .cp(cp),
           .n_cd(n_cd),
           .n_sd(n_sd));

    initial begin
        $dumpfile("test_7474.vcd");
        $dumpvars;

        cp = 1'b0;
        n_cd = 1'b1;
        n_sd = 1'b1;
        d = 1'b0;

        n_cd = 1'b0;
        #1
        assert(q === 1'b0);
        assert(n_q === 1'b1);

        n_cd = 1'b1;
        #1
        assert(q === 1'b0);
        assert(n_q === 1'b1);

        n_sd = 1'b0;
        #1
        assert(q === 1'b1);
        assert(n_q === 1'b0);

        n_sd = 1'b1;
        #1
        assert(q === 1'b1);
        assert(n_q === 1'b0);

        n_cd = 1'b0;
        n_sd = 1'b0;
        #1
        assert(q === 1'b1);
        assert(n_q === 1'b1);

        n_cd = 1'b1;
        #1
        assert(q === 1'b1);
        assert(n_q === 1'b0);

        n_cd = 1'b0;
        n_sd = 1'b0;
        #1
        assert(q === 1'b1);
        assert(n_q === 1'b1);

        n_sd = 1'b1;
        #1
        assert(q === 1'b0);
        assert(n_q === 1'b1);

        n_cd = 1'b1;
        n_sd = 1'b1;
        d = 1'b1;
        #1
        cp = 1'b1;
        #1
        assert(q === 1'b1);
        assert(n_q === 1'b0);

        cp = 1'b0;
        #1
        assert(q === 1'b1);
        assert(n_q === 1'b0);

        d = 1'b0;
        #1
        assert(q === 1'b1);
        assert(n_q === 1'b0);

        cp = 1'b1;
        #1
        assert(q === 1'b0);
        assert(n_q === 1'b1);

        cp = 1'b0;
        #1
        assert(q === 1'b0);
        assert(n_q === 1'b1);
    end
endmodule
