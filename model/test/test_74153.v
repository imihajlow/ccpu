`timescale 1us/1ns
module test_74153();
    task assert;
        input v;
        if (!v)
            $fatal;
    endtask

    reg [3:0] i1;
    reg [3:0] i2;
    reg [1:0] s;
    reg e1;
    reg e2;
    wire y1;
    wire y2;
    selector_74153 inst(
          .y1(y1),
          .y2(y2),
          .i1(i1),
          .i2(i2),
          .s(s),
          .e1(e1),
          .e2(e2));

    initial begin
        $dumpfile("test_74153.vcd");
        $dumpvars;

        e1 = 1'b1;
        i1 = 4'bx;
        s = 2'bx;
        #1
        assert(y1 == 1'b0);

        #1
        e1 = 1'b0;

        // 1
        i1 = 4'bxxx0;
        s = 2'b00;
        #1
        assert(y1 == 1'b0);

        i1 = 4'bxxx1;
        s = 2'b00;
        #1
        assert(y1 == 1'b1);

        i1 = 4'bxx0x;
        s = 2'b01;
        #1
        assert(y1 == 1'b0);

        i1 = 4'bxx1x;
        s = 2'b01;
        #1
        assert(y1 == 1'b1);

        i1 = 4'bx0xx;
        s = 2'b10;
        #1
        assert(y1 == 1'b0);

        i1 = 4'bx1xx;
        s = 2'b10;
        #1
        assert(y1 == 1'b1);

        i1 = 4'b0xxx;
        s = 2'b11;
        #1
        assert(y1 == 1'b0);

        i1 = 4'b1xxx;
        s = 2'b11;
        #1
        assert(y1 == 1'b1);

        // 2
        e2 = 1'b1;
        i2 = 4'bxxxx;
        s = 2'bxx;
        #1
        assert(y2 == 1'b0);

        #1
        e2 = 1'b0;

        i1 = 4'bxxxx;
        i2 = 4'bxxx0;
        s = 2'b00;
        #1
        assert(y2 == 1'b0);

        i2 = 4'bxxx1;
        s = 2'b00;
        #1
        assert(y2 == 1'b1);

        i2 = 4'bxx0x;
        s = 2'b01;
        #1
        assert(y2 == 1'b0);

        i2 = 4'bxx1x;
        s = 2'b01;
        #1
        assert(y2 == 1'b1);

        i2 = 4'bx0xx;
        s = 2'b10;
        #1
        assert(y2 == 1'b0);

        i2 = 4'bx1xx;
        s = 2'b10;
        #1
        assert(y2 == 1'b1);

        i2 = 4'b0xxx;
        s = 2'b11;
        #1
        assert(y2 == 1'b0);

        i2 = 4'b1xxx;
        s = 2'b11;
        #1
        assert(y2 == 1'b1);
    end
endmodule
