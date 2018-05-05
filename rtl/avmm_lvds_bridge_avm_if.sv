
import avmm_lvds_bridge_pkg::*;

module avmm_lvds_bridge_avm_if (
    input  logic                    clk_i              ,
    input  logic                    rst_i              ,

    // NO BURST Avalon-MM Master
    output logic     [ADDR_W - 1:0] m0_address_o       ,
    output logic              [3:0] m0_byteenable_o    ,
    output logic             [31:0] m0_writedata_o     ,
    input  logic             [31:0] m0_readdata_i      ,
    output logic                    m0_write_o         ,
    output logic                    m0_read_o          ,
    input  logic                    m0_waitrequest_i   ,

    // BURST Avalon-MM Master
    output logic     [ADDR_W - 1:0] m1_address_o       ,
    output logic             [31:0] m1_writedata_o     ,
    input  logic             [31:0] m1_readdata_i      ,
    output logic                    m1_write_o         ,
    output logic                    m1_read_o          ,
    input  logic                    m1_waitrequest_i   ,
    input  logic                    m1_readdatavalid_i ,
    output logic [BURSTCNT_W - 1:0] m1_burstcount_o    ,

    // Receive Request
    output logic                    req_rdreq_o        ,
    input  logic             [31:0] req_q_i            ,
    input  logic                    req_rdempty_i      ,
    input  logic [BURSTCNT_W - 1:0] req_rdusedw_i      ,

    // Send Response
    output logic             [31:0] resp_data_o        ,
    output logic                    resp_valid_o
);

    enum {
        IDLE,
        RECV_REQ_HDR[0:2],

        NOBURST_WRITE[0:2],
        NOBURST_READ[0:1],

        BURST_WRITE[0:1],
        BURST_READ[0:1],
        SEND_WRITE_RESP,
        DONE
    } state;

    req_hdr_t req_hdr_r;
    logic [BURSTCNT_W - 1:0] wrcnt;
    logic [BURSTCNT_W - 1:0] rdcnt;

    always_ff @(posedge clk_i or posedge rst_i)
        if (rst_i) begin
            state <= IDLE;
        end
        else begin
            case (state)
                IDLE:
                    if (!req_rdempty_i)
                        state <= RECV_REQ_HDR0;

                RECV_REQ_HDR0:
                    state <= RECV_REQ_HDR1;
                RECV_REQ_HDR1:
                    state <= RECV_REQ_HDR2;
                RECV_REQ_HDR2:
                    if (req_hdr_r.burst == BURST) begin
                        if (req_hdr_r.tr == WRITE) begin
                            state <= BURST_WRITE0;
                        end else
                            state <= BURST_READ0;
                    end
                    else begin // (req_hdr_r.burst == NOBURST)
                        if (req_hdr_r.tr == WRITE) begin
                            state <= NOBURST_WRITE0;
                        end else
                            state <= NOBURST_READ0;
                    end

                BURST_WRITE0:
                    if (!req_rdempty_i)
                        state <= BURST_WRITE1;
                BURST_WRITE1:
                    if (wrcnt == req_hdr_r.burstcnt_byteena && !m1_waitrequest_i)
                        state <= SEND_WRITE_RESP;

                BURST_READ0:
                    if (!m1_waitrequest_i)
                        state <= BURST_READ1;

                SEND_WRITE_RESP:
                    state <= DONE;

                BURST_READ1:
                    if (rdcnt == req_hdr_r.burstcnt_byteena)
                        state <= DONE;

                NOBURST_WRITE0:
                    if (!req_rdempty_i)
                        state <= NOBURST_WRITE1;
                NOBURST_WRITE1:
                    state <= NOBURST_WRITE2;
                NOBURST_WRITE2:
                    if (!m0_waitrequest_i)
                        state <= SEND_WRITE_RESP;

                NOBURST_READ0:
                    if (!m0_waitrequest_i)
                        state <= NOBURST_READ1;
                NOBURST_READ1:
                    state <= DONE;

                DONE:
                    state <= IDLE;
            endcase
        end

    always_ff @(posedge clk_i)
        if (state == IDLE)
            wrcnt <= 1'b1;
        else if (state == BURST_WRITE1 && !req_rdempty_i && !m1_waitrequest_i)
            wrcnt <= wrcnt + 1'b1;

    always_ff @(posedge clk_i or posedge rst_i)
        if (state == IDLE)
            rdcnt <= 1'b0;
        else if (m1_readdatavalid_i)
            rdcnt <= rdcnt + 1'b1;

    // ----------------------------------------------------------------
    // Receive request packet
    // ----------------------------------------------------------------

    assign req_rdreq_o = (state == RECV_REQ_HDR0)
                       | (state == BURST_WRITE0 && !req_rdempty_i)
                       | (state == BURST_WRITE1 && !req_rdempty_i
                          && !m1_waitrequest_i)
                       | (state == NOBURST_WRITE1);

    always_ff @(posedge clk_i)
        if (state == RECV_REQ_HDR1)
            req_hdr_r <= req_q_i;

    // ----------------------------------------------------------------
    // Send response packet
    // ----------------------------------------------------------------

    logic [31:0] m0_readdata_r;
    always_ff @(posedge clk_i)
        if (state == NOBURST_READ0 && !m0_waitrequest_i)
            m0_readdata_r = m0_readdata_i;

    always_ff @(posedge clk_i or posedge rst_i)
        if (rst_i) begin
            resp_valid_o <= '0;
            resp_data_o  <= '0;
        end else begin
            if (state == SEND_WRITE_RESP
                || (!m1_waitrequest_i && state == BURST_READ0)
                || (!m0_waitrequest_i && state == NOBURST_READ0))
            begin
                resp_valid_o <= 1'b1;
                resp_data_o  <= req_hdr_r;
            end
            else if (state == BURST_READ1) begin
                resp_valid_o <= m1_readdatavalid_i;
                resp_data_o  <= m1_readdata_i;
            end
            else if (state == NOBURST_READ1) begin
                resp_valid_o <= 1'b1;
                resp_data_o  <= m0_readdata_r;
            end
            else begin
                resp_valid_o <= '0;
                resp_data_o  <= '0;
            end
        end

    // ----------------------------------------------------------------
    // Drive BURST Avalon-MM Master
    // ----------------------------------------------------------------

    assign m1_address_o    = req_hdr_r.address;
    assign m1_burstcount_o = req_hdr_r.burstcnt_byteena;
    assign m1_writedata_o  = req_q_i;

    always_ff @(posedge clk_i or posedge rst_i)
        if (rst_i)
            m1_write_o <= '0;
        else if (state == BURST_WRITE0) begin
            if (!req_rdempty_i)
                m1_write_o <= 1'b1;
        end
        else if (state == BURST_WRITE1) begin
            if (!m1_waitrequest_i) begin
                if (!req_rdempty_i)
                    m1_write_o <= 1'b1;
                else
                    m1_write_o <= 1'b0;
            end
        end
        else begin
            m1_write_o <= 1'b0;
        end

    assign m1_read_o = (state == BURST_READ0);

    // ----------------------------------------------------------------
    // Drive NOBURST Avalon-MM Master
    // ----------------------------------------------------------------

    assign m0_address_o    = req_hdr_r.address;
    assign m0_byteenable_o = req_hdr_r.burstcnt_byteena[3:0];
    assign m0_writedata_o  = req_q_i;
    assign m0_write_o      = (state == NOBURST_WRITE2);
    assign m0_read_o       = (state == NOBURST_READ0);


endmodule
