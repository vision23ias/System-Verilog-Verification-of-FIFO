import fifo_transaction_pkg::*;
import fifo_coverage_pkg::*;
import fifo_scoreboard_pkg::*;
import shared_pkg::*;

module fifo_monitor (fifo_if.MONITOR fifoif);

    // Class objects
    FIFO_transaction tr_mon;
    FIFO_coverage    cov_mon = new;
    FIFO_scoreboard  scb_mon = new;

    initial begin

        forever begin

            // Sample after DUT updates on posedge
            @(negedge fifoif.clk);

            // Create a fresh transaction every cycle
            tr_mon = new();

            // Capture interface signals
            tr_mon.data_in       = fifoif.data_in;
            tr_mon.rst_n         = fifoif.rst_n;
            tr_mon.wr_en         = fifoif.wr_en;
            tr_mon.rd_en         = fifoif.rd_en;
            tr_mon.data_out      = fifoif.data_out;
            tr_mon.wr_ack        = fifoif.wr_ack;
            tr_mon.overflow      = fifoif.overflow;
            tr_mon.full          = fifoif.full;
            tr_mon.empty         = fifoif.empty;
            tr_mon.almostfull    = fifoif.almostfull;
            tr_mon.almostempty   = fifoif.almostempty;
            tr_mon.underflow     = fifoif.underflow;

            // Functional Coverage
            cov_mon.sample_data(tr_mon);

            // Scoreboard Check
            scb_mon.check_data(tr_mon);

            // End simulation when test completes
            if(test_finished) begin
                $display("------------------------------------------");
                $display("Simulation Completed");
                $display("Total DATA_OUT Errors   = %0d", error_count_out);
                $display("Total Correct Outputs   = %0d", correct_count_out);
                $display("------------------------------------------");
                $stop;
            end

        end

    end

endmodule
