
import avmm_lvds_bridge_pkg::*;

module avmm_lvds_bridge_avs_if (
    input  logic                    clk_i              ,
    input  logic                    rst_i              ,

    // NOBURST Avalon-MM Slave
    input  logic     [ADDR_W - 1:0] s0_address_i       ,
    input  logic              [3:0] s0_byteenable_i    ,
    input  logic             [31:0] s0_writedata_i     ,
    output logic             [31:0] s0_readdata_o      ,
    input  logic                    s0_write_i         ,
    input  logic                    s0_read_i          ,
    output logic                    s0_waitrequest_o   ,

    // BURST Avalon-MM Slave
    input  logic     [ADDR_W - 1:0] s1_address_i       ,
    input  logic             [31:0] s1_writedata_i     ,
    output logic             [31:0] s1_readdata_o      ,
    input  logic                    s1_write_i         ,
    input  logic                    s1_read_i          ,
    output logic                    s1_waitrequest_o   ,
    output logic                    s1_readdatavalid_o ,
    input  logic [BURSTCNT_W - 1:0] s1_burstcount_i    ,

    // Send Request to TX FIFO
    output logic             [31:0] req_data_o         ,
    output logic                    req_valid_o        ,

    // Receive Response from RX FIFO
    output logic                    resp_rdreq_o       ,
    input  logic             [31:0] resp_q_i           ,
    input  logic                    resp_rdempty_i     ,
    input  logic [BURSTCNT_W - 1:0] resp_rdusedw_i
);

    // N.B. NOBURST transaction has higher priority than BURST

    enum {
        IDLE,

        // BURST port transaction states
        S1_SEND_REQ_HDR,
        S1_SEND_REQ_DATA,
        S1_RECV_RESP_HDR[0:1],
        S1_RECV_RESP_DATA,
        S1_DONE,

        // NOBURST port transaction states
        S0_SEND_REQ_HDR,
        S0_SEND_REQ_DATA,
        S0_RECV_RESP_HDR[0:1],
        S0_RECV_RESP_DATA[0:1],
        S0_DONE
    } state;


    wire s1_start = s1_read_i || s1_write_i;

    logic [BURSTCNT_W - 1:0] s1_burstcount_r ;
    logic                    s1_write_r      ;
    logic                    s1_read_r       ;

    logic [BURSTCNT_W - 1:0] wrcnt;
    logic [BURSTCNT_W - 1:0] rdcnt;

    always_ff @(posedge clk_i)
        if (state == IDLE && s1_start) begin
            s1_burstcount_r <= s1_burstcount_i ;
            s1_write_r      <= s1_write_i      ;
            s1_read_r       <= s1_read_i       ;
        end


    wire s0_start = s0_read_i || s0_write_i;

    logic s0_write_r;
    logic s0_read_r ;

    always_ff @(posedge clk_i)
        if (state == IDLE && s0_start) begin
            s0_write_r <= s0_write_i;
            s0_read_r  <= s0_read_i ;
        end


    always_ff @(posedge clk_i or posedge rst_i)
        if (rst_i)
            state <= IDLE;
        else case (state)
            IDLE:
                if (s0_start)
                    state <= S0_SEND_REQ_HDR;
                else if (s1_start)
                    state <= S1_SEND_REQ_HDR;


            S1_SEND_REQ_HDR:
                if (s1_write_r)
                    state <= S1_SEND_REQ_DATA;
                else
                    state <= S1_RECV_RESP_HDR0;

            S1_SEND_REQ_DATA:
                if (wrcnt == s1_burstcount_r && s1_write_i)
                    state <= S1_RECV_RESP_HDR0;

            S1_RECV_RESP_HDR0:
                if (!resp_rdempty_i)
                    state <= S1_RECV_RESP_HDR1;
            S1_RECV_RESP_HDR1:
                if (s1_read_r)
                    // state <= S1_RECV_RESP_HDR2;
                    state <= S1_RECV_RESP_DATA;
                else
                    state <= S1_DONE;

            S1_RECV_RESP_DATA:
                if (rdcnt == s1_burstcount_r && !resp_rdempty_i)
                    state <= S1_DONE;

            S1_DONE:
                state <= IDLE;


            S0_SEND_REQ_HDR:
                if (s0_write_r)
                    state <= S0_SEND_REQ_DATA;
                else
                    state <= S0_RECV_RESP_HDR0;

            S0_SEND_REQ_DATA:
                state <= S0_RECV_RESP_HDR0;

            S0_RECV_RESP_HDR0:
                if (!resp_rdempty_i) begin
                    if (s0_read_r)
                        state <= S0_RECV_RESP_HDR1;
                    else
                        state <= S0_DONE;
                end
            S0_RECV_RESP_HDR1:
                state <= S0_RECV_RESP_DATA0;

            S0_RECV_RESP_DATA0:
                if (!resp_rdempty_i)
                    state <= S0_RECV_RESP_DATA1;

            S0_RECV_RESP_DATA1:
                state <= S0_DONE;

            S0_DONE:
                state <= IDLE;
        endcase


    always_ff @(posedge clk_i)
        if (state == S1_SEND_REQ_DATA) begin
            if (s1_write_i)
                wrcnt <= wrcnt + 1'b1;
        end else
            wrcnt <= 1'b1;


    always_ff @(posedge clk_i)
        if (state == S1_RECV_RESP_DATA) begin
            if (!resp_rdempty_i)
                rdcnt <= rdcnt + 1'b1;
        end else
            rdcnt <= 1'b1;

    // ----------------------------------------------------------------
    // Generate request packet
    // ----------------------------------------------------------------

    logic [31:0] req_data;
    logic        req_valid;

    // Prepare BURST transaction header
    req_hdr_t s1_req_hdr;
    always_comb begin
        s1_req_hdr.tr = s1_write_r ? WRITE : READ;
        s1_req_hdr.burst = BURST;
        s1_req_hdr.address = s1_address_i;
        s1_req_hdr.burstcnt_byteena = s1_burstcount_r;
    end

    // Prepare NOBURST transaction header
    req_hdr_t s0_req_hdr;
    always_comb begin
        s0_req_hdr.tr = s0_write_r ? WRITE : READ;
        s0_req_hdr.burst = NOBURST;
        s0_req_hdr.address = s0_address_i;
        s0_req_hdr.burstcnt_byteena = {'0, s0_byteenable_i};
    end

    assign req_valid = (state == S1_SEND_REQ_HDR)
                    || (state == S1_SEND_REQ_DATA && s1_write_i)
                    || (state == S0_SEND_REQ_HDR)
                    || (state == S0_SEND_REQ_DATA);

    always_comb begin
        if (state == S0_SEND_REQ_HDR)
            req_data = s0_req_hdr;
        else if (state == S0_SEND_REQ_DATA)
            req_data = s0_writedata_i;
        else if (state == S1_SEND_REQ_HDR)
            req_data = s1_req_hdr;
        else // (state == S1_SEND_REQ_DATA)
            req_data = s1_writedata_i;
    end

    always_ff @(posedge clk_i or posedge rst_i)
        if (rst_i)
            req_valid_o <= '0;
        else
            req_valid_o <= req_valid;

    always_ff @(posedge clk_i)
        req_data_o <= req_data;

    // ----------------------------------------------------------------
    // Receive response packet
    // ----------------------------------------------------------------

    // generate read request for RX FIFO
    logic resp_rdreq;

    logic s1_hdr_rdreq_r  ;
    logic s0_hdr_rdreq_r  ;
    logic s0_data_rdreq_r ;

    always_ff @(posedge clk_i or posedge rst_i)
        if (rst_i) begin
            s1_hdr_rdreq_r  <= '0;
            s0_hdr_rdreq_r  <= '0;
            s0_data_rdreq_r <= '0;
        end else begin
            s1_hdr_rdreq_r  <= (state == S1_RECV_RESP_HDR0 && !resp_rdempty_i);
            s0_hdr_rdreq_r  <= (state == S0_RECV_RESP_HDR0 && !resp_rdempty_i);
            s0_data_rdreq_r <= (state == S0_RECV_RESP_DATA0 && !resp_rdempty_i);
        end

    wire s1_data_rdreq = (state == S1_RECV_RESP_DATA && !resp_rdempty_i);

    assign resp_rdreq_o = s1_hdr_rdreq_r
                        | s1_data_rdreq
                        | s0_hdr_rdreq_r
                        | s0_data_rdreq_r;

    // valid strobe for BURST payload
    logic [1:0] s1_rddata_valid;

    always_ff @(posedge clk_i or posedge rst_i)
        if (rst_i)
            s1_rddata_valid <= '0;
        else
            s1_rddata_valid <= (s1_rddata_valid << 1) | s1_data_rdreq;

    // ----------------------------------------------------------------
    // Drive Avalon-MM
    // ----------------------------------------------------------------

    assign s1_waitrequest_o = ~(state == S1_SEND_REQ_DATA ||
                                s1_read_r && (state == S1_SEND_REQ_HDR));

    assign s1_readdata_o = resp_q_i;
    assign s1_readdatavalid_o = s1_rddata_valid[0];

    assign s0_waitrequest_o = ~(state == S0_DONE);
    assign s0_readdata_o = resp_q_i;

endmodule
