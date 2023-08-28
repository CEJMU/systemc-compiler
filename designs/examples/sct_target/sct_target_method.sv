//==============================================================================
//
// The code is generated by Intel Compiler for SystemC, version 1.5.13
// see more information at https://github.com/intel/systemc-compiler
//
//==============================================================================

//==============================================================================
//
// Module: simple_test ()
//
module simple_test // "test_top.dut"
(
    input logic clk,
    input logic nrst
);

// Variables generated for SystemC signals
logic run_put_req;
logic run_put_req_d;
logic run_core_req_d;
logic run_core_ready_d;
logic run_sync_req;
logic run_sync_req_d;
logic [15:0] run_sync_data;
logic resp_get_req;
logic resp_get_req_d;
logic resp_reg_full;
logic resp_reg_full_d;
logic resp_core_req_d;
logic [15:0] resp_core_data_d;
logic [15:0] in_s;
logic [15:0] out_s;
logic run_clk;
logic run_nrst;
logic run_core_ready;
logic run_core_req;
logic [15:0] run_core_data;
logic resp_clk;
logic resp_nrst;
logic resp_core_ready;
logic resp_core_req;
logic [15:0] resp_core_data;

// Local parameters generated for C++ constants
localparam logic run_sync = 1;
localparam logic run_cthread = 1;
localparam logic run_always_ready = 0;
localparam logic resp_cthread = 1;
localparam logic resp_always_ready = 0;

// Assignments generated for C++ channel arrays
assign run_clk = clk;
assign run_nrst = nrst;
assign resp_clk = clk;
assign resp_nrst = nrst;

//------------------------------------------------------------------------------
// Clocked THREAD: run_sync_thread (sct_initiator.h:207:5) 

// Thread-local variables
logic run_sync_req_d_next;
logic run_put_req_next;
logic [15:0] run_core_data_next;

// Next-state combinational logic
always_comb begin : run_sync_thread_comb     // sct_initiator.h:207:5
    run_sync_thread_func;
end
function void run_sync_thread_func;
    logic A;
    run_core_data_next = run_core_data;
    run_put_req_next = run_put_req;
    run_sync_req_d_next = run_sync_req_d;
    A = run_sync_req != run_sync_req_d;
    if (A && run_core_ready)
    begin
        run_put_req_next = !run_put_req;
        run_core_data_next = run_sync_data;
        run_sync_req_d_next = run_sync_req;
    end
endfunction

// Synchronous register update
always_ff @(posedge run_clk or negedge run_nrst) 
begin : run_sync_thread_ff
    if ( ~run_nrst ) begin
        run_sync_req_d <= 0;
        run_put_req <= 0;
        run_core_data <= 0;
    end
    else begin
        run_sync_req_d <= run_sync_req_d_next;
        run_put_req <= run_put_req_next;
        run_core_data <= run_core_data_next;
    end
end

//------------------------------------------------------------------------------
// Method process: run_req_control (sct_initiator.h:228:5) 

always_comb 
begin : run_req_control     // sct_initiator.h:228:5
    logic A;
    A = run_put_req != run_put_req_d;
    if (A)
    begin
        run_core_req = 1;
    end else begin
        if (run_core_ready_d)
        begin
            run_core_req = 0;
        end else begin
            run_core_req = run_core_req_d;
        end
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: run_core_thread (sct_initiator.h:244:5) 

// Thread-local variables
logic run_put_req_d_next;
logic run_core_req_d_next;
logic run_core_ready_d_next;

// Next-state combinational logic
always_comb begin : run_core_thread_comb     // sct_initiator.h:244:5
    run_core_thread_func;
end
function void run_core_thread_func;
    run_core_ready_d_next = run_core_ready_d;
    run_core_req_d_next = run_core_req_d;
    run_put_req_d_next = run_put_req_d;
    run_put_req_d_next = run_put_req;
    run_core_req_d_next = run_core_req;
    run_core_ready_d_next = run_core_ready;
endfunction

// Synchronous register update
always_ff @(posedge run_clk or negedge run_nrst) 
begin : run_core_thread_ff
    if ( ~run_nrst ) begin
        run_put_req_d <= 0;
        run_core_req_d <= 0;
        run_core_ready_d <= 0;
    end
    else begin
        run_put_req_d <= run_put_req_d_next;
        run_core_req_d <= run_core_req_d_next;
        run_core_ready_d <= run_core_ready_d_next;
    end
