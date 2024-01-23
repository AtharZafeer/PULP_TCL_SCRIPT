// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2 (lin64) Build 4029153 Fri Oct 13 20:13:54 MDT 2023
// Date        : Tue Jan 23 20:22:37 2024
// Host        : compute running 64-bit Ubuntu 22.04.1 LTS
// Command     : write_verilog -mode funcsim -nolib -force -file
//               /home/azafeer/Desktop/test/small_des/small_des.sim/sim_1/synth/func/xsim/tb_D_FLIPFLOP_func_synth.v
// Design      : D_FLIPFLOP
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xczu9eg-ffvb1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module dbg_hub_CV
   (clk,
    sl_iport0_o,
    sl_oport0_i);
  input clk;
  output [36:0]sl_iport0_o;
  input [16:0]sl_oport0_i;


endmodule

module u_ila_0_CV
   (clk,
    probe0,
    SL_IPORT_I,
    SL_OPORT_O,
    probe1,
    probe2,
    probe3,
    probe4,
    probe5,
    probe6);
  input clk;
  input [0:0]probe0;
  input [36:0]SL_IPORT_I;
  output [16:0]SL_OPORT_O;
  input [0:0]probe1;
  input [0:0]probe2;
  input [0:0]probe3;
  input [0:0]probe4;
  input [0:0]probe5;
  input [0:0]probe6;


endmodule

(* NotValidForBitStream *)
module D_FLIPFLOP
   (clk,
    d,
    clear,
    rst,
    q,
    made_up_gnd_port);
  input clk;
  input d;
  input clear;
  input rst;
  output q;
  inout [0:1]made_up_gnd_port;

  wire clear;
  wire clear_IBUF;
  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire d;
  wire d_IBUF;
  wire q;
  wire q_OBUF;
  wire q_i_1_n_0;
  wire q_i_2_n_0;
  wire q_reg_and1or_net;
  wire q_reg_and2or_net;
  wire q_reg_mux_sel_net;
  wire q_reg_muxo2d_net;
  wire q_reg_or2mux_net;
  wire rst;
  wire rst_IBUF;
  wire [36:0]sl_iport0_o_0;
  wire [16:0]sl_oport0_i_0;
PULLDOWN pulldown_q
       (.O(q));
PULLDOWN pulldown_made_up_gnd_port_1
       (.O(made_up_gnd_port[1]));
