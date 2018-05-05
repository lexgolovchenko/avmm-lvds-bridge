
task automatic `NOBURST_TASK(int addr_base, int addr_span,
    int test_size, int shuffle=1
);
    static bit verbose = 0;

    typedef struct packed {
        bit [31:0] addr;
        bit [3:0][7:0] data;
        bit [3:0] be;
    } trans_t;

    bit [31:0] addr_buf [$];
    bit [31:0] addr;
    trans_t tr_buf [];
    trans_t tr;
    bit [3:0][7:0] rddata;

    addr_buf = {};
    tr_buf = {};
    tr_buf = new[test_size];

    // generate unique random address
    while (addr_buf.size() != test_size) begin
        addr = $urandom_range(addr_base, addr_base + addr_span - 1);
        addr[1:0] = 0;
        if (!(addr inside {addr_buf}))
            addr_buf.push_back(addr);
    end

    // bunch of write transactions
    for (int i = 0; i < test_size; ++i) begin
        tr.addr = addr_buf[i];
        // tr.addr = (i + 1) << 2;
        tr.be   = protocol_model_pkg::gen_random_byteenable();
        tr.data = $urandom;
        tr_buf[i] = tr;

        `MASTER_API_INST.single_write(tr.addr, tr.be, tr.data);

        if (verbose) begin
            $display("%4d: %8x %4b %8x", i, tr.addr, tr.be, tr.data);
        end
    end

    // Read in different order!
    if (shuffle)
        tr_buf.shuffle();

    if (verbose) $display("");

    // bunch of read transactions
    for (int i = 0; i < test_size; ++i) begin
        tr = tr_buf[i];
        `MASTER_API_INST.single_read(tr.addr, tr.be, rddata);

        if (verbose) begin
            $display("%4d: %8x %4b %8x", i, tr.addr, tr.be, rddata);
        end

        for (int j = 0; j < 4; ++j) begin
            if (tr.be[j])
                if (rddata[j] !== tr.data[j]) begin
                    $display("%m: Error! Data mismatch!");
                    $finish;
                end
        end
    end
endtask


task automatic `BURST_TASK(int addr_base, int addr_span,
    int test_size, int max_burst=-1
);
    static bit verbose = 0;
    localparam MAX_BURST = avmm_lvds_bridge_pkg::MAX_BURST;
    static logic [31:0] wrdata [MAX_BURST];
    static logic [31:0] rddata [MAX_BURST];
    int addr;
    int brstcnt;

    int max_burst_val = (max_burst <= 0 ? MAX_BURST : max_burst);

    `MASTER_API_INST.set_command_timeout(4000);

    for (int j = 0; j < test_size; ++j) begin
        // randomize burstcnt
        if (j == 0)
            brstcnt = 1;
        else if (j == test_size - 1)
            brstcnt = max_burst_val;
        else
            brstcnt = $urandom_range(2, max_burst_val);

        addr = addr_base + (j + 1 << 2);

        // Random data
        for (int i = 0; i < brstcnt; ++i)
            wrdata[i] = $urandom;

        `MASTER_API_INST.burst_write(addr, brstcnt, wrdata);
        `MASTER_API_INST.burst_read(addr, brstcnt, rddata);

        for (int i = 0; i < brstcnt; ++i) begin
            // $display("%x == %x", rddata[i], wrdata[i]);
            if (rddata[i] != wrdata[i]) begin
                $display("Error! Data mismatch!");
                $finish;
            end
        end
    end

endtask