end

//------------------------------------------------------------------------------
// Method process: resp_ready_control (sct_target.h:244:5) 

always_comb 
begin : resp_ready_control     // sct_target.h:244:5
    logic A;
    A = resp_get_req != resp_get_req_d;
    resp_core_ready = A || !resp_reg_full;
end

//------------------------------------------------------------------------------
// Method process: resp_full_control (sct_target.h:249:5) 

always_comb 
begin : resp_full_control     // sct_target.h:249:5
    logic A;
    A = resp_get_req != resp_get_req_d;
    if (A)
    begin
        resp_reg_full = 0;
    end else begin
        if (resp_core_req_d)
        begin
            resp_reg_full = 1;
        end else begin
            resp_reg_full = resp_reg_full_d;
        end
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: resp_core_thread (sct_target.h:261:5) 

// Thread-local variables
logic resp_get_req_d_next;
logic resp_core_req_d_next;
logic resp_reg_full_d_next;
logic [15:0] resp_core_data_d_next;

// Next-state combinational logic
always_comb begin : resp_core_thread_comb     // sct_target.h:261:5
    resp_core_thread_func;
end
function void resp_core_thread_func;
    resp_core_data_d_next = resp_core_data_d;
    resp_core_req_d_next = resp_core_req_d;
    resp_get_req_d_next = resp_get_req_d;
    resp_reg_full_d_next = resp_reg_full_d;
    resp_get_req_d_next = resp_get_req;
    resp_core_req_d_next = resp_core_req;
    resp_reg_full_d_next = resp_reg_full;
    if (resp_core_req && !resp_reg_full)
    begin
        resp_core_data_d_next = resp_core_data;
    end
endfunction

// Synchronous register update
always_ff @(posedge resp_clk or negedge resp_nrst) 
begin : resp_core_thread_ff
    if ( ~resp_nrst ) begin
        resp_get_req_d <= 0;
        resp_core_req_d <= 0;
        resp_reg_full_d <= 0;
        resp_core_data_d <= 0;
    end
    else begin
        resp_get_req_d <= resp_get_req_d_next;
        resp_core_req_d <= resp_core_req_d_next;
        resp_reg_full_d <= resp_reg_full_d_next;
        resp_core_data_d <= resp_core_data_d_next;
    end
end

//------------------------------------------------------------------------------
// Method process: resp_put_to_fifo (sct_target.h:230:5) 
// Empty process, no code generated 

//------------------------------------------------------------------------------
// Clocked THREAD: init_thread (method_test.h:104:5) 

// Thread-local variables
logic run_sync_req_next;
logic [15:0] run_sync_data_next;
logic resp_get_req_next;
logic [15:0] in_s_next;
logic [4:0] init_thread_PROC_STATE;
logic [4:0] init_thread_PROC_STATE_next;

// Next-state combinational logic
always_comb begin : init_thread_comb     // method_test.h:104:5
    init_thread_func;