PULLDOWN pulldown_q_reg_mux_sel_net
       (.O(q_reg_mux_sel_net));

  IBUF clear_IBUF_inst
       (.I(clear),
        .O(clear_IBUF));
  (* XILINX_LEGACY_PRIM = "BUFG" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:CE" *) 
  BUFGCE #(
    .CE_TYPE("ASYNC"),
    .SIM_DEVICE("ULTRASCALE_PLUS"),
    .STARTUP_SYNC("FALSE")) 
    clk_IBUF_BUFG_inst
       (.CE(1'b1),
        .I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  IBUF d_IBUF_inst
       (.I(d),
        .O(d_IBUF));
  (* DEBUG_CORE_INFO = "dbg_hub,labtools_xsdbm_v3_00_a,{C_BSCAN_MODE=false,C_BSCAN_MODE_WITH_CORE=false,C_CLK_INPUT_FREQ_HZ=300000000,C_ENABLE_CLK_DIVIDER=false,C_EN_BSCANID_VEC=false,C_NUM_BSCAN_MASTER_PORTS=0,C_TWO_PRIM_MODE=false,C_USER_SCAN_CHAIN=1,C_USE_EXT_BSCAN=false,C_XSDB_NUM_SLAVES=1,component_name=dbg_hub_CV}" *) 
  (* DEBUG_PORT_clk = "" *) 
  (* IS_DEBUG_CORE *) 
  dbg_hub_CV dbg_hub
       (.clk(clk_IBUF_BUFG),
        .sl_iport0_o(sl_iport0_o_0),
        .sl_oport0_i(sl_oport0_i_0));
  OBUF q_OBUF_inst
       (.I(q_OBUF),
        .O(q));
  LUT2 #(
    .INIT(4'h2)) 
    q_i_1
       (.I0(d_IBUF),
        .I1(clear_IBUF),
        .O(q_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    q_i_2
       (.I0(rst_IBUF),
        .O(q_i_2_n_0));
  FDCE #(
    .INIT(1'b0)) 
    q_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(q_i_2_n_0),
        .D(q_reg_muxo2d_net),
        .Q(q_OBUF));
  OR2L q_reg_OR
       (.DI(q_reg_and1or_net),
        .O(q_reg_or2mux_net),
        .SRI(q_reg_and2or_net));
  AND2B1L #(
    .IS_SRI_INVERTED(1'b1)) 
    q_reg_and1
       (.DI(q_i_1_n_0),
        .O(q_reg_and1or_net),
        .SRI(made_up_gnd_port[0]));
  AND2B1L #(
    .IS_SRI_INVERTED(1'b1)) 
    q_reg_and2
       (.DI(made_up_gnd_port[0]),
        .O(q_reg_and2or_net),
        .SRI(q_i_1_n_0));
  MUXF7 q_reg_mux
       (.I0(q_i_1_n_0),
        .I1(q_reg_or2mux_net),
        .O(q_reg_muxo2d_net),
        .S(made_up_gnd_port[0]));
  IBUF rst_IBUF_inst
       (.I(rst),
        .O(rst_IBUF));
  (* DEBUG_CORE_INFO = "u_ila_0,labtools_ila_v6_00_a,{ALL_PROBE_SAME_MU=true,ALL_PROBE_SAME_MU_CNT=2,C_ADV_TRIGGER=false,C_DATA_DEPTH=1024,C_EN_STRG_QUAL=true,C_INPUT_PIPE_STAGES=0,C_NUM_OF_PROBES=7,C_PROBE0_TYPE=0,C_PROBE0_WIDTH=1,C_PROBE1_TYPE=0,C_PROBE1_WIDTH=1,C_PROBE2_TYPE=0,C_PROBE2_WIDTH=1,C_PROBE3_TYPE=0,C_PROBE3_WIDTH=1,C_PROBE4_TYPE=0,C_PROBE4_WIDTH=1,C_PROBE5_TYPE=0,C_PROBE5_WIDTH=1,C_PROBE6_TYPE=0,C_PROBE6_WIDTH=1,C_TRIGIN_EN=0,C_TRIGOUT_EN=0,component_name=u_ila_0_CV}" *) 
  (* DEBUG_PORT_clk = "n:clk_IBUF_BUFG" *) 
  (* DEBUG_PORT_probe0 = "n:clk_IBUF_BUFG" *) 
  (* DEBUG_PORT_probe1 = "n:q_i_1_n_0" *) 
  (* DEBUG_PORT_probe2 = "n:q_reg_mux_sel_net" *) 
  (* DEBUG_PORT_probe3 = "n:q_reg_and1or_net" *) 
  (* DEBUG_PORT_probe4 = "n:q_reg_and2or_net" *) 
  (* DEBUG_PORT_probe5 = "n:q_reg_muxo2d_net" *) 
  (* DEBUG_PORT_probe6 = "n:q_reg_or2mux_net" *) 
  (* IS_DEBUG_CORE *) 
  u_ila_0_CV u_ila_0
       (.SL_IPORT_I(sl_iport0_o_0),
        .SL_OPORT_O(sl_oport0_i_0),
        .clk(clk_IBUF_BUFG),
        .probe0(clk_IBUF_BUFG),
        .probe1(q_i_1_n_0),
        .probe2(made_up_gnd_port[0]),
        .probe3(q_reg_and1or_net),
        .probe4(q_reg_and2or_net),
        .probe5(q_reg_muxo2d_net),
        .probe6(q_reg_or2mux_net));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
