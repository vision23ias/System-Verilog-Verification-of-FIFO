module FIFO(
    data_in,
    wr_en,
    rd_en,
    clk,
    rst_n,
    full,
    empty,
    almostfull,
    almostempty,
    wr_ack,
    overflow,
    underflow,
    data_out
);

parameter FIFO_WIDTH = 16;
parameter FIFO_DEPTH = 8;

input  [FIFO_WIDTH-1:0] data_in;
input  clk;
input  rst_n;
input  wr_en;
input  rd_en;

output reg [FIFO_WIDTH-1:0] data_out;
output reg wr_ack;
output reg overflow;

output full;
output empty;
output almostfull;
output almostempty;
output underflow;

localparam max_fifo_addr = $clog2(FIFO_DEPTH);

reg [FIFO_WIDTH-1:0] mem [FIFO_DEPTH-1:0];

reg [max_fifo_addr-1:0] wr_ptr;
reg [max_fifo_addr-1:0] rd_ptr;
reg [max_fifo_addr:0]   count;

//////////////////////////////////////////////////////////////
// Write Logic
//////////////////////////////////////////////////////////////

always @(posedge clk or negedge rst_n) begin

    if(!rst_n) begin

        wr_ptr   <= 0;
        wr_ack   <= 0;
        overflow <= 0;

    end

    else if(wr_en && (count < FIFO_DEPTH)) begin

        mem[wr_ptr] <= data_in;
        wr_ptr      <= wr_ptr + 1;

        wr_ack      <= 1'b1;
        overflow    <= 1'b0;

    end

    else begin

        wr_ack <= 1'b0;

        if(full && wr_en)
            overflow <= 1'b1;
        else
            overflow <= 1'b0;

    end

end

//////////////////////////////////////////////////////////////
// Read Logic
//////////////////////////////////////////////////////////////

always @(posedge clk or negedge rst_n) begin

    if(!rst_n) begin

        rd_ptr    <= 0;
        data_out  <= 0;

    end

    else if(rd_en && (count != 0)) begin

        data_out <= mem[rd_ptr];
        rd_ptr   <= rd_ptr + 1;
    end
      else begin
    	data_out <= data_out;
	  end

end

//////////////////////////////////////////////////////////////
// Count Logic
//////////////////////////////////////////////////////////////

always @(posedge clk or negedge rst_n) begin

    if(!rst_n)

        count <= 0;

    else begin

        // Simultaneous read/write while empty
        if(wr_en && rd_en && empty)

            count <= count + 1;

        // Simultaneous read/write while full
        else if(wr_en && rd_en && full)

            count <= count - 1;

        // Write only
        else if(({wr_en,rd_en} == 2'b10) && !full)

            count <= count + 1;

        // Read only
        else if(({wr_en,rd_en} == 2'b01) && !empty)

            count <= count - 1;

    end

end

//////////////////////////////////////////////////////////////
// Status Flags
//////////////////////////////////////////////////////////////

assign full         = (count == FIFO_DEPTH);

assign empty        = (count == 0);

assign underflow    = (empty && rd_en);

assign almostfull   = (count == FIFO_DEPTH-1);

assign almostempty  = (count == 1);

endmodule
