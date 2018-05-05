
module avalon_master_stub #(
    parameter MAX_BURST = 1024
)(
    input  logic                       clk_i         ,
    // request
    output logic                       req_rdreq_o   ,
    input  logic                [31:0] req_q_i       ,
    input  logic                       req_rdempty_i ,
    input  logic [$clog2(MAX_BURST):0] req_rdusedw_i ,
    // response
    output logic                [31:0] resp_data_o   ,
    output logic                       resp_valid_o

);

    import avmm_lvds_bridge_pkg::*;
    import protocol_model_pkg::*;

    static bit verbose = 0;

    logic [31:0] noburst_mem [*];
    logic [31:0]   burst_mem [*];

    initial begin
        static request_t req;
        static response_t resp;

        noburst_mem = {};
        burst_mem = {};

        req_rdreq_o  = '0;
        resp_valid_o = '0;
        resp_data_o  = 'x;

        forever begin
            recv_request(req);
            process_request(req, resp);
            send_response(resp);
        end
    end


    task automatic recv_request(ref request_t tr);
        // Wait data in rx fifo
        wait(req_rdempty_i == 0);

        // Read header
        req_rdreq_o = 1;
        @(posedge clk_i);
        req_rdreq_o = 0;
        @(negedge clk_i);
        tr.hdr = req_q_i;
        @(posedge clk_i);

        // Read data from fifo for WRITE request
        if (tr.hdr.tr == WRITE) begin
            if (tr.hdr.burst == NOBURST) begin
                wait(req_rdempty_i == 0);

                // Read data
                req_rdreq_o = 1;
                @(posedge clk_i);
                req_rdreq_o = 0;
                @(negedge clk_i);
                tr.data[0] = req_q_i;
                @(posedge clk_i);
            end
            else begin // req_hdr.burst == BURST

                // because rdusedw has update delay
                @(posedge clk_i);

                // Wait all data
                wait(req_rdusedw_i == tr.hdr.burstcnt_byteena);
                @(negedge clk_i);

                req_rdreq_o = 1;
                @(posedge clk_i);
                for (int i = 0; i < tr.hdr.burstcnt_byteena; ++i) begin
                    @(negedge clk_i);
                    tr.data[i] = req_q_i;
                end
                req_rdreq_o = 0;
                @(posedge clk_i);
            end
        end

        if (verbose)
            display_request("MASTER receive request", tr);
    endtask


    task automatic process_request(
        const ref request_t req_tr, ref response_t resp_tr
    );

        // Process write transaction

        if (req_tr.hdr.tr == WRITE) begin
            if (req_tr.hdr.burst == NOBURST) begin
                noburst_mem[req_tr.hdr.address] = 'x;
                if (req_tr.hdr.burstcnt_byteena[0])
                    noburst_mem[req_tr.hdr.address][7:0] = req_tr.data[0][7:0];
                if (req_tr.hdr.burstcnt_byteena[1])
                    noburst_mem[req_tr.hdr.address][15:8] = req_tr.data[0][15:8];
                if (req_tr.hdr.burstcnt_byteena[2])
                    noburst_mem[req_tr.hdr.address][23:16] = req_tr.data[0][23:16];
                if (req_tr.hdr.burstcnt_byteena[3])
                    noburst_mem[req_tr.hdr.address][31:24] = req_tr.data[0][31:24];
            end
            else begin // req.hdr.tr == BURST
                for (int i = 0; i < req_tr.hdr.burstcnt_byteena; ++i) begin
                    burst_mem[req_tr.hdr.address + i] = req_tr.data[i];
                end
            end
        end

        // Prepare response

        // prepare header (send request header back)
        resp_tr.hdr = req_tr.hdr;
        // prepare data
        if (resp_tr.hdr.tr == READ) begin
            if (resp_tr.hdr.burst == NOBURST) begin
                resp_tr.data[0] = noburst_mem[resp_tr.hdr.address];
            end
            else begin
                for (int i = 0; i < resp_tr.hdr.burstcnt_byteena; ++i) begin
                    resp_tr.data[i] = burst_mem[resp_tr.hdr.address + i];
                end
            end
        end

    endtask


    task automatic send_response(const ref response_t tr);
        @(posedge clk_i);

        // Send header
        resp_valid_o = 1;
        resp_data_o = tr.hdr;
        @(posedge clk_i);

        // Send data
        if (tr.hdr.tr == READ) begin
            resp_data_o = tr.data[0];
            @(posedge clk_i);
            if (tr.hdr.burst == BURST) begin
                for (int i = 1; i < tr.hdr.burstcnt_byteena; ++i) begin
                    resp_data_o = tr.data[i];
                    @(posedge clk_i);
                end
            end

        end

        resp_valid_o = 0;
        @(posedge clk_i);

        if (verbose)
            display_response("MASTER send response", tr);
    endtask

endmodule
