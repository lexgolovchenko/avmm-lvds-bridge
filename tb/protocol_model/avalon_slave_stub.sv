
module avalon_slave_stub #(
    parameter MAX_BURST = 1024
)(
    input  logic                       clk_i          ,
    // request
    output logic               [31:0]  req_data_o     ,
    output logic                       req_valid_o    ,
    // response
    output logic                       resp_rdreq_o   ,
    input  logic               [31:0]  resp_q_i       ,
    input  logic                       resp_rdempty_i ,
    input  logic [$clog2(MAX_BURST):0] resp_rdusedw_i
);
    timeunit 1ns;
    timeprecision 1ps;

    import avmm_lvds_bridge_pkg::*;
    import protocol_model_pkg::*;

    static bit verbose = 0;

    request_t req_queue [$];
    request_t write_req_buf [$];
    request_t read_req_buf [$];
    response_t write_resp_buf [$];
    response_t read_resp_buf [$];


    initial begin
        static request_t req;
        static response_t resp;

        req_valid_o  = '0;
        req_data_o   = 'x;
        resp_rdreq_o = '0;

        req_queue = {};

        write_req_buf = {};
        read_req_buf = {};

        write_resp_buf = {};
        read_resp_buf = {};

        forever begin
            if (req_queue.size() > 0) begin
                req = req_queue.pop_front();

                send_request(req);
                recv_response(resp);

                if (resp.hdr.tr == WRITE)
                    write_resp_buf.push_back(resp);
                else
                    read_resp_buf.push_back(resp);
            end
            @(posedge clk_i);
        end

    end


    function automatic void clear_buffers();
        req_queue = {};

        write_req_buf = {};
        read_req_buf = {};

        write_resp_buf = {};
        read_resp_buf = {};
    endfunction


    function void push_request(request_t tr);
        req_queue.push_back(tr);

        if (tr.hdr.tr == WRITE)
            write_req_buf.push_back(tr);
        else
            read_req_buf.push_back(tr);

    endfunction


    task automatic send_request(const ref request_t tr);

        @(posedge clk_i);

        // Send header
        req_valid_o = 1;
        req_data_o = tr.hdr;
        @(posedge clk_i);

        // Send data
        if (tr.hdr.tr == WRITE) begin
            req_data_o = tr.data[0];
            @(posedge clk_i);
            if (tr.hdr.burst == BURST) begin
                for (int i = 1; i < tr.hdr.burstcnt_byteena; ++i) begin
                    req_data_o = tr.data[i];
                    @(posedge clk_i);
                end
            end

        end

        req_valid_o = 0;
        @(posedge clk_i);

        if (verbose)
            display_request("SLAVE send request", tr);
    endtask


    task automatic recv_response(ref response_t tr);

        // Wait data in rx fifo
        wait(resp_rdempty_i == 0);

        // Read header
        resp_rdreq_o = 1;
        @(posedge clk_i);
        resp_rdreq_o = 0;
        @(negedge clk_i);
        tr.hdr = resp_q_i;
        @(posedge clk_i);

        // Read data from fifo for READ response
        if (tr.hdr.tr == READ) begin
            if (tr.hdr.burst == NOBURST) begin
                wait(resp_rdempty_i == 0);

                // Read data
                resp_rdreq_o = 1;
                @(posedge clk_i);
                resp_rdreq_o = 0;
                @(negedge clk_i);
                tr.data[0] = resp_q_i;
                @(posedge clk_i);
            end
            else begin // req_hdr.burst == BURST

                // because rdusedw has update delay
                @(posedge clk_i);

                // Wait all data
                wait(resp_rdusedw_i == tr.hdr.burstcnt_byteena);
                @(negedge clk_i);

                resp_rdreq_o = 1;
                @(posedge clk_i);
                for (int i = 0; i < tr.hdr.burstcnt_byteena; ++i) begin
                    @(negedge clk_i);
                    tr.data[i] = resp_q_i;
                end
                resp_rdreq_o = 0;
                @(posedge clk_i);
            end
        end

        if (verbose) begin
            display_response("SLAVE receive response", tr);
            $display("--------------------------------------------",);
        end
    endtask

endmodule
