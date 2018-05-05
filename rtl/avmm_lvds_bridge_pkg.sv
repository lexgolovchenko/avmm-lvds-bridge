
package avmm_lvds_bridge_pkg;

    parameter BURSTCNT_W  = 11;
    parameter MAX_BURST   = 2 ** (BURSTCNT_W - 1);

    parameter ADDR_W      = 32 - 2 - BURSTCNT_W;
    parameter MAX_ADDRESS = 2 ** ADDR_W - 1;

    typedef enum logic {
        WRITE = 1'd0,
        READ  = 1'd1
    } trans_e;

    typedef enum logic {
        NOBURST = 1'd0,
        BURST   = 1'd1
    } burst_e;

    typedef logic [ADDR_W - 1:0] address_t;

    typedef logic [BURSTCNT_W - 1:0] burstcnt_t;

    // 1 + 1 + 19 + 11 = 32
    typedef struct packed {
        trans_e    tr               ;
        burst_e    burst            ;
        address_t  address          ;
        burstcnt_t burstcnt_byteena ;
    } req_hdr_t ;

    // 1 + 1 + 19 + 11 = 32
    typedef struct packed {
        trans_e    tr               ;
        burst_e    burst            ;
        address_t  address          ;
        burstcnt_t burstcnt_byteena ;
    } resp_hdr_t ;

    // !!!
    // N.B. request and response header can be different in the future
    // !!!

endpackage
