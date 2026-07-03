package fifo_scoreboard_pkg;

import fifo_transaction_pkg::*;
import shared_pkg::*;

class FIFO_scoreboard;

    parameter FIFO_WIDTH = 16;
    parameter FIFO_DEPTH = 8;

    // Reference FIFO count
    int count;

    // Expected outputs
    logic [FIFO_WIDTH-1:0] data_out_ref;
    logic wr_ack_ref;

    // Reference FIFO Queue
    logic [FIFO_WIDTH-1:0] queue_ref[$];

    //------------------------------------------------------------
    // Compare DUT with expected outputs
    //------------------------------------------------------------
    function void check_data(FIFO_transaction tr);

        //--------------------------------------------------------
        // Compare DATA_OUT
        //--------------------------------------------------------
        if(tr.data_out !== data_out_ref) begin
            error_count_out++;
            $display("[%0t] DATA_OUT ERROR Expected=%0h Actual=%0h",
                     $time,data_out_ref,tr.data_out);
        end
        else
            correct_count_out++;

        //--------------------------------------------------------
        // Compare WR_ACK
        //--------------------------------------------------------
        if(tr.wr_ack !== wr_ack_ref) begin
            error_count_ack++;
            $display("[%0t] WR_ACK ERROR Expected=%0b Actual=%0b",
                     $time,wr_ack_ref,tr.wr_ack);
        end
        else
            correct_count_ack++;

        // Update reference model for next cycle
        reference_model(tr);

    endfunction


    //------------------------------------------------------------
    // Reference FIFO Model
    //------------------------------------------------------------
    function void reference_model(FIFO_transaction tr_ref);

        if(!tr_ref.rst_n) begin

            queue_ref.delete();

            count        = 0;
            data_out_ref = '0;
            wr_ack_ref   = 0;

        end

        else begin

            //----------------------------------------------------
            // Default
            //----------------------------------------------------
            wr_ack_ref = 0;

            //----------------------------------------------------
            // Write Operation
            //----------------------------------------------------
            if(tr_ref.wr_en && count < FIFO_DEPTH) begin

                queue_ref.push_back(tr_ref.data_in);
                wr_ack_ref = 1;
                count++;

            end

            //----------------------------------------------------
            // Read Operation
            //----------------------------------------------------
            if(tr_ref.rd_en && count > 0) begin

                data_out_ref = queue_ref.pop_front();
                count--;

            end

        end

    endfunction

endclass

endpackage
