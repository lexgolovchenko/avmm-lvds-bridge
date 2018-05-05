
// ----------------------------------------------------------------
// Slave interface test program
// ----------------------------------------------------------------

task automatic noburst_avs_if_test(int unsigned test_size);
    typedef struct packed {
        address_t addr;
        bit [3:0] be;
        bit [3:0][7:0] data;
    } trans_t;

    address_t addr_buf [$];
    address_t addr_tmp;

    logic [3:0][7:0] rd;
    trans_t wr_buf [$];
    trans_t tr;

    // Generate unique random addresses
    addr_buf = {};
    while (addr_buf.size() != test_size) begin
        addr_tmp = $urandom;
        if (!(addr_tmp inside {addr_buf}))
            addr_buf.push_back(addr_tmp);
    end

    // Bunch of writes
    for (int i = 0; i < test_size; ++i) begin
        tr.addr = addr_buf[i];
        tr.be = protocol_model_pkg::gen_random_byteenable();
        tr.data = $urandom;
        wr_buf.push_back(tr);

        `NOBURST_API_INST.single_write(tr.addr, tr.be, tr.data);

        repeat($urandom_range(0, 2)) @(posedge `CLK);
    end

    // Read in different order!!
    wr_buf.shuffle();

    // Bunch of reads
    for (int i = 0; i < test_size; ++i) begin
        tr = wr_buf[i];
        `NOBURST_API_INST.single_read(tr.addr, tr.be, rd);

        // Check payload
        for (int j = 0; j < 4; ++j) begin
            if (tr.be[j])
                if (tr.data[j] != rd[j]) begin
                    $display("%d wr %x rd %x", i, tr.data, rd);
                    $display("%m: Error! Data mismatch!");
                    $finish;
                end
        end

        repeat($urandom_range(0, 2)) @(posedge `CLK);
    end
endtask


task automatic burst_avs_if_test(int unsigned test_size);
    static logic [31:0] wrdata [MAX_BURST];
    static logic [31:0] rddata [MAX_BURST];
    address_t addr;
    logic [BURSTCNT_W - 1:0] brstcnt;

    for (int j = 0; j < test_size; ++j) begin
        addr = $urandom;
        if (j == 0)
            brstcnt = 1;
        else if (j == 1)
            brstcnt = MAX_BURST;
        else
            brstcnt = $urandom_range(2, MAX_BURST - 1);
        // brstcnt = 10;

        // Random data
        for (int i = 0; i < brstcnt; ++i)
            wrdata[i] = $urandom;

        `BURST_API_INST.burst_write(0, brstcnt, wrdata);
        repeat($urandom_range(0, 2)) @(posedge `CLK);
        `BURST_API_INST.burst_read(0, brstcnt, rddata);

        for (int i = 0; i < brstcnt; ++i) begin
            // $display("%x == %x", rddata[i], wrdata[i]);
            if (rddata[i] != wrdata[i]) begin
                $display("Error! Data mismatch!");
                $finish;
            end
        end
    end
endtask


task automatic avs_if_test(int noburst_test_num, int burst_test_num);
    fork
        if (noburst_test_num != 0) begin : noburst_thread
            `NOBURST_API_INST.set_command_timeout(4000);

            // without cmd idle
            `NOBURST_API_INST.randomize_cmd_idle = 0;
            `NOBURST_API_INST.cmd_idle_val = 0;
            noburst_avs_if_test(noburst_test_num);
            // const cmd idle
            `NOBURST_API_INST.cmd_idle_val = 1;
            noburst_avs_if_test(noburst_test_num);
            // random cmd idle
            `NOBURST_API_INST.randomize_cmd_idle = 1;
            `NOBURST_API_INST.cmd_idle_max = 2;
            noburst_avs_if_test(noburst_test_num);
        end

        if (burst_test_num != 0) begin : burst_thread
            `BURST_API_INST.set_command_timeout(100000);

            // without cmd idle
            `BURST_API_INST.randomize_cmd_idle = 0;
            `BURST_API_INST.cmd_idle_val = 0;
            burst_avs_if_test(burst_test_num);
            // const cmd idle
            `BURST_API_INST.cmd_idle_val = 1;
            burst_avs_if_test(burst_test_num);
            // random cmd idle
            `BURST_API_INST.randomize_cmd_idle = 1;
            `BURST_API_INST.cmd_idle_max = 2;
            burst_avs_if_test(burst_test_num);
        end
    join
endtask