end
function void init_thread_func;
    logic TMP_0;
    logic [15:0] data;
    logic TMP_1;
    logic TMP_2;
    logic enable;
    logic A;
    logic TMP_3;
    logic TMP_4;
    logic TMP_5;
    logic TMP_6;
    logic TMP_7;
    logic TMP_8;
    logic TMP_9;
    logic TMP_10;
    logic TMP_11;
    logic TMP_12;
    logic TMP_13;
    logic TMP_14;
    logic TMP_15;
    logic TMP_16;
    logic TMP_17;
    logic TMP_18;
    logic TMP_19;
    logic TMP_20;
    logic TMP_21;
    logic TMP_22;
    logic TMP_23;
    in_s_next = in_s;
    resp_get_req_next = resp_get_req;
    run_sync_data_next = run_sync_data;
    run_sync_req_next = run_sync_req;
    init_thread_PROC_STATE_next = init_thread_PROC_STATE;
    
    case (init_thread_PROC_STATE)
        0: begin
            in_s_next = 42;
            data = 42;
            // Call put() begin
            if (run_core_ready)
            begin
                run_sync_req_next = !run_sync_req;
                run_sync_data_next = data;
                TMP_0 = 1;
            end else begin
                TMP_0 = 0;
            end
            // Call put() end
            if (!TMP_0)
            begin
                init_thread_PROC_STATE_next = 1; return;    // method_test.h:113:30;
            end
            init_thread_PROC_STATE_next = 2; return;    // method_test.h:114:9;
        end
        1: begin
            data = 42;
            // Call put() begin
            if (run_core_ready)
            begin
                run_sync_req_next = !run_sync_req;
                run_sync_data_next = data;
                TMP_1 = 1;
            end else begin
                TMP_1 = 0;
            end
            // Call put() end
            if (!TMP_1)
            begin
                init_thread_PROC_STATE_next = 1; return;    // method_test.h:113:30;
            end
            init_thread_PROC_STATE_next = 2; return;    // method_test.h:114:9;
        end
        2: begin
            enable = 1;
            // Call get() begin
            A = (resp_core_req || resp_reg_full);
            if (A)
            begin
                resp_get_req_next = !resp_get_req;
                TMP_2 = enable;
            end else begin
                TMP_2 = 0;
            end
            // Call get() end
            if (!TMP_2)
            begin
                init_thread_PROC_STATE_next = 3; return;    // method_test.h:115:33;
            end
            init_thread_PROC_STATE_next = 4; return;    // method_test.h:116:30;
        end
        3: begin
            enable = 1;
            // Call get() begin
            A = (resp_core_req || resp_reg_full);
            if (A)
            begin
                resp_get_req_next = !resp_get_req;
                TMP_3 = enable;
            end else begin
                TMP_3 = 0;
            end
            // Call get() end
            if (!TMP_3)
            begin
                init_thread_PROC_STATE_next = 3; return;    // method_test.h:115:33;
            end
            init_thread_PROC_STATE_next = 4; return;    // method_test.h:116:30;
        end
        4: begin
            in_s_next = 43;
            data = 43;
            // Call put() begin
            if (run_core_ready)
            begin
                run_sync_req_next = !run_sync_req;
                run_sync_data_next = data;
                TMP_4 = 1;
            end else begin
                TMP_4 = 0;
            end
            // Call put() end
            if (!TMP_4)
            begin
                init_thread_PROC_STATE_next = 5; return;    // method_test.h:119:30;
            end
            init_thread_PROC_STATE_next = 6; return;    // method_test.h:120:9;
        end
        5: begin
            data = 43;
            // Call put() begin
            if (run_core_ready)
            begin
                run_sync_req_next = !run_sync_req;
                run_sync_data_next = data;
                TMP_5 = 1;
            end else begin
                TMP_5 = 0;
            end
            // Call put() end
            if (!TMP_5)
            begin
                init_thread_PROC_STATE_next = 5; return;    // method_test.h:119:30;
            end
            init_thread_PROC_STATE_next = 6; return;    // method_test.h:120:9;
        end
        6: begin
            in_s_next = 44;
            data = 44;
            // Call put() begin
            if (run_core_ready)
            begin
                run_sync_req_next = !run_sync_req;
                run_sync_data_next = data;
                TMP_6 = 1;
            end else begin
                TMP_6 = 0;
            end
            // Call put() end
            if (!TMP_6)
            begin
                init_thread_PROC_STATE_next = 7; return;    // method_test.h:122:30;
            end
            init_thread_PROC_STATE_next = 8; return;    // method_test.h:123:9;
        end
        7: begin
            data = 44;
            // Call put() begin
            if (run_core_ready)
            begin
                run_sync_req_next = !run_sync_req;
                run_sync_data_next = data;
                TMP_7 = 1;
            end else begin
                TMP_7 = 0;
            end
            // Call put() end
            if (!TMP_7)
            begin
                init_thread_PROC_STATE_next = 7; return;    // method_test.h:122:30;
            end
            init_thread_PROC_STATE_next = 8; return;    // method_test.h:123:9;
        end
        8: begin
            enable = 1;
            // Call get() begin
            A = (resp_core_req || resp_reg_full);
            if (A)
            begin
                resp_get_req_next = !resp_get_req;
                TMP_8 = enable;
            end else begin
                TMP_8 = 0;
            end
            // Call get() end
            if (!TMP_8)
            begin
                init_thread_PROC_STATE_next = 9; return;    // method_test.h:124:33;
            end
            init_thread_PROC_STATE_next = 10; return;    // method_test.h:125:30;
        end
        9: begin
            enable = 1;
            // Call get() begin
            A = (resp_core_req || resp_reg_full);
            if (A)
            begin
                resp_get_req_next = !resp_get_req;
                TMP_9 = enable;
            end else begin
                TMP_9 = 0;
            end
            // Call get() end
            if (!TMP_9)
            begin
                init_thread_PROC_STATE_next = 9; return;    // method_test.h:124:33;
            end
            init_thread_PROC_STATE_next = 10; return;    // method_test.h:125:30;
        end
        10: begin
            enable = 1;
            // Call get() begin
            A = (resp_core_req || resp_reg_full);
            if (A)
            begin
                resp_get_req_next = !resp_get_req;
                TMP_10 = enable;
            end else begin
                TMP_10 = 0;
            end
            // Call get() end
            if (!TMP_10)
            begin
                init_thread_PROC_STATE_next = 11; return;    // method_test.h:126:33;
            end
            init_thread_PROC_STATE_next = 12; return;    // method_test.h:127:30;
        end
        11: begin
            enable = 1;
            // Call get() begin
            A = (resp_core_req || resp_reg_full);
            if (A)
            begin
                resp_get_req_next = !resp_get_req;
                TMP_11 = enable;
            end else begin
                TMP_11 = 0;
            end
            // Call get() end
            if (!TMP_11)
            begin
                init_thread_PROC_STATE_next = 11; return;    // method_test.h:126:33;
            end
            init_thread_PROC_STATE_next = 12; return;    // method_test.h:127:30;
        end
        12: begin
            data = 45;
            // Call put() begin
            if (run_core_ready)
            begin
                run_sync_req_next = !run_sync_req;
                run_sync_data_next = data;
                TMP_12 = 1;
            end else begin
                TMP_12 = 0;
            end
            // Call put() end
            if (!TMP_12)
            begin
                init_thread_PROC_STATE_next = 13; return;    // method_test.h:129:30;
            end
            init_thread_PROC_STATE_next = 14; return;    // method_test.h:130:9;
        end
        13: begin
            data = 45;
            // Call put() begin
            if (run_core_ready)
            begin
                run_sync_req_next = !run_sync_req;
                run_sync_data_next = data;
                TMP_13 = 1;
            end else begin
                TMP_13 = 0;
            end
            // Call put() end
            if (!TMP_13)
            begin
                init_thread_PROC_STATE_next = 13; return;    // method_test.h:129:30;
            end
            init_thread_PROC_STATE_next = 14; return;    // method_test.h:130:9;
        end
        14: begin
            data = 46;
            // Call put() begin
            if (run_core_ready)
            begin
                run_sync_req_next = !run_sync_req;
                run_sync_data_next = data;
                TMP_14 = 1;
            end else begin
                TMP_14 = 0;
            end
            // Call put() end
            if (!TMP_14)
            begin
                init_thread_PROC_STATE_next = 15; return;    // method_test.h:131:30;
            end
            init_thread_PROC_STATE_next = 16; return;    // method_test.h:132:9;
        end
        15: begin
            data = 46;
            // Call put() begin
            if (run_core_ready)
            begin
                run_sync_req_next = !run_sync_req;
                run_sync_data_next = data;
                TMP_15 = 1;
            end else begin
                TMP_15 = 0;
            end
            // Call put() end
            if (!TMP_15)
            begin
                init_thread_PROC_STATE_next = 15; return;    // method_test.h:131:30;
            end
            init_thread_PROC_STATE_next = 16; return;    // method_test.h:132:9;
        end
        16: begin
            data = 47;
            // Call put() begin
            if (run_core_ready)
            begin
                run_sync_req_next = !run_sync_req;
                run_sync_data_next = data;
                TMP_16 = 1;
            end else begin
                TMP_16 = 0;
            end
            // Call put() end
            if (!TMP_16)
            begin
                init_thread_PROC_STATE_next = 17; return;    // method_test.h:133:30;
            end
            init_thread_PROC_STATE_next = 18; return;    // method_test.h:134:9;
        end
        17: begin
            data = 47;
            // Call put() begin
            if (run_core_ready)
            begin
                run_sync_req_next = !run_sync_req;
                run_sync_data_next = data;
                TMP_17 = 1;
            end else begin
                TMP_17 = 0;
            end
            // Call put() end
            if (!TMP_17)
            begin
                init_thread_PROC_STATE_next = 17; return;    // method_test.h:133:30;
            end
            init_thread_PROC_STATE_next = 18; return;    // method_test.h:134:9;
        end
        18: begin
            enable = 1;
            // Call get() begin
            A = (resp_core_req || resp_reg_full);
            if (A)
            begin
                resp_get_req_next = !resp_get_req;
                TMP_18 = enable;
            end else begin
                TMP_18 = 0;
            end
            // Call get() end
            if (!TMP_18)
            begin
                init_thread_PROC_STATE_next = 19; return;    // method_test.h:135:33;
            end
            init_thread_PROC_STATE_next = 20; return;    // method_test.h:136:30;
        end
        19: begin
            enable = 1;
            // Call get() begin
            A = (resp_core_req || resp_reg_full);
            if (A)
            begin
                resp_get_req_next = !resp_get_req;
                TMP_19 = enable;
            end else begin
                TMP_19 = 0;
            end
            // Call get() end
            if (!TMP_19)
            begin
                init_thread_PROC_STATE_next = 19; return;    // method_test.h:135:33;
            end
            init_thread_PROC_STATE_next = 20; return;    // method_test.h:136:30;
        end
        20: begin
            enable = 1;
            // Call get() begin
            A = (resp_core_req || resp_reg_full);
            if (A)
            begin
                resp_get_req_next = !resp_get_req;
                TMP_20 = enable;
            end else begin
                TMP_20 = 0;
            end
            // Call get() end
            if (!TMP_20)
            begin
                init_thread_PROC_STATE_next = 21; return;    // method_test.h:137:33;
            end
            init_thread_PROC_STATE_next = 22; return;    // method_test.h:138:30;
        end
        21: begin
            enable = 1;
            // Call get() begin
            A = (resp_core_req || resp_reg_full);
            if (A)
            begin
                resp_get_req_next = !resp_get_req;
                TMP_21 = enable;
            end else begin
                TMP_21 = 0;
            end
            // Call get() end
            if (!TMP_21)
            begin
                init_thread_PROC_STATE_next = 21; return;    // method_test.h:137:33;
            end
            init_thread_PROC_STATE_next = 22; return;    // method_test.h:138:30;
        end
        22: begin
            enable = 1;
            // Call get() begin
            A = (resp_core_req || resp_reg_full);
            if (A)
            begin
                resp_get_req_next = !resp_get_req;
                TMP_22 = enable;
            end else begin
                TMP_22 = 0;
            end
            // Call get() end
            if (!TMP_22)
            begin
                init_thread_PROC_STATE_next = 23; return;    // method_test.h:139:33;
            end
            init_thread_PROC_STATE_next = 24; return;    // method_test.h:140:30;
        end
        23: begin
            enable = 1;
            // Call get() begin
            A = (resp_core_req || resp_reg_full);
            if (A)
            begin
                resp_get_req_next = !resp_get_req;
                TMP_23 = enable;
            end else begin
                TMP_23 = 0;
            end
            // Call get() end
            if (!TMP_23)
            begin
                init_thread_PROC_STATE_next = 23; return;    // method_test.h:139:33;
            end
            init_thread_PROC_STATE_next = 24; return;    // method_test.h:140:30;
        end
        24: begin
            init_thread_PROC_STATE_next = 25; return;    // method_test.h:143:9;
        end
        25: begin
            init_thread_PROC_STATE_next = 26; return;    // method_test.h:146:13;
        end
        26: begin
            init_thread_PROC_STATE_next = 26; return;    // method_test.h:146:13;
        end
    endcase
