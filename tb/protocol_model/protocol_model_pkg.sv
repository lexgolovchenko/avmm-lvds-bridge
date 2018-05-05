
package protocol_model_pkg;
    import avmm_lvds_bridge_pkg::*;

    typedef struct {
        req_hdr_t    hdr;
        logic [31:0] data [MAX_BURST];
    } request_t;

    typedef struct {
        resp_hdr_t   hdr;
        logic [31:0] data [MAX_BURST];
    } response_t;


    function bit [3:0] gen_random_byteenable();
        const static bit [3:0] be_valid[7] = '{
            'b0001,
            'b0010,
            'b0100,
            'b1000,
            'b0011,
            'b1100,
            'b1111
        };

        return be_valid[$urandom() % $size(be_valid)];
    endfunction


    function automatic request_t create_request(
        trans_e      tr,
        burst_e      burst,
        address_t    address='0,
        burstcnt_t   burstcnt_byteena='b01111,
        logic [31:0] data0='hDEAD_BEEF,
        bit          rand_payload=1
    );
        request_t new_req;

        // header
        new_req.hdr.tr = tr;
        new_req.hdr.burst = burst;
        new_req.hdr.address = address[ADDR_W - 1:0];
        if (burst == BURST)
            new_req.hdr.burstcnt_byteena = burstcnt_byteena;
        else
            new_req.hdr.burstcnt_byteena = {'0, burstcnt_byteena[3:0]};

        // payload
        if (tr == WRITE) begin
            if (burst == NOBURST) begin
                new_req.data[0] = data0;
            end
            else begin
                for (int i = 0; i < burstcnt_byteena; ++i)
                    new_req.data[i] = rand_payload ? $urandom : (i + 1);
            end
        end

        return new_req;
    endfunction


    function automatic void display_request_header(const ref req_hdr_t hdr);
        if (hdr.burst == NOBURST)
            $display("HDR : %-5s %-7s A %6x BE   %4b",
                     hdr.tr.name(), hdr.burst.name(),
                     hdr.address, hdr.burstcnt_byteena[3:0]);
        else
            $display("HDR : %-5s %-7s A %6x BCNT %4d",
                     hdr.tr.name(), hdr.burst.name(),
                     hdr.address, hdr.burstcnt_byteena);
    endfunction


    function automatic void display_payload(
        int size,
        const ref logic [31:0] data [MAX_BURST]
    );
        if (size <= 6) begin
            $display("DATA: 0 - %8x", data[0]);
            for (int i = 1; i < size; ++i)
                $display("%7d - %8x", i, data[i]);
        end
        else begin
            $display("DATA: 0 - %8x", data[0]);
            for (int i = 1; i < 3; ++i)
                $display("%7d - %8x", i, data[i]);
            $display("          ...");
            for (int i = size - 3; i < size; ++i)
                $display("%7d - %8x", i, data[i]);
        end
    endfunction


    function automatic void display_request(
        string msg, const ref request_t req
    );
        $display("%s : ", msg);

        display_request_header(req.hdr);

        // print payload for write request only
        if (req.hdr.tr == WRITE) begin
            if (req.hdr.burst == NOBURST)
                display_payload(1, req.data);
            else
                display_payload(req.hdr.burstcnt_byteena, req.data);
        end

    endfunction


    function automatic void display_response_header(const ref resp_hdr_t hdr);
        if (hdr.burst == NOBURST)
            $display("HDR : %s %s A %6x BE   %4b",
                     hdr.tr.name(), hdr.burst.name(),
                     hdr.address, hdr.burstcnt_byteena[3:0]);
        else
            $display("HDR : %s %s A %6x BCNT %4d",
                     hdr.tr.name(), hdr.burst.name(),
                     hdr.address, hdr.burstcnt_byteena);
    endfunction


    function automatic void display_response(
        string msg, const ref response_t resp
    );
        $display("%s : ", msg);

        display_request_header(resp.hdr);

        // print payload for read response only
        if (resp.hdr.tr == READ) begin
            if (resp.hdr.burst == NOBURST)
                display_payload(1, resp.data);
            else
                display_payload(resp.hdr.burstcnt_byteena, resp.data);
        end

    endfunction

endpackage
