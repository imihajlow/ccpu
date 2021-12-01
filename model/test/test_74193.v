`timescale 1us/1ns
module test_74193();
    task assert;
        input v;
        if (v !== 1'b1)
            $fatal;
    endtask

    reg clr, n_load, up, down;
    reg [3:0] d;
    wire n_co, n_bo;
    wire [3:0] q;
    counter_74193 inst(
      .clr(clr),
      .n_load(n_load),
      .up(up),
      .down(down),
      .d(d),
      .q(q),
      .n_co(n_co),
      .n_bo(n_bo)
    );

    integer i;
    initial begin
        $dumpfile("test_74193.vcd");
        $dumpvars;

        clr = 1'b1;
        n_load = 1'b1;
        up = 1'b1;
        down = 1'b1;
        d = 4'b1011;

        #1
        assert(q === 4'b0000);
        assert(n_co === 1'b1);
        assert(n_bo === 1'b1);

        clr = 1'b0;
        #1
        assert(q === 4'b0000);
        assert(n_co === 1'b1);
        assert(n_bo === 1'b1);

        for (i = 0; i != 20; i = i + 1) begin
            #1
            assert(q === i[3:0]);
            assert(n_co === 1'b1);
            assert(n_bo === 1'b1);

            #1 up = 1'b0;
            #1
            assert(q === i[3:0]);
            assert(n_co === (q != 4'b1111));
            assert(n_bo === 1'b1);

            #1 up = 1'b1;
        end

        clr = 1'b1;
        #1
        assert(q === 4'b0000);
        assert(n_co === 1'b1);
        assert(n_bo === 1'b1);

        clr = 1'b0;
        #1
        assert(q === 4'b0000);
        assert(n_co === 1'b1);
        assert(n_bo === 1'b1);

        n_load = 1'b0;
        #1
        assert(q === 4'b1011);
        assert(n_co === 1'b1);
        assert(n_bo === 1'b1);

        n_load = 1'b1;
        #1
        assert(q === 4'b1011);
        assert(n_co === 1'b1);
        assert(n_bo === 1'b1);

        for (i = 11 + 16; i != 0; i = i - 1) begin
            #1
            assert(q === i[3:0]);
            assert(n_co === 1'b1);
            assert(n_bo === 1'b1);

            #1 down = 1'b0;
            #1
            assert(q === i[3:0]);
            assert(n_bo === (q != 4'b0000));
            assert(n_co === 1'b1);

            #1 down = 1'b1;
        end
    end
endmodule