endfunction

// Synchronous register update
always_ff @(posedge run_clk or negedge nrst) 
begin : init_thread_ff
    if ( ~nrst ) begin
        // Call reset_put() begin
        run_sync_req <= 0;
        run_sync_data <= 0;
        // Call reset_put() end
        // Call reset_get() begin
        resp_get_req <= 0;
        // Call reset_get() end
        in_s <= 0;
        init_thread_PROC_STATE <= 0;    // method_test.h:110:9;
    end
    else begin
        run_sync_req <= run_sync_req_next;
        run_sync_data <= run_sync_data_next;
        resp_get_req <= resp_get_req_next;
        in_s <= in_s_next;
        init_thread_PROC_STATE <= init_thread_PROC_STATE_next;
    end
end


//------------------------------------------------------------------------------
// Child module instances

B a
(
  .run_core_ready_s(run_core_ready),
  .run_core_req_s(run_core_req),
  .run_core_data_s(run_core_data),
  .resp_core_ready_s(resp_core_ready),
  .resp_core_req_s(resp_core_req),
  .resp_core_data_s(resp_core_data),
  .clk(clk),
  .nrst(nrst),
  .in(in_s),
  .out(out_s)
);

endmodule



//==============================================================================
//
// Module: B (method_test.h:81:5)
//
module B // "test_top.dut.a"
(
    output logic run_core_ready_s,
    input logic run_core_req_s,
    input logic [15:0] run_core_data_s,
    input logic resp_core_ready_s,
    output logic resp_core_req_s,
    output logic [15:0] resp_core_data_s,
    input logic clk,
    input logic nrst,
    input logic [15:0] in,
    output logic [15:0] out
);

