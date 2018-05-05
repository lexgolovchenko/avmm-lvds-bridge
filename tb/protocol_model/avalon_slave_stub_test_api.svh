
task automatic test(burst_e burst, int unsigned test_size);
    address_t addr_buf [$];
    address_t addr_tmp;
    request_t req_tmp;
    bit [BURSTCNT_W - 1:0] brstcnt;

    `AVS_STUB_INST.clear_buffers();

    // Generate unique random addresses
    addr_buf = {};
    while (addr_buf.size() != test_size) begin
        addr_tmp = $urandom;
        // Prevent address crossing for different burst transaction
        if (burst == BURST)
            addr_tmp[BURSTCNT_W - 1:0] = '0;

        if (!(addr_tmp inside {addr_buf}))
            addr_buf.push_back(addr_tmp);
    end

    // bunch of write transactions
    for (int i = 0; i < test_size; ++i) begin
        if (burst == NOBURST)
            brstcnt = gen_random_byteenable();
        else begin
            if (i == 0)
                brstcnt = 1;
            else if (i == 1)
                brstcnt = MAX_BURST;
            else
                brstcnt = $urandom_range(2, MAX_BURST - 1);
        end

        `AVS_STUB_INST.push_request(
            create_request(WRITE, burst, addr_buf[i],
                           brstcnt, $urandom(), 1)
        );
    end

    // wait when all write transactions complete
    wait(`AVS_STUB_INST.write_resp_buf.size() == test_size);

    // bunch of read transactions
    for (int i = 0; i < test_size; ++i) begin
        req_tmp = `AVS_STUB_INST.write_req_buf[i];
        `AVS_STUB_INST.push_request(
            create_request(READ, burst,
                           req_tmp.hdr.address,
                           req_tmp.hdr.burstcnt_byteena)
        );
    end

    // wait when all read transactions complete
    wait(`AVS_STUB_INST.read_resp_buf.size() == test_size);

    check_test_result(test_size);

endtask


function automatic void check_test_result(int test_size);

    static bit verbose = 0;

    request_t req_tmp;
    response_t resp_tmp;

    // check result
    for (int i = 0; i < test_size; ++i) begin
        req_tmp = `AVS_STUB_INST.write_req_buf[i];
        resp_tmp = `AVS_STUB_INST.read_resp_buf[i];

        if (verbose) begin
            display_request("Write request", req_tmp);
            display_response("Read request", resp_tmp);
            $display("------------------------------------");
        end

        if (!verify_read_response(req_tmp, resp_tmp)) begin
            $display("Error! Write request and read response mismatch!");
            display_request("Write request", req_tmp);
            display_response("Read request", resp_tmp);

            $finish;
        end
    end
endfunction


function automatic bit verify_read_response(
    const ref request_t wr_req, const ref response_t rd_resp
);
    // check header
    if (wr_req.hdr.burst            !== rd_resp.hdr.burst ||
        wr_req.hdr.address          !== rd_resp.hdr.address ||
        wr_req.hdr.burstcnt_byteena !== rd_resp.hdr.burstcnt_byteena)
    begin
        return 0;
    end

    // check data
    if (wr_req.hdr.burst == NOBURST) begin
        if (wr_req.hdr.burstcnt_byteena[0])
            if (wr_req.data[0][7:0] !== rd_resp.data[0][7:0])
                return 0;

        if (wr_req.hdr.burstcnt_byteena[1])
            if (wr_req.data[0][15:8] !== rd_resp.data[0][15:8])
                return 0;

        if (wr_req.hdr.burstcnt_byteena[2])
            if (wr_req.data[0][23:16] !== rd_resp.data[0][23:16])
                return 0;

        if (wr_req.hdr.burstcnt_byteena[3])
            if (wr_req.data[0][31:24] !== rd_resp.data[0][31:24])
                return 0;
    end
    else begin
        for (int j = 0; j < wr_req.hdr.burstcnt_byteena; ++j)
            if (wr_req.data[j] !== rd_resp.data[j])
                return 0;
    end

    return 1;
endfunction
