module fifo_top();

    bit clk;

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    // Interface
    fifo_if fifoif(clk);

    // DUT
    FIFO dut(

        .data_in      (fifoif.data_in),
        .wr_en        (fifoif.wr_en),
        .rd_en        (fifoif.rd_en),
        .clk          (fifoif.clk),
        .rst_n        (fifoif.rst_n),

        .full         (fifoif.full),
        .empty        (fifoif.empty),
        .almostfull   (fifoif.almostfull),
        .almostempty  (fifoif.almostempty),

        .wr_ack       (fifoif.wr_ack),
        .overflow     (fifoif.overflow),
        .underflow    (fifoif.underflow),

        .data_out     (fifoif.data_out)

    );

    // Test
    fifo_tb tb(fifoif);

    // Monitor
    fifo_monitor MONITOR(fifoif);

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, fifo_top);
    end

endmodule