// Variables generated for SystemC signals
logic run_get_req;
logic run_get_req_d;
logic run_reg_full;
logic run_reg_full_d;
logic run_core_req_d;
logic [15:0] run_core_data_d;
logic resp_put_req;
logic resp_put_req_d;
logic resp_core_req_d;
logic resp_core_ready_d;
logic resp_sync_req;
logic [15:0] resp_sync_data;
logic [15:0] ss;
logic run_clk;
logic run_nrst;
logic run_core_ready;
logic run_core_req;
logic [15:0] run_core_data;
logic resp_clk;
logic resp_nrst;
logic resp_core_ready;
logic resp_core_req;
logic [15:0] resp_core_data;

// Local parameters generated for C++ constants
localparam logic run_cthread = 0;
localparam logic run_always_ready = 0;
localparam logic resp_sync = 1;
localparam logic resp_cthread = 0;
localparam logic resp_always_ready = 0;

// Assignments generated for C++ channel arrays
assign run_core_ready_s = run_core_ready;
assign run_core_req = run_core_req_s;
assign run_core_data = run_core_data_s;
assign resp_core_ready = resp_core_ready_s;
assign resp_core_req_s = resp_core_req;
assign resp_core_data_s = resp_core_data;
assign run_clk = clk;
assign run_nrst = nrst;
assign resp_clk = clk;
assign resp_nrst = nrst;

