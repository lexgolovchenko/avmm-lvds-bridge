
generate begin : `MASTER_TP_INST
    import avalon_mm_pkg::*;

    localparam ADDR_W     = `MASTER.AV_ADDRESS_W    ;
    localparam SYMB_W     = `MASTER.AV_SYMBOL_W     ;
    localparam NUMSYMB    = `MASTER.AV_NUMSYMBOLS   ;
    localparam BURSTCNT_W = `MASTER.AV_BURSTCOUNT_W ;
    localparam DATA_W     =  NUMSYMB * SYMB_W       ;
    localparam MAX_BURST  =  2 ** (BURSTCNT_W - 1)  ;

    bit randomize_init_latency = 1;
    int init_latency_max = 2;
    int init_latency_val = 0;

    int randomize_cmd_idle = 2;
    int cmd_idle_max = 1;
    int cmd_idle_val = 0;

    function void set_command_timeout(int command_timeout);
        `MASTER.set_command_timeout(command_timeout);
    endfunction

    task automatic single_write(
        input logic  [ADDR_W - 1:0] addr,
        input logic [NUMSYMB - 1:0] be,
        input logic  [DATA_W - 1:0] data
    );
        int cmd_idle = randomize_cmd_idle
                     ? $urandom_range(0, cmd_idle_max)
                     : cmd_idle_val;
        int init_lat = randomize_init_latency
                     ? $urandom_range(0, init_latency_max)
                     : init_latency_val;

        `MASTER.set_command_request(REQ_WRITE);
        `MASTER.set_command_burst_size(1);
        `MASTER.set_command_burst_count(1);

        `MASTER.set_command_init_latency(init_lat);
        `MASTER.set_command_idle(cmd_idle, 0);

        `MASTER.set_command_address(addr);
        `MASTER.set_command_data(data, 0);
        `MASTER.set_command_byte_enable(be, 0);
        `MASTER.push_command();

        @(`MASTER.signal_write_response_complete);

        `MASTER.pop_response();
    endtask

    task automatic single_read(
        input  logic  [ADDR_W - 1:0] addr,
        input  logic [NUMSYMB - 1:0] be,
        output logic  [DATA_W - 1:0] data
    );
        int cmd_idle = randomize_cmd_idle
                     ? $urandom_range(0, cmd_idle_max)
                     : cmd_idle_val;
        int init_lat = randomize_init_latency
                     ? $urandom_range(0, init_latency_max)
                     : init_latency_val;

        `MASTER.set_command_request(REQ_READ);
        `MASTER.set_command_burst_size(1);
        `MASTER.set_command_burst_count(1);

        `MASTER.set_command_init_latency(init_lat);
        `MASTER.set_command_idle(cmd_idle, 0);

        `MASTER.set_command_address(addr);
        `MASTER.set_command_byte_enable(be, 0);
        `MASTER.push_command();

        @(`MASTER.signal_read_response_complete);

        `MASTER.pop_response();
        data = `MASTER.get_response_data(0);
    endtask

    task automatic burst_write(
        input logic     [ADDR_W - 1:0] addr,
        input logic [BURSTCNT_W - 1:0] brstcnt,
        ref   logic     [DATA_W - 1:0] data [MAX_BURST]
    );
        int cmd_idle;
        int init_lat = randomize_init_latency
                     ? $urandom_range(0, init_latency_max)
                     : init_latency_val;

        `MASTER.set_command_request(REQ_WRITE);
        `MASTER.set_command_address(addr);
        `MASTER.set_command_burst_count(brstcnt);
        `MASTER.set_command_burst_size(brstcnt);

        `MASTER.set_command_init_latency(init_lat);

        for (int i = 0; i < brstcnt; ++i) begin
            `MASTER.set_command_byte_enable('1, i);
            `MASTER.set_command_data(data[i], i);

            cmd_idle = randomize_cmd_idle
                     ? $urandom_range(0, cmd_idle_max)
                     : cmd_idle_val;
            `MASTER.set_command_idle(cmd_idle, i);
        end

        `MASTER.push_command();

        @(`MASTER.signal_write_response_complete);

        `MASTER.pop_response();
    endtask

    task automatic burst_read(
        input logic     [ADDR_W - 1:0] addr,
        input logic [BURSTCNT_W - 1:0] brstcnt,
        ref   logic     [DATA_W - 1:0] data [MAX_BURST]
    );
        int init_lat = randomize_init_latency
                     ? $urandom_range(0, init_latency_max)
                     : init_latency_val;

        `MASTER.set_command_request(REQ_READ);
        `MASTER.set_command_address(addr);
        `MASTER.set_command_burst_count(brstcnt);
        `MASTER.set_command_burst_size(brstcnt);

        `MASTER.set_command_init_latency(init_lat);

        `MASTER.push_command();

        @(`MASTER.signal_read_response_complete);

        `MASTER.pop_response();

        for (int i = 0; i < brstcnt; ++i) begin
            data[i] = `MASTER.get_response_data(i);
        end
    endtask

end endgenerate