//------------------------------------------------------------------------------
// Method process: run_ready_control (sct_target.h:244:5) 

always_comb 
begin : run_ready_control     // sct_target.h:244:5
    logic A;
    A = run_get_req_d;
    run_core_ready = A || !run_reg_full;
end

//------------------------------------------------------------------------------
// Method process: run_full_control (sct_target.h:249:5) 

always_comb 
begin : run_full_control     // sct_target.h:249:5
    logic A;
    A = run_get_req_d;
    if (A)
    begin
        run_reg_full = 0;
    end else begin
        if (run_core_req_d)
        begin
            run_reg_full = 1;
        end else begin
            run_reg_full = run_reg_full_d;
        end
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: run_core_thread (sct_target.h:261:5) 

// Thread-local variables
logic run_get_req_d_next;
logic run_core_req_d_next;
logic run_reg_full_d_next;
logic [15:0] run_core_data_d_next;

// Next-state combinational logic
always_comb begin : run_core_thread_comb     // sct_target.h:261:5
    run_core_thread_func;
end
function void run_core_thread_func;
    run_core_data_d_next = run_core_data_d;
    run_core_req_d_next = run_core_req_d;
    run_get_req_d_next = run_get_req_d;
    run_reg_full_d_next = run_reg_full_d;
    run_get_req_d_next = run_get_req;
    run_core_req_d_next = run_core_req;
    run_reg_full_d_next = run_reg_full;
    if (run_core_req && !run_reg_full)
    begin
        run_core_data_d_next = run_core_data;
    end
endfunction

// Synchronous register update
always_ff @(posedge run_clk or negedge run_nrst) 
begin : run_core_thread_ff
    if ( ~run_nrst ) begin
        run_get_req_d <= 0;
        run_core_req_d <= 0;
        run_reg_full_d <= 0;
        run_core_data_d <= 0;
    end
    else begin
        run_get_req_d <= run_get_req_d_next;
        run_core_req_d <= run_core_req_d_next;
        run_reg_full_d <= run_reg_full_d_next;
        run_core_data_d <= run_core_data_d_next;
    end
end

//------------------------------------------------------------------------------
// Method process: run_put_to_fifo (sct_target.h:230:5) 
// Empty process, no code generated 

//------------------------------------------------------------------------------
// Clocked THREAD: resp_sync_thread (sct_initiator.h:207:5) 

// Thread-local variables
logic resp_put_req_next;
logic [15:0] resp_core_data_next;

// Next-state combinational logic
always_comb begin : resp_sync_thread_comb     // sct_initiator.h:207:5
    resp_sync_thread_func;
end
function void resp_sync_thread_func;
    logic A;
    resp_core_data_next = resp_core_data;
    resp_put_req_next = resp_put_req;
    A = resp_sync_req;
    if (A && resp_core_ready)
    begin
        resp_put_req_next = !resp_put_req;
        resp_core_data_next = resp_sync_data;
    end
endfunction

// Synchronous register update
always_ff @(posedge resp_clk or negedge resp_nrst) 
begin : resp_sync_thread_ff
    if ( ~resp_nrst ) begin
        resp_put_req <= 0;
        resp_core_data <= 0;
    end
    else begin
        resp_put_req <= resp_put_req_next;
        resp_core_data <= resp_core_data_next;
    end
end

//------------------------------------------------------------------------------
// Method process: resp_req_control (sct_initiator.h:228:5) 

always_comb 
begin : resp_req_control     // sct_initiator.h:228:5
    logic A;
    A = resp_put_req != resp_put_req_d;
    if (A)
    begin
        resp_core_req = 1;
    end else begin
        if (resp_core_ready_d)
        begin
            resp_core_req = 0;
        end else begin
            resp_core_req = resp_core_req_d;
        end
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: resp_core_thread (sct_initiator.h:244:5) 

// Thread-local variables
logic resp_put_req_d_next;
logic resp_core_req_d_next;
logic resp_core_ready_d_next;

// Next-state combinational logic
always_comb begin : resp_core_thread_comb     // sct_initiator.h:244:5
    resp_core_thread_func;
end
function void resp_core_thread_func;
    resp_core_ready_d_next = resp_core_ready_d;
    resp_core_req_d_next = resp_core_req_d;
    resp_put_req_d_next = resp_put_req_d;
    resp_put_req_d_next = resp_put_req;
    resp_core_req_d_next = resp_core_req;
    resp_core_ready_d_next = resp_core_ready;
endfunction

// Synchronous register update
always_ff @(posedge resp_clk or negedge resp_nrst) 
begin : resp_core_thread_ff
    if ( ~resp_nrst ) begin
        resp_put_req_d <= 0;
        resp_core_req_d <= 0;
        resp_core_ready_d <= 0;
    end
    else begin
        resp_put_req_d <= resp_put_req_d_next;
        resp_core_req_d <= resp_core_req_d_next;
        resp_core_ready_d <= resp_core_ready_d_next;
    end
end

//------------------------------------------------------------------------------
// Method process: methProc (method_test.h:44:5) 

always_comb 
begin : methProc     // method_test.h:44:5
    logic TMP_0;
    logic TMP_1;
    logic [15:0] TMP_2;
    logic A;
    logic TMP_3;
    logic [15:0] TMP_5;
    ss = 0;
    // Call reset_get() begin
    run_get_req = 0;
    // Call reset_get() end
    // Call reset_put() begin
    resp_sync_req = 0;
    resp_sync_data = 0;
    // Call reset_put() end
    // Call request() begin
    TMP_0 = run_core_req || run_reg_full;
    // Call request() end
    // Call ready() begin
    TMP_1 = resp_core_ready;
    // Call ready() end
    if (TMP_0 && TMP_1)
    begin
        // Call get() begin
        A = (run_core_req || run_reg_full);
        if (A)
        begin
            run_get_req = 1;
        end else begin
            run_get_req = 0;
        end
        if (run_reg_full)
        begin
            TMP_2 = run_core_data_d;
        end else begin
            TMP_2 = run_core_data;
        end
        // Call get() end
        // Call put() begin
        if (resp_core_ready)
        begin
            resp_sync_req = 1;
            resp_sync_data = TMP_2;
            TMP_3 = 1;
        end else begin
            resp_sync_req = 0;
            resp_sync_data = 0;
            TMP_3 = 0;
        end
        // Call put() end
        // Call peek() begin
        if (run_reg_full)
        begin
            TMP_5 = run_core_data_d;
        end else begin
            TMP_5 = run_core_data;
        end
        // Call peek() end
        ss = TMP_5;
    end
    out = in;
end

`ifndef INTEL_SVA_OFF
sctAssertLine63 : assert property (
    @(posedge clk) |in |-> |out );
`endif // INTEL_SVA_OFF

endmodule


